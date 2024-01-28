Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

Library STD;
use STD.textio.all;

entity mux_8to1 is
	port (A : in bit_vector (7 downto 0);
			Sel : in bit_vector (2 downto 0);
			F : out bit);
end entity;

architecture mux_8to1_arch of mux_8to1 is
	begin
		F <= (A(0) and not Sel(2) and not Sel(1) and not Sel(0)) or
		(A(1) and not Sel(2) and not Sel(1) and Sel(0)) or
		(A(2) and not Sel(2) and Sel(1) and not Sel(0)) or
		(A(3) and not Sel(2) and Sel(1) and Sel(0)) or
		(A(4) and Sel(2) and not Sel(1) and not Sel(0)) or
		(A(5) and Sel(2) and not Sel(1) and Sel(0)) or
		(A(6) and Sel(2) and Sel(1) and not Sel(0)) or
		(A(7) and Sel(2) and Sel(1) and Sel(0));
end architecture;

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

Library STD;
use STD.textio.all;

entity mux_8to1_TB is
end entity;

architecture mux_8to1_TB_arch of mux_8to1_TB is
	component mux_8to1 is
		port (A : in bit_vector (7 downto 0);
				Sel : in bit_vector (2 downto 0);
				F : out bit);
	end component;

	signal A_TB : bit_vector (7 downto 0);
	signal Sel_TB : bit_vector (2 downto 0);
	signal F_TB : bit;

	begin
		
		DUT1 : mux_8to1 port map (A => A_TB, Sel => Sel_TB, F => F_TB);

		STIMULUS : process

		file Fout : TEXT open WRITE_MODE is "output_vector.txt";
		file Fin : TEXT open READ_MODE is "input_vector.txt";
		variable current_wline : line;
		variable current_rline : line;
		variable current_a : bit_vector (7 downto 0);
		variable current_sel : bit_vector (2 downto 0);

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
			