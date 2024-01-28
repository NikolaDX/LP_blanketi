Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;

entity rom_4x4_async is
	port (address : in std_logic_vector (1 downto 0);
		data_out : out std_logic_vector (3 downto 0));
end entity;

architecture rom_4x4_async_arch of rom_4x4_async is
	type ROM_type is array (0 to 3) of std_logic_vector(3 downto 0);

	constant ROM : ROM_type := (0 => x"E",
				1 => x"2",
				2 => x"F",
				3 => x"4");
	
	begin

		data_out <= ROM(to_integer(unsigned(address)));
end architecture;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;

entity rom_4x4_async_TB is
end entity;

architecture rom_4x4_async_TB_arch of rom_4x4_async_TB is
	component rom_4x4_async is
		port (address : in std_logic_vector (1 downto 0);
			data_out : out std_logic_vector (3 downto 0));
	end component;

	signal address_TB : std_logic_vector (1 downto 0);
	signal data_out_TB : std_logic_vector (3 downto 0);

	begin
		
		DUT1 : rom_4x4_async port map (address => address_TB, data_out => data_out_TB);

		STIMULUS : process

		begin
			for i in 0 to 3 loop
				address_TB <= std_logic_vector(to_unsigned(i, 2));
				report "address= " & to_string(address_TB) & " data_out= " & to_string(data_out_TB);
				wait for 30 ns;
			end loop;
		end process;
end architecture;