Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;

entity encoder_8to3_binary is
	port (A : in std_logic_vector(7 downto 0);
		F : out std_logic_vector(2 downto 0));
end entity;

architecture encoder_8to3_binary_arch of encoder_8to3_binary is
begin
	with (A) select
		F <= "000" when "00000001",
		     "001" when "00000010",
		     "010" when "00000100",
		     "011" when "00001000",
		     "100" when "00010000",
		     "101" when "00100000",
		     "110" when "01000000",
		     "111" when "10000000",
		     "000" when others;
end architecture;

entity encoder_8to3_binary_TB is
end entity;

entity SystemI_TB is
end entity;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

library STD;
use STD.textio.all;

architecture encoder_8to3_binary_TB_arch of encoder_8to3_binary_TB is
component encoder_8to3_binary is
	port (A : in std_logic_vector(7 downto 0);
		F : out std_logic_vector(2 downto 0));
end component;
	signal A_TB : std_logic_vector(7 downto 0);
	signal F_TB : std_logic_vector(2 downto 0);

begin
	DUT1 : encoder_8to3_binary port map (A => A_TB, F => F_TB);

	STIMULUS : process
	file Fout: TEXT open WRITE_MODE is "izlaz.txt";
	file Fin: TEXT open READ_MODE is "ulaz.txt";
	variable current_wline : line;
	variable current_rline : line;
	variable current_aux : std_logic_vector(7 downto 0);
	begin
	write(current_wline, string'("Input=A, Output=F"));
	writeline(Fout, current_wline);

	for i in 0 to 1 loop
		readline(Fin, current_rline);
		read(current_rline, current_aux);
		A_TB <= current_aux;
		wait for 10 ns;
		write(current_wline, string'("A="));
		write(current_wline, A_TB);
		write(current_wline, string'("F="));
		write(current_wline, F_TB);
		writeline(Fout, current_wline);
	end loop;
	wait;
	end process;
end architecture;



