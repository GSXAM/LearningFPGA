----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2022 06:55:25 PM
-- Design Name: 
-- Module Name: tb_ALU - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ALU is
--  Port ( );
end tb_ALU;

architecture Behavioral of tb_ALU is

component ALU_4bit is
  Port ( Din0, Din1 : in STD_LOGIC_VECTOR (3 downto 0); -- input data
         Sel : in STD_LOGIC_VECTOR (1 downto 0);  -- add, sub, and, or : 00, 01, 10, 11
         SS: in STD_LOGIC; -- control signed(1) or unsigned number(0)
         DIO: in STD_LOGIC; -- Display input(0) or output(1) number
         LED : out STD_LOGIC_VECTOR (3 downto 0); -- Select led output
         clk : in STD_LOGIC; -- clock in 100Mhz
         Seg7 : out STD_LOGIC_VECTOR (6 downto 0); -- data decode for 7-seg
         Carryout : out STD_LOGIC; -- Carry out flag (for unsigned number)
         Overflow : out STD_LOGIC -- Overflow flag (for signed number)
         );
end component;

signal Din0, Din1, LED : STD_LOGIC_VECTOR (3 downto 0);
signal Sel: STD_LOGIC_VECTOR (1 downto 0);
signal Seg7 : std_logic_vector(6 downto 0);
signal SS, DIO, carryout, overflow, clk : std_logic;
constant delay : time := 30ns;
begin
    
tb_alu: ALU_4bit port map ( Din0=>Din0,
                            Din1=>Din1,
                            clk=>clk,
                            LED=>LED,
                            Sel=>Sel,
                            Seg7=>Seg7,
                            SS=>SS,
                            DIO=>DIO,
                            Carryout=>Carryout,
                            overflow=>overflow
                            );

Clock_source: process
begin
    clk <= '0';
    wait for 1ps;
    clk <= '1';
    wait for 1ps;
end process;

process
begin
-- unsigned mode, view input
    SS <= '0'; DIO <= '0';
-- test AND operator
    Din0 <= x"0"; Din1 <= x"1"; sel <= "10";
    wait for delay;
    DIO <= '1'; -- view output
    wait for delay;
    Din0 <= x"1";
    wait for delay;
-- test OR operator
    Din1 <= x"2"; sel <= "11";
    wait for delay;
-- test Adder unsigned
    sel <= "00"; SS <= '0'; DIO <= '0'; -- view input
    wait for delay;
    DIO <= '1'; -- view ouput
    wait for delay;
    Din0 <= x"a"; Din1 <= x"6"; -- carryout
    wait for delay;
-- test Subtractor unsigned
    sel <= "01"; Din0 <= x"9"; Din1 <= x"3";
    wait for delay;
    Din0 <= x"1"; Din1 <= x"3"; -- wrong number (signed)
    wait for delay;
-- test adder signed
    sel <= "00"; Din0 <= x"2"; Din1 <= x"4"; SS <= '1';
    wait for delay;
    Din0 <= x"4"; -- overflow
    wait for delay;
    Din0 <= x"e"; Din1 <= x"f";
    wait for delay;
    Din0 <= x"4";
    wait for delay;
-- test sub signed
    sel <= "01"; Din0 <= x"3"; Din1 <= x"1";
    wait for delay;
    Din0 <= x"8";
    wait for delay;
    Din0 <= x"f"; Din1 <= x"e";
    wait for delay;
    Din1 <= x"8";
    wait;
end process;
end Behavioral;


--architecture Behavioral of tb_ALU is

--component Display7seg is
--    port ( clk : in STD_LOGIC;
--           output, input0, input1 : in STD_LOGIC_VECTOR (3 downto 0);
--           SS, DIO : in STD_LOGIC;
--           Seg7 : out STD_LOGIC_VECTOR (6 downto 0);
--           LED : out STD_LOGIC_VECTOR (3 downto 0)
--           );
--end component;

--signal clk, SS, DIO: std_logic;
--signal output, input0, input1, LED: STD_LOGIC_VECTOR (3 downto 0);
--signal Seg7 : STD_LOGIC_VECTOR (6 downto 0);
--constant delay : time := 50ns;
--begin
--    tb_display: Display7seg port map( clk=>clk, output=>output,
--                                      input0=>input0, input1=>input1,
--                                      SS=>SS, DIO=>DIO,
--                                      Seg7=>Seg7,
--                                      LED=>LED
--                                      );
                                              
--    Clock_source: process
--    begin
--        clk <= '0';
--        wait for 1ps;
--        clk <= '1';
--        wait for 1ps;
--    end process;
    
--    tb_sweep: process
--    begin
--        SS <= '0'; DIO <= '0'; output <= x"4"; input0 <= x"1"; input1 <= x"8";
--        wait for delay;
--        output <= x"a"; input0 <= x"b"; input1 <= x"f";
--        wait for delay;
--        DIO <= '1';
--        wait for delay;
--        output <= x"6"; input0 <= x"7"; input1 <= x"0";
--        wait for delay;
--        SS <= '1'; DIO <= '0'; output <= x"c"; input0 <= x"2"; input1 <= x"4";
--        wait for delay;
--        output <= x"3"; input0 <= x"d"; input1 <= x"e";
--        wait for delay;
--        DIO <= '1';
--        wait for delay;
--        output <= x"d"; input0 <= x"3"; input1 <= x"1";
--        wait for delay;
--        wait;
--    end process;
    
--end Behavioral;