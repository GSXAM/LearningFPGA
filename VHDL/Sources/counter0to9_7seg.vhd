----------------------------------------------------------------------------------
-- Company: [DUT_uni] [ETE_fac] [18DT3_class]
-- Engineer: Luong Cong Duc
-- 
-- Create Date: 04/22/2022 01:04:42 PM
-- Design Name: Counter 0 to 9 display on 7 segments LED
-- Module Name: Counter0to9_7seg - Behavioral
-- Project Name: 
-- Target Devices: Basys3_board
-- Tool Versions: Vivado 2020.1
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

entity Counter0to9_7seg is
    Port ( clk : in STD_LOGIC; -- 100Mhz in clock
           reset: in STD_LOGIC; -- reset counter
           up_down: in STD_LOGIC; -- function counter up or counter down
           LED : out STD_LOGIC_VECTOR (3 downto 0); -- LED control
           Seg7 : out STD_LOGIC_VECTOR (6 downto 0)); -- 7seg data
end Counter0to9_7seg;

architecture Behavioral of Counter0to9_7seg is

component clock_divider_100MHz_to_1Hz is
    Port ( clk : in  STD_LOGIC;	-- 100 MHz in clock
           reset : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);	-- 1Hz out clock
end component;

component hex2seg is
  port (
    Din : in STD_LOGIC_VECTOR(3 downto 0); -- 4bit in data
    seg : out STD_LOGIC_VECTOR(6 downto 0); -- 7seg data
    LED: out std_logic_vector(3 downto 0) -- Select LED position on board
  ) ;
end component;

signal clk_cnt: STD_LOGIC; -- 1Hz clock signal
signal counter_out: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

begin
Clock_source: clock_divider_100MHz_to_1Hz port map (clk=>clk, reset=>reset, clk_out=>clk_cnt);
Seg7Anode: hex2seg port map (Din=>counter_out, seg=>Seg7, LED=>LED);

Counter_updown : process(reset, clk_cnt)
begin
    if (reset = '1') then
        counter_out <= x"0";
    elsif (rising_edge(clk_cnt)) then
        if(up_down = '0')then -- count up
            counter_out <= counter_out + 1;
        else -- count down
            counter_out <= counter_out - 1;
        end if;
    end if;
end process ; -- end Counter_updown

end Behavioral;


