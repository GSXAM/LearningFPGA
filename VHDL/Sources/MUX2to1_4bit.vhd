----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2022 01:04:42 PM
-- Design Name: 
-- Module Name: MUX2to1_4bit - Behavioral
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

entity MUX2to1_4bit is
    Port ( Din0 : in STD_LOGIC_VECTOR (3 downto 0);
           Din1 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (3 downto 0));
end MUX2to1_4bit;

architecture Behavioral of MUX2to1_4bit is

begin
process(Din0, Din1, Sel)
begin
    if Sel = '1' then Dout <= Din1;
    else Dout <= Din0;
    end if ;
end process;

end Behavioral;
