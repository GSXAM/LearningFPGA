----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2022 10:53:58 AM
-- Design Name: 
-- Module Name: Clock_divider_1Hz - Behavioral
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

entity clock_divider_100MHz_to_1Hz is
    Port ( clk_100Mhz : in  STD_LOGIC;	-- 100 MHz in clock
           reset : in  STD_LOGIC;
           clk_1Hz : out  STD_LOGIC);	-- 1Hz out clock
end clock_divider_100MHz_to_1Hz;

architecture clock_RTL of clock_divider_100MHz_to_1Hz is
	signal temporal: STD_LOGIC;
	signal counter : integer range 0 to 49999999 := 0;
begin
	frequency_divider: process (reset, clk_100Mhz) 
	begin
        if (reset = '1') then
            temporal <= '0';
            counter <= 0;
        elsif rising_edge(clk_100Mhz) then
            if (counter = 49999999) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    clk_1Hz <= temporal;
end clock_RTL;