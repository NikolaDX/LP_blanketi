Library IEEE;
use IEEE.std_logic_1164.all;

entity fsm1_behavioral is
	port (Clock, Reset : in std_logic;
		  Din : in std_logic;
		  Dout : out std_logic);
end entity;

architecture fsm1_behavioral_arch of fsm1_behavioral is
	type State_Type is (Start, Midway, Done);
	signal current_state, next_state : State_Type;
	
	begin

	STATE_MEMORY : process (Clock, Reset)
		begin
			if (Reset='0') then
				current_state <= Start;
			elsif (Clock'event and Clock='1') then
				current_state <= next_state;
			end if;
	end process;

	NEXT_STATE_LOGIC : process (current_state, Din)
		begin
			case (current_state) is
				when Start => if (Din='0') then
								next_state <= Start;
							  else
								next_state <= Midway;
							  end if;
				when Midway => next_state <= Done;
				when Done => next_state <= Start;
			end case;
	end process;

	OUTPUT_LOGIC : process (current_state, Din)
		begin
			case (current_state) is
				when Done => if (Din='0') then
								Dout <= '0';
							 else
								Dout <= '1';
							 end if;
				when others => Dout <= '0';
			end case;
	end process;
end architecture;
