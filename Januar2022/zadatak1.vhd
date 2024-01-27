entity demux_1to8 is
	port (A : in bit;
		Sel : in bit_vector (2 downto 0);
		F : out bit_vector (7 downto 0));
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
		F(0) <= A and not Sel(2) and not Sel(2) and not Sel(0);
end architecture;

entity demux_1to8_TB is
end entity;

architecture demux_1to8_arch_TB of demux_1to8_TB is
	component demux_1to8 is
		port (A : in bit;
			Sel : in bit_vector (2 downto 0);
			F : out bit_vector (7 downto 0));
	end component;

	signal A_TB : bit;
	signal Sel_TB : bit_vector(2 downto 0);
	signal F_TB : bit_vector(7 downto 0);

	begin
		DUT1 : demux_1to8 port map (A => A_TB, Sel => Sel_TB, F => F_TB);

		STIMULUS : process

		begin

			A_TB <= '1'; Sel_TB <= "001"; wait for 100 ps;
			A_TB <= '1'; Sel_TB <= "011"; wait for 100 ps;
			A_TB <= '0'; Sel_TB <= "100"; wait for 100 ps;
		
		end process;
end architecture;