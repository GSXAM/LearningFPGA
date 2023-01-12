----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2022 01:59:31 PM
-- Design Name: 
-- Module Name: clock_divider_50Hz - Behavioral
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

entity clock_divider_50Hz is
    Port ( clk_100Mhz : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_50Hz : out STD_LOGIC);
end clock_divider_50Hz;

architecture clock_RTL of clock_divider_50Hz is
	signal temporal: STD_LOGIC;
	signal counter : integer range 0 to 999999 := 0;
begin
	frequency_divider: process (reset, clk_100Mhz) 
	begin
        if (reset = '1') then
            temporal <= '0';
            counter <= 0;
        elsif rising_edge(clk_100Mhz) then
            if (counter = 499999) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    clk_50Hz <= temporal;
end clock_RTL;