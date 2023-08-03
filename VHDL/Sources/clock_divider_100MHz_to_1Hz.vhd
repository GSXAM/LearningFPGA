library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider_100MHz_to_1Hz is
    Port ( clk : in  STD_LOGIC;	-- 100 MHz in clock
           reset : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);	-- 1Hz out clock
end clock_divider_100MHz_to_1Hz;

architecture RTL of clock_divider_100MHz_to_1Hz is
	signal temporal: STD_LOGIC := '0';
	signal counter : integer range 0 to 49999999 := 0;
begin
	frequency_divider: process (reset, clk) 
	begin
        if (reset = '1') then
            temporal <= '0';
            counter <= 0;
        elsif rising_edge(clk) then
            if (counter = 49999999) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    clk_out <= temporal;
end RTL;

