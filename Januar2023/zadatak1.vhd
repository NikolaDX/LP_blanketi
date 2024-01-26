Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

Library STD;
use STD.textio.all;


entity demux_1to8 is
	port (A : in bit;
		Sel : in bit_vector(2 downto 0);
		F : out bit_vector(7 downto 0));
end entity;

architecture demux_1to8_arch of demux_1to8 is
begin
	F(7) <= A and Sel(2) and Sel(1) and Sel(0);
	F(6) <= A and Sel(2) and Sel(1) and not Sel(0);
	F(5) <= A and Sel(2) and not Sel(1) and Sel(0);
	F(4) <= A and Sel(2) and not Sel(1) and not Sel(0);
	F(3) <= A and not Sel(2) and Sel(1) and Sel(0);
	F(2) <= A and not Sel(2) and Sel(1) and not Sel(0);
	F(1) <= A and not Sel(2) and not Sel(1) and Sel(0);
	F(0) <= A and not Sel(2) and not Sel(1) and not Sel(0);
end architecture;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

Library STD;
use STD.textio.all;

entity demux_1to8_TB is
end entity;

architecture demux_1to8_TB_arch of demux_1to8_TB is
component demux_1to8 is
	port (A : in bit;
		Sel : in bit_vector(2 downto 0);
		F : out bit_vector(7 downto 0));
end component;

	signal A_TB : bit;
	signal Sel_TB : bit_vector(2 downto 0);
	signal F_TB : bit_vector(7 downto 0);

begin

	DUT1 : demux_1to8 port map (A => A_TB, Sel => Sel_TB, F => F_TB);

	STIMULUS : process

	file Fout : TEXT open WRITE_MODE is "izlaz.txt";
	file Fin: TEXT open READ_MODE is "ulaz.txt";
	variable current_wline : line;
	variable current_rline : line;
	variable current_a : bit;
	variable current_sel : bit_vector(2 downto 0);
	
	begin
	
	write(current_wline, string'("Input=A,Sel; Output=F"));
	writeline(Fout, current_wline);

	for i in 0 to 2 loop
		readline(Fin, current_rline);
		read(current_rline, current_a);
		A_TB <= current_a;
		wait for 10 ns;
		readline(Fin, current_rline);
		read(current_rline, current_sel);
		Sel_TB <= current_sel;
		wait for 10 ns;
		write(current_wline, string'("A="));
		write(current_wline, A_TB);
		write(current_wline, string'(" Sel="));
		write(current_wline, Sel_TB);
		write(current_wline, string'(" F="));
		write(current_wline, F_TB);
		writeline(Fout, current_wline);
	end loop;
	wait;
	end process;
end architecture;
	
	