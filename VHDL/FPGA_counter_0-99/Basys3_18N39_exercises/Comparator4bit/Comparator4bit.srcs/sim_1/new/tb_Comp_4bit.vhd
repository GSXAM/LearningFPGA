----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2022 05:04:59 PM
-- Design Name: 
-- Module Name: tb_Comp_4bit - Behavioral
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

entity tb_Comp_4bit is
--  Port ( );
end tb_Comp_4bit;

architecture Behavioral of tb_Comp_4bit is
component Comp_4bit is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           higher : out STD_LOGIC;
           equal : out STD_LOGIC;
           lower : out STD_LOGIC);
end component;

signal a, b : STD_LOGIC_VECTOR (3 downto 0);
signal higher, lower, equal: STD_LOGIC;

begin
tb_Comparator_4bit: Comp_4bit port map (a=>a, b=>b, higher=>higher, lower=>lower, equal=>equal);

process
begin
a <= "0001"; b <= "0000";
wait for 10ns;
a <= "1010"; b <= "1110";
wait for 10ns;
a <= "1111"; b <= "1111";
wait for 10ns;
a <= "0010"; b <= "0010";
wait;
end process;

end Behavioral;
