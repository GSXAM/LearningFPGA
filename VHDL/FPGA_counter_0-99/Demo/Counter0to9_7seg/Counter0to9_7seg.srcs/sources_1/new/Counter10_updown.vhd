----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2022 01:04:42 PM
-- Design Name: 
-- Module Name: Counter0to9_7seg - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter10_updown is
    Port ( clk, RESET, DIR : in STD_LOGIC;
           C: out STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end Counter10_updown;

architecture Behavioral of Counter10_updown is

signal counter_out: STD_LOGIC_VECTOR (3 downto 0) := (others => '0'); -- output buffer

begin
Counter_updown : process(clk, RESET, DIR)
begin
    if (RESET = '1') then
        counter_out <= x"0"; -- reset counter
    elsif (rising_edge(clk)) then
        if (DIR = '0') then -- DIR = 0: counter up mode
            if (counter_out = x"9") then -- counter over flow, return 0 and C = 1
                C <= '1';
                counter_out <= x"0";
            else
                C <= '0';
                counter_out <= counter_out + 1;
            end if;
        else -- DIR = 1: counter down mode
            if (counter_out = x"0") then -- counter over flow, return 9 and C = 1
                C <= '1';
                counter_out <= x"9";
            else
                C <= '0';
                counter_out <= counter_out - 1;
            end if;
        end if;
    end if;
end process ; -- end Counter_updown

Q <= counter_out; -- Net to output

end Behavioral;


