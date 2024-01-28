entity encoder_8to3_binary is
	port (A : in bit_vector (7 downto 0);
		F : out bit_vector (2 downto 0));
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

architecture encoder_8to3_binary_TB_arch of encoder_8to3_binary_TB is
	component encoder_8to3_binary is
		port (A : in bit_vector (7 downto 0);
			F : out bit_vector (2 downto 0));
	end component;

	signal A_TB : bit_vector (7 downto 0);
	signal F_TB : bit_vector (2 downto 0);

	begin

		DUT1 : encoder_8to3_binary port map (A => A_TB, F => F_TB);

		STIMULUS : process

		begin

		A_TB <= "00000100"; wait for 100 ps;
		A_TB <= "00100000"; wait for 100 ps;

		end process;

end architecture;