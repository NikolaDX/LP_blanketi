Library IEEE;
use IEEE.std_logic_1164.all;

entity Seq_Det_Behavioral is
	port (Clock, Reset : in std_logic;
			Din : in std_logic;
			Dout : out std_logic);
end entity;

architecture Seq_Det_Behavioral_arch of Seq_Det_Behavioral is
	type State_Type is (S0, S1, S2, S3);
	signal current_state, next_state : State_Type;

begin

	STATE_MEMORY : process (Clock, Reset)
		begin
				if (Reset='0') then
					current_state <= S0;
				elsif (Clock'event and Clock='1') then
					current_state <= next_state;
				end if;
	end process;

	NEXT_STATE_LOGIC : process (current_state, Din)
		begin
			case (current_state) is
				when S0 => if (Din='0') then
								next_state <= S1;
							else
								next_state <= S2;
							end if;
				when S1 => if (Din='0') then
								next_state <= S0;
							else
								next_state <= S3;
							end if;
				when S2 => if (Din='0') then
								next_state <= S3;
							else
								next_state <= S0;
							end if;
				when S3 => if (Din='0') then
								next_state <= S2;
							else
								next_state <= S1;
							end if;
			end case;
	end process;

	OUTPUT_LOGIC : process (current_state, Din)
		begin
			case (current_state) is
				when S0 => Dout <= '1';
				when S1 => Dout <= '0';
				when S2 => Dout <= '0';
				when S3 => Dout <= '0';
			end case;
	end process;

end architecture;