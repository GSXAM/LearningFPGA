----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2022 04:01:36 PM
-- Design Name: 
-- Module Name: Clock_divider_100Hz - Behavioral
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

entity clock_divider_100MHz_to_50Hz is
    Port ( clk : in  STD_LOGIC;	-- 100 MHz in clock
           clk_out : out  STD_LOGIC);	-- 50Hz out clock
end clock_divider_100MHz_to_50Hz;

-------------------------------------------------
-- Method to calulate output frequency
--      count = clk_in / (2*clk_out)
-- Counter range is:
--      counter range = clk_out - 1
--      count = clk_out - 1
-------------------------------------------------

architecture Clock_RTL of clock_divider_100MHz_to_50Hz is
	signal temporal: STD_LOGIC := '0';
	signal counter : integer range 0 to 1000000 := 0;
begin
	frequency_divider: process (clk) 
	begin
        if rising_edge(clk) then
            if (counter = 1000) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    clk_out <= temporal;
end Clock_RTL;
