entity NOT1 is
	port (A : in bit;
		F : out bit);
end entity;

architecture NOT1_arch of NOT1 is
begin
	F <= not A;
end architecture;

entity AND4 is
	port (A, B, C, D : in bit;
		F : out bit);
end entity;

architecture AND4_arch of AND4 is
begin
	F <= A and B and C and D;
end architecture;

entity OR4 is
	port (A, B, C, D : in bit;
		F : out bit);
end entity;

architecture OR4_arch of OR4 is
begin
	F <= A or B or C or D;
end architecture;

entity System1 is
	port (A, B, C, D : in bit;
		F : out bit);
end entity;

architecture System1_arch of System1 is

component NOT1 is
	port (A : in bit;
		F : out bit);
end component;

component AND4 is
	port (A, B, C, D : in bit;
		F : out bit);
end component;

component OR4 is
	port (A, B, C, D : in bit;
		F : out bit);
end component;

	signal An, Bn, Cn, Dn : bit;
	signal m1, m3, m9, m11 : bit;
begin

	U1 : NOT1 port map (A => A, F => An);
	U2 : NOT1 port map (A => B, F => Bn);
	U3 : NOT1 port map (A => C, F => Cn);
	U4 : NOT1 port map (A => D, F => Dn);

	U5 : AND4 port map (A => An, B => Bn, C => Cn, D => D, F => m1);
	U6 : AND4 port map (A => An, B => Bn, C => C, D => D, F => m3);
	U7 : AND4 port map (A => A, B => Bn, C => Cn, D => D, F => m9);
	U8 : AND4 port map (A => A, B => Bn, C => C, D => D, F => m11);

	U9 : OR4 port map (A => m1, B => m3, C => m9, D => m11, F => F);
end architecture;

entity System1_TB is
end entity;

architecture System1_TB_arch of System1_TB is

component System1 is
	port (A, B, C, D : in bit;
		F : out bit);
end component;

	signal A_TB, B_TB, C_TB, D_TB : bit;
	signal F_TB : bit;
begin
	DUT1 : System1 port map (A => A_TB, B => B_TB, C => C_TB, D => D_TB, F => F_TB);

	STIMULUS : process

	begin

	A_TB <= '0'; B_TB <= '0'; C_TB <= '0'; D_TB <= '1'; wait for 100 ps;
	A_TB <= '0'; B_TB <= '0'; C_TB <= '1'; D_TB <= '0'; wait for 100 ps;
	A_TB <= '1'; B_TB <= '0'; C_TB <= '1'; D_TB <= '1'; wait for 100 ps;

	end process;
end architecture;