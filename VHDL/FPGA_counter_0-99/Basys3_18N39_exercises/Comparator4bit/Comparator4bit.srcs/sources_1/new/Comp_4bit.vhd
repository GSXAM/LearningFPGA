----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2021 05:01:10 PM
-- Design Name: 
-- Module Name: comp_8bit - Structure
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

entity Comp_4bit is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           higher : out STD_LOGIC;
           equal : out STD_LOGIC;
           lower : out STD_LOGIC);
end Comp_4bit;

architecture behavioral of Comp_4bit is

begin
process(a,b)
begin
    if a(3) > b(3) then higher <='1'; lower <='0'; equal <='0';
    elsif a(3) < b(3) then higher <= '0'; lower <= '1'; equal <= '0';
    elsif a(2) > b(2) then higher <= '1'; lower <= '0'; equal <= '0';
    elsif a(2) < b(2) then higher <= '0'; lower <= '1'; equal <= '0';
    elsif a(1) > b(1) then higher <= '1'; lower <= '0'; equal <= '0';
    elsif a(1) < b(1) then higher <= '0'; lower <= '1'; equal <= '0';
    elsif a(0) > b(0) then higher <= '1'; lower <= '0'; equal <= '0';
    elsif a(0) < b(0) then higher <= '0'; lower <= '1'; equal <= '0';
    else higher <= '0'; lower <= '0'; equal <= '1';
    end if;
end process;

end behavioral;
