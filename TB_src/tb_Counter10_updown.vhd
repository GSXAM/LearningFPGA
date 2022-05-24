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
component Counter10_updown is
    Port ( clk, RESET, DIR : in STD_LOGIC;
           C: out STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal clk, RESET, DIR: std_logic;
signal C: STD_LOGIC;
signal Q : STD_LOGIC_VECTOR (3 downto 0);

begin
tb_counter0to9: Counter10_updown port map(clk => clk,
                                          RESET => RESET,
                                          DIR => DIR,
                                          C => C,
                                          Q => Q);

Clock_source: process
begin
    clk <= '1';
    wait for 5ns;
    clk <= not(clk);
    wait for 5ns;
end process;

Counter_up_down: process
begin
    RESET <= '1'; DIR <= '0';
    wait for 32ns;
    reset <= '0';
    wait for 353ns;
    DIR <= '1';
    wait for 421ns;
    reset <= '1';
    wait;
end process;

end Behavioral;
