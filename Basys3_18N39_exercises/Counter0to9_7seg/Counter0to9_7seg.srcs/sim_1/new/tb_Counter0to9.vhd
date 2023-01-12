----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2022 11:34:42 AM
-- Design Name: 
-- Module Name: tb_Counter0to9 - Behavioral
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

entity tb_Counter0to9 is
--  Port ( );
end tb_Counter0to9;

architecture Behavioral of tb_Counter0to9 is
component Counter100_updown is
    Port ( clk_100Mhz, RESET, DIR : in STD_LOGIC; -- clock 100MHz
           Seg7: out STD_LOGIC_VECTOR (6 downto 0); -- Data output
           LED : out STD_LOGIC_VECTOR (3 downto 0)); -- Signal for LED sweep control
end component;

--component clock_divider_100MHz_to_1Hz is
--    Port ( clk_100Mhz : in  STD_LOGIC;	-- 100 MHz in clock
--           reset : in  STD_LOGIC;
--           clk_1Hz : out  STD_LOGIC);	-- 1Hz out clock
--end component;

--signal clk_100Mhz, reset, clk_1Hz: std_logic;

signal clk_100Mhz, RESET, DIR: std_logic;
signal Seg7: STD_LOGIC_VECTOR (6 downto 0);
signal LED : STD_LOGIC_VECTOR (3 downto 0);

begin
tb_counter100: Counter100_updown port map(clk_100Mhz => clk_100Mhz,
                                          RESET => RESET,
                                          DIR => DIR,
                                          Seg7=>Seg7,
                                          LED=>LED);

--tb_clock_1Hz: clock_divider_100MHz_to_1Hz port map(clk_100Mhz=>clk_100Mhz, reset=>reset, clk_1Hz=>clk_1Hz);

Clock_source: process
begin
    clk_100Mhz <= '1';
    wait for 1ns;
    clk_100Mhz <= not(clk_100Mhz);
    wait for 1ns;
end process;

Counter_up_down: process
begin
    RESET <= '1'; DIR <= '0';
    wait for 1us;
    reset <= '0';
    wait for 30us;
    DIR <= '1';
    wait for 40us;
    reset <= '1';
    wait;
end process;

end Behavioral;
