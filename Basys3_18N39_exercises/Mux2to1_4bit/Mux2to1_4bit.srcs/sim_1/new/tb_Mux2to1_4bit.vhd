----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2022 03:23:10 PM
-- Design Name: 
-- Module Name: tb_Mux2to1_4bit - Behavioral
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

entity tb_Mux2to1_4bit is
--  Port ( );
end tb_Mux2to1_4bit;

architecture Behavioral of tb_Mux2to1_4bit is
component Mux2to1_4bit is
    Port ( Din0 : in STD_LOGIC_VECTOR (3 downto 0);
           Din1 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal Din0, Din1, Dout: std_logic_vector (3 downto 0);
signal Sel : std_logic;

begin
Mux2to1_4bit_test: Mux2to1_4bit port map(Din1=>Din1, Din0=>Din0, Dout=>Dout, Sel=>Sel);
process
begin
Din0 <= "0001"; Din1 <= "1000"; Sel <= '1';
wait for 10ns;
Din0 <= "0011"; Din1 <= "1100";
wait for 10ns;
Din0 <= "0111"; Din1 <= "1110"; Sel <= '0';
wait for 10ns;
Din0 <= "1000"; Din1 <= "1111";
wait;
end process;

end Behavioral;
