----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2022 03:22:35 PM
-- Design Name: 
-- Module Name: Mux2to1_4bit - Behavioral
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

entity Mux2to1_4bit is
    Port ( Din0 : in STD_LOGIC_VECTOR (3 downto 0);
           Din1 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (3 downto 0));
end Mux2to1_4bit;

architecture Behavioral of Mux2to1_4bit is

begin
process(Din0, Din1, Sel)
begin
    if Sel = '1' then Dout <= Din1;
    else Dout <= Din0;
    end if ;
end process;
end Behavioral;
