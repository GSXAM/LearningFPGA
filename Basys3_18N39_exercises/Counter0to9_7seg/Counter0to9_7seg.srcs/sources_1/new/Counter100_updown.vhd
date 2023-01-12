----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/23/2022 09:26:06 PM
-- Design Name: 
-- Module Name: Counter100_updown - Behavioral
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
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity Counter100_updown is
    Port ( clk_100Mhz, RESET, DIR : in STD_LOGIC; -- clock 100MHz
           Seg7: out STD_LOGIC_VECTOR (6 downto 0); -- Data output
           LED : out STD_LOGIC_VECTOR (3 downto 0)); -- Signal for LED sweep control
end Counter100_updown;

architecture Behavioral of Counter100_updown is

-- Component counter updown: counting range 0 to 9
    component Counter10_updown is
        Port ( clk, RESET, DIR : in STD_LOGIC;
               C: out STD_LOGIC;
               Q : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
-- Component clock divider 100Mhz to 1Hz
-- Purpose: Clock signal for counter
    component clock_divider_100MHz_to_1Hz is
        Port ( clk_100Mhz : in  STD_LOGIC;	-- 100 MHz in clock
               reset : in  STD_LOGIC;
               clk_1Hz : out  STD_LOGIC);	-- 1Hz out clock
    end component;
    
-- Component clock divider 100Mhz to 50Hz
-- Purpose: clock signal for LED sweep
    component clock_divider_50Hz is
        Port ( clk_100Mhz : in STD_LOGIC;
               reset : in  STD_LOGIC;
               clk_50Hz : out STD_LOGIC);
    end component;
    
-- Component 7 segments LED decoder
-- Purpose: decode counter signal
    component hex2seg is
      port (
        Din : in STD_LOGIC_VECTOR(3 downto 0);
        seg : out STD_LOGIC_VECTOR(6 downto 0)
    --    LED: out std_logic_vector(3 downto 0)
      ) ;
    end component;

type ARRAY_7bit is array (1 downto 0) of STD_LOGIC_VECTOR (6 downto 0);
type ARRAY_4bit is array (1 downto 0) of STD_LOGIC_VECTOR (3 downto 0);

signal clk_1Hz : STD_LOGIC; -- Ouput of Clock_divider_100Mhz_1Hz block
signal clk_50Hz: STD_LOGIC; -- Output of Clock_divider_100Mhz_50Hz block

signal Tens_clk : STD_LOGIC := '0'; -- Input clock signal of tens counter block
signal Q_counter : ARRAY_4bit; -- Output signal of two counter block

signal Sweep_signal: STD_LOGIC := '0'; -- Sweep signal for LED position

signal Mux2Decode : STD_LOGIC_VECTOR (3 downto 0); -- Selecting Q_counter signal for sweep LED

begin
-- Clock divider 100Mhz to 1Hz block --
    Clk_div_100Mhz_1Hz: clock_divider_100MHz_to_1Hz port map(clk_100Mhz=>clk_100Mhz, reset=> '0', clk_1Hz=>clk_1Hz);

-- Clock divider 100Mhz to 50Hz block --
    Clk_div_100Mhz_50Hz: clock_divider_50Hz port map(clk_100Mhz=>clk_100Mhz, reset=> '0', clk_50Hz=>clk_50Hz);

-- Units counter block --
    Units_counter_block: Counter10_updown port map(clk=>clk_1Hz, RESET=>RESET, DIR=>DIR, C=>Tens_clk, Q=>Q_counter(0));

-- Tens counter block --
    Tens_counter_block: Counter10_updown port map(clk=>Tens_clk, RESET=>RESET, DIR=>DIR, Q=>Q_counter(1));

-- Display control LED sub-block --
------ // Creating Sweep signal // -----
    Creating_Sweep_signal: process(clk_50Hz)
                                 begin
                                 -- Create controlling selection
                                     if (rising_edge(clk_50Hz)) then
                                         Sweep_signal <= not Sweep_signal;
                                     end if;
                                 end process;
    
------ // MUX to Decode and Sweep LED // ------
    Mux2Decode <= Q_counter(0) when Sweep_signal = '0' else Q_counter(1);
    LED <= "1110" when Sweep_signal = '0' else "1101";
    
------ // Output Hex to Seg7 block // ------
    Output_Hex2Seg7: hex2seg port map(Din=>Mux2Decode, seg=>Seg7);
    

end Behavioral;
