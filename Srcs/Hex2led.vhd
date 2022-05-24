library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity hex2seg is
  port (
    Din : in STD_LOGIC_VECTOR(3 downto 0);
    seg : out STD_LOGIC_VECTOR(6 downto 0)
--    LED: out std_logic_vector(3 downto 0)       -- Select LED position on board
  ) ;
end hex2seg;

architecture behavioral of hex2seg is
begin
--LED <= "0100";
hex2led : process( Din )
begin
    case( Din ) is
      -- common Anode
        when "0001" => seg <= "1111001"; -- 1 (0x79)
        when "0010" => seg <= "0100100"; -- 2 (0x24)
        when "0011" => seg <= "0110000"; -- 3 (0x30)
        when "0100" => seg <= "0011001"; -- 4 (0x19)
        when "0101" => seg <= "0010010"; -- 5 (0x12)
        when "0110" => seg <= "0000010"; -- 6 (0x02)
        when "0111" => seg <= "1111000"; -- 7 (0x78)
        when "1000" => seg <= "0000000"; -- 8 (0x00)
        when "1001" => seg <= "0010000"; -- 9 (0x10)
        when "1010" => seg <= "0001000"; -- A (0x08)
        when "1011" => seg <= "0000011"; -- B (0x03)
        when "1100" => seg <= "1000110"; -- C (0x46)
        when "1101" => seg <= "0100001"; -- D (0x21)
        when "1110" => seg <= "0000110"; -- E (0x06)
        when "1111" => seg <= "0001110"; -- F (0x0E)
        when others => seg <= "1000000"; -- 0 (0x40)
      -- common Cathode
        -- when "0001" => seg <= "0000110"; -- 1
        -- when "0010" => seg <= "1011011"; -- 2
        -- when "0011" => seg <= "1001111"; -- 3
        -- when "0100" => seg <= "1100110"; -- 4
        -- when "0101" => seg <= "1101101"; -- 5
        -- when "0110" => seg <= "1111101"; -- 6
        -- when "0111" => seg <= "0000111"; -- 7
        -- when "1000" => seg <= "1111111"; -- 8
        -- when "1001" => seg <= "1101111"; -- 9
        -- when "1010" => seg <= "1110111"; -- A
        -- when "1011" => seg <= "1111100"; -- B
        -- when "1100" => seg <= "0111001"; -- C
        -- when "1101" => seg <= "1011110"; -- D
        -- when "1110" => seg <= "1111001"; -- E
        -- when "1111" => seg <= "1110001"; -- F
        -- when others => seg <= "0111111"; -- 0
    end case ;
end process ; -- hex2led
end behavioral ; -- behavioral


