----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2022 04:53:47 PM
-- Design Name: 
-- Module Name: tb_Mux4to1 - Behavioral
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

entity tb_Mux4to1 is
--  Port ( );
end tb_Mux4to1;

architecture Behavioral of tb_Mux4to1 is
component Mux4to1_4bit_7seg is
    Port ( Din0 : in STD_LOGIC_VECTOR (3 downto 0);
           Din1 : in STD_LOGIC_VECTOR (3 downto 0);
           Din2 : in STD_LOGIC_VECTOR (3 downto 0);
           Din3 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC_VECTOR (1 downto 0);
           
           LED : out STD_LOGIC_VECTOR (3 downto 0);
           Seg7 : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal Din0, Din1, Din2, Din3 : std_logic_vector (3 downto 0);
signal LED: std_logic_vector(3 downto 0);
signal Sel: STD_LOGIC_VECTOR (1 downto 0);
signal Seg7 : STD_LOGIC_VECTOR (6 downto 0);

begin
tb_MUX4to1: Mux4to1_4bit_7seg port map(Din0=>Din0,
                                       Din1=>Din1,
                                       Din2=>Din2,
                                       Din3=>Din3,
                                       Sel=>Sel,
                                       LED=>LED,
                                       Seg7=>Seg7);
process
begin
Din0 <= "0001"; Din1 <= "0010"; Din2 <= "0011"; Din3 <= "0100"; Sel <= "00";
wait for 10ns;
Sel <= "01";
wait for 10ns;
Sel <= "10";
wait for 10ns;
Sel <= "11";
wait;
end process;

end Behavioral;
