----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2022 11:13:40 AM
-- Design Name: 
-- Module Name: tb_hex2led - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_hex2led is
--  Port ( );
end tb_hex2led;

architecture Behavioral of tb_hex2led is
component hex2led is
  port (
    Din : in STD_LOGIC_VECTOR(3 downto 0);
    seg : out STD_LOGIC_VECTOR(6 downto 0);
    LED: out std_logic_vector(3 downto 0)       -- Select LED position on board
  ) ;
end component;

signal Din, LED : STD_LOGIC_VECTOR(3 downto 0);
signal seg : STD_LOGIC_VECTOR(6 downto 0);

begin
hex2led_tb: hex2led port map (Din => Din, LED => LED, seg => seg);
process
begin
Din <= "0001"; wait for 10ns;
Din <= "0010"; wait for 10ns;
Din <= "0011"; wait for 10ns;
Din <= "0100"; wait for 10ns;
Din <= "0101"; wait for 10ns;
Din <= "0110"; wait for 10ns;
Din <= "0111"; wait for 10ns;
Din <= "1000"; wait for 10ns;
Din <= "1001"; wait for 10ns;
Din <= "1010"; wait for 10ns;
Din <= "1011"; wait for 10ns;
Din <= "1100"; wait for 10ns;
Din <= "1101"; wait for 10ns;
Din <= "1110"; wait for 10ns;
Din <= "1111"; wait for 10ns;
Din <= "0000"; wait;
end process;
end Behavioral;
