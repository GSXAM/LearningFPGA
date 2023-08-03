----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2022 01:04:42 PM
-- Design Name: 
-- Module Name: MUX4to1_4bit_7seg - Behavioral
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

entity Mux4to1_4bit_7seg is
    Port ( Din0 : in STD_LOGIC_VECTOR (3 downto 0);
           Din1 : in STD_LOGIC_VECTOR (3 downto 0);
           Din2 : in STD_LOGIC_VECTOR (3 downto 0);
           Din3 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC_VECTOR (1 downto 0);
           
           LED : out STD_LOGIC_VECTOR (3 downto 0);
           Seg7 : out STD_LOGIC_VECTOR (6 downto 0));
end Mux4to1_4bit_7seg;

architecture Behavioral of Mux4to1_4bit_7seg is

component Mux2to1_4bit is
    Port ( Din0 : in STD_LOGIC_VECTOR (3 downto 0);
            Din1 : in STD_LOGIC_VECTOR (3 downto 0);
            Sel : in STD_LOGIC;
            Dout : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component hex2led is
    port (
      Din : in STD_LOGIC_VECTOR(3 downto 0);
      seg : out STD_LOGIC_VECTOR(6 downto 0);
      LED: out STD_LOGIC_VECTOR(3 downto 0)
    ) ;
end component;

type wire4bit is array (1 downto 0) of std_logic_vector (3 downto 0);

signal MUX2_in : wire4bit;
signal seg_in : std_logic_vector (3 downto 0);

begin

MUX0: MUX2to1_4bit port map(Din0=>Din0, Din1=>Din1, Dout=>MUX2_in(0), Sel=>Sel(0));
MUX1: MUX2to1_4bit port map(Din0=>Din2, Din1=>Din3, Dout=>MUX2_in(1), Sel=>Sel(0));
MUX2: MUX2to1_4bit port map(Din0=>MUX2_in(0), Din1=>MUX2_in(1), Dout=>seg_in, Sel=>Sel(1));

Seg7Anode: hex2led port map(Din=>seg_in, seg=>Seg7, LED=>LED);

-- LED <= "0110";

end Behavioral;
