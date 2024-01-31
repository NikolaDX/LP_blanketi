entity decoder_1hot_4to16 is
	port (A : in bit_vector (3 downto 0);
		F : out bit_vector (15 downto 0));
end entity;

architecture decoder_1hot_4to16_arch of decoder_1hot_4to16 is
begin
	with (A) select
		F <= "0000000000000001" when "0000",
			 "0000000000000010" when "0001",
			 "0000000000000100" when "0010",
			 "0000000000001000" when "0011",
			 "0000000000010000" when "0100",
			 "0000000000100000" when "0101",
			 "0000000001000000" when "0110",
			 "0000000010000000" when "0111",
			 "0000000100000000" when "1000",
			 "0000001000000000" when "1001",
			 "0000010000000000" when "1010",
			 "0000100000000000" when "1011",
			 "0001000000000000" when "1100",
			 "0010000000000000" when "1101",
			 "0100000000000000" when "1110",
			 "1000000000000000" when "1111";
end architecture;

entity decoder_1hot_4to16_TB is
end entity;

architecture decoder_1hot_4to16_TB_arch of decoder_1hot_4to16_TB is
	component decoder_1hot_4to16 is
		port (A : in bit_vector (3 downto 0);
			F : out bit_vector (15 downto 0));
	end component;

	signal A_TB : bit_vector (3 downto 0);
	signal F_TB : bit_vector (15 downto 0);

	begin

		DUT1 : decoder_1hot_4to16 port map (A => A_TB, F => F_TB);

		STIMULUS : process

		begin

			A_TB <= "0010"; wait for 100 ps;
			A_TB <= "1010"; wait for 100 ps;

		end process;

end architecture;
