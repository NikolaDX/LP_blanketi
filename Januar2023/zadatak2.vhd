Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;

entity rw_8x2_sync is
	port (Clock : in std_logic;
			address : in std_logic_vector(2 downto 0);
			data_in : in std_logic_vector(1 downto 0);
			WE : in std_logic;
			data_out : out std_logic_vector(1 downto 0));
end entity;

architecture rw_8x2_sync_arch of rw_8x2_sync is
	type RW_type is array (0 to 7) of std_logic_vector(1 downto 0);
	signal RW : RW_type;
	
	begin

		MEMORY : process (Clock)
		begin
			if (Clock'event and Clock='1') then
				if (WE = '1') then
					RW(to_integer(unsigned(address))) <= data_in;
				else
					data_out <= RW(to_integer(unsigned(address)));
				end if;
			end if;
		end process;
end architecture;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;

entity rw_8x2_sync_TB is
end entity;

architecture rw_8x2_sync_TB_arch of rw_8x2_sync_TB is
	component rw_8x2_sync is
		port (clock : in std_logic;
				address : in std_logic_vector(2 downto 0);
				data_in : in std_logic_vector(1 downto 0);
				WE : in std_logic;
				data_out : out std_logic_vector(1 downto 0));
	end component;

	signal Clock_TB : std_logic;
	signal address_TB : std_logic_vector(2 downto 0);
	signal data_in_TB : std_logic_vector(1 downto 0);
	signal WE_TB : std_logic;
	signal data_out_TB : std_logic_vector(1 downto 0);
	
	begin

		DUT1 : rw_8x2_sync port map (Clock => Clock_TB, address => address_TB, data_in => data_in_TB, WE => WE_TB, data_out => data_out_TB);

		CLOCK_PROCESS : process
		begin
			Clock_TB <= '0'; wait for 4 ns;
			Clock_TB <= '1'; wait for 4 ns;
			Clock_TB <= '0'; wait for 4 ns;
			Clock_TB <= '1'; wait for 4 ns;
		end process;

		STIMULUS : process

		begin

			WE_TB <= '0';
			wait for 80 ns;
			for i in 0 to 7 loop
				wait until rising_edge(Clock_TB);
			address_TB <= std_logic_vector(to_unsigned(i, 3));
			wait until rising_edge(Clock_TB);
				report "address= " & to_string(address_TB) & " data_out= " & to_string(data_out_TB);
			wait for 80 ns;
			end loop;

			WE_TB <= '1';
			wait for 80 ns;
			for i in 0 to 7 loop
				wait until rising_edge(Clock_TB);
					data_in_TB <= "00";
				wait for 80 ns;
			end loop;

			WE_TB <= '0';
			wait for 80 ns;
			for i in 0 to 7 loop
				wait until rising_edge(Clock_TB);
			address_TB <= std_logic_vector(to_unsigned(i, 3));
			wait until rising_edge(Clock_TB);
				report "address= " & to_string(address_TB) & " data_out= " & to_string(data_out_TB);
			wait for 80 ns;
			end loop;
		end process;
end architecture;
