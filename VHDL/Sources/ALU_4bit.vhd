----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2022 01:36:26 PM
-- Design Name: 
-- Module Name: ALU_4bit - Behavioral
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

entity ALU_4bit is
  Port ( Din0, Din1 : in STD_LOGIC_VECTOR (3 downto 0); -- input data
         Sel : in STD_LOGIC_VECTOR (1 downto 0);  -- add, sub, and, or : 00, 01, 10, 11
         SS: in STD_LOGIC; -- select signed(1) or unsigned number(0)
         DIO: in STD_LOGIC; -- Display input(0) or output(1) number
         clk : in STD_LOGIC; -- clock in 100Mhz
         LED : out STD_LOGIC_VECTOR (3 downto 0) := (others => '1'); -- Select led output
         Seg7 : out STD_LOGIC_VECTOR (6 downto 0); -- data decode for 7-seg
         Carryout : out STD_LOGIC; -- Carry out flag (for unsigned number)
         Overflow : out STD_LOGIC -- Overflow flag (for signed number)
         );
end ALU_4bit;

architecture ALU_structure of ALU_4bit is

component Display7seg is
    port ( clk : in STD_LOGIC;
           output, input0, input1 : in STD_LOGIC_VECTOR (3 downto 0);
           SS, DIO : in STD_LOGIC;
           Seg7 : out STD_LOGIC_VECTOR (6 downto 0);
           LED : out STD_LOGIC_VECTOR (3 downto 0)
           );
end component;

component FA_4bit is
    port ( Din0, Din1 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC;
           Dout: out STD_LOGIC_VECTOR (3 downto 0);
           Carryout : out STD_LOGIC;
           Overflow : out STD_LOGIC
           );
end component;

signal res_AND, res_OR, res_FA, Mux_output : STD_LOGIC_VECTOR (3 downto 0); -- results AND, OR, FA
signal Cin4FA : STD_LOGIC;-- Cin for full sub/adder

begin
-- AND operator
    res_AND <= Din0 and Din1;
    
-- OR operator
    res_OR <= Din0 or Din1;

-- Full Sub/Adder 4-bit
    FA_4bit_block: FA_4bit port map( Din0=>Din0,
                                     Din1=>Din1,
                                     Sel=>Cin4FA,
                                     Dout=>res_FA,
                                     Carryout=>Carryout,
                                     Overflow=>Overflow
                                     );
-- MUX 4-1 4bit
    process(res_AND, res_OR, res_FA, Sel)
    begin
        case (Sel) is
            when "00" | "01" => Mux_output <= res_FA;
            when "10" => Mux_output <= res_AND;
            when "11" => Mux_output <= res_OR;
            when others => Mux_output <= "0000";
        end case;
    end process;

-- Cin(0) for full sub/adder
    Cin4FA <= (Sel(0) xor Sel(1)) and Sel(0);
    
-- Display LED 7-seg
    Display_sweep_LED_7seg: Display7seg port map( clk=>clk,
                                                  output=>Mux_output,
                                                  input0=>Din0,
                                                  input1=>Din1,
                                                  SS=>SS,
                                                  DIO=>DIO,
                                                  Seg7=>Seg7,
                                                  LED=>LED
                                                  );
    
end ALU_Structure; -- end ALU_4bit


--////-- Full Sub/Adder 4-bit --////--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity FA_4bit is
    port ( Din0, Din1 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC;
           Dout: out STD_LOGIC_VECTOR (3 downto 0);
           Carryout : out STD_LOGIC;
           Overflow : out STD_LOGIC
           );
end FA_4bit;

architecture FA4bit_RTL of FA_4bit is
component FA_1bit is
  port (
    A, B, Ci: in STD_LOGIC;
    Co, S: out STD_LOGIC
  ) ;
end component;

signal exDin1, buffDout: STD_LOGIC_VECTOR (3 downto 0);
signal Carry : STD_LOGIC_VECTOR (4 downto 0);

begin
-- XOR gate array to invert bit Din1
    process(Sel, Din1)
    begin
        for i in 3 downto 0 loop
            exDin1(i) <= Sel xor Din1(i);
        end loop;
    end process;
    
--FA
    ADDer: for k in 3 downto 0 generate
        FA1bit: FA_1bit port map( 
                                  A=>Din0(k),
                                  B=>exDin1(k),
                                  Ci=>Carry(k),
                                  S=>buffDout(k),
                                  Co=>Carry(k+1)
                                  );
    end generate adder;
    
--Flags and output
    Carry(0) <= Sel;
    Carryout <= Carry(4);
    Overflow <= ((not Din0(3)) and (not exDin1(3)) and (buffDout(3))) or ((not buffDout(3)) and (Din0(3)) and (exDin1(3)));
    Dout <= buffDout;
end FA4bit_RTL;


--////-- FA 1-bit --////--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity FA_1bit is
  port (
    A, B, Ci: in STD_LOGIC;
    Co, S: out STD_LOGIC
  ) ;
end FA_1bit;

architecture FA_RTL of FA_1bit is
begin
    S <= Ci xor (A xor B); --output
    Co <= (A and B) or ((A xor B) and Ci); -- carry out
end FA_RTL ;


--////-- Display control --////--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Display7seg is
    port ( clk : in STD_LOGIC;
           output, input0, input1 : in STD_LOGIC_VECTOR (3 downto 0);
           SS, DIO : in STD_LOGIC;
           Seg7 : out STD_LOGIC_VECTOR (6 downto 0);
           LED : out STD_LOGIC_VECTOR (3 downto 0)
           );
end Display7seg;

architecture Display7seg_RTL of Display7seg is

component clock_divider_100MHz_to_50Hz is
    Port ( clk : in  STD_LOGIC;	-- 100 MHz in clock
           clk_out : out  STD_LOGIC);	-- 50Hz out clock
end component;

type data7seg_array is array (3 downto 0) of STD_LOGIC_VECTOR (3 downto 0);

signal DataLED7seg : data7seg_array;
signal count : integer range 0 to 3 := 0;
signal Mux2decode: STD_LOGIC_VECTOR (3 downto 0);
signal clk_50hz : STD_LOGIC;

begin

Clock_divider_50hz: clock_divider_100MHz_to_50Hz port map( clk=>clk,
                                                           clk_out=>clk_50hz
                                                           );

Decode7seg: process(Mux2decode)
begin
    case Mux2decode is
        when x"0" => seg7 <= "1000000"; -- 1 (0x40)
        when x"1" => seg7 <= "1111001"; -- 1 (0x79)
        when x"2" => seg7 <= "0100100"; -- 2 (0x24)
        when x"3" => seg7 <= "0110000"; -- 3 (0x30)
        when x"4" => seg7 <= "0011001"; -- 4 (0x19)
        when x"5" => seg7 <= "0010010"; -- 5 (0x12)
        when x"6" => seg7 <= "0000010"; -- 6 (0x02)
        when x"7" => seg7 <= "1111000"; -- 7 (0x78)
        when x"8" => seg7 <= "0000000"; -- 8 (0x00)
        when x"9" => seg7 <= "0010000"; -- 9 (0x10)
        when x"a" => seg7 <= "0111111"; -- minus (0x3F)
        when others => seg7 <= "1111111"; -- OFF (0x7F)
    end case;
end process;

Sweep_7seg: process(DataLED7seg, clk_50hz)
begin
    if rising_edge(clk_50hz) then
        if (count = 3) then
            count <= 0;
        else
            count <= count + 1;
        end if;
    end if;
end process;
    Mux2decode <= DataLED7seg(count);
    LED <= "1110" when count = 0 else
           "1101" when count = 1 else
           "1011" when count = 2 else
           "0111";

Control_signal_7seg: process(SS, DIO, output, input0, input1)
begin
    if (SS = '0') then -- unsigned number
        if (DIO = '0') then -- input
            case input0 is
                when "1010" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"0";
                when "1011" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"1";
                when "1100" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"2";
                when "1101" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"3";
                when "1110" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"4";
                when "1111" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"5";
                when others => DataLED7seg(1) <= x"b"; DataLED7seg(0) <= input0;
            end case;
            case input1 is
                when "1010" => DataLED7seg(3) <= x"1"; DataLED7seg(2) <= x"0";
                when "1011" => DataLED7seg(3) <= x"1"; DataLED7seg(2) <= x"1";
                when "1100" => DataLED7seg(3) <= x"1"; DataLED7seg(2) <= x"2";
                when "1101" => DataLED7seg(3) <= x"1"; DataLED7seg(2) <= x"3";
                when "1110" => DataLED7seg(3) <= x"1"; DataLED7seg(2) <= x"4";
                when "1111" => DataLED7seg(3) <= x"1"; DataLED7seg(2) <= x"5";
                when others => DataLED7seg(3) <= x"b"; DataLED7seg(2) <= input1;
            end case;
        else -- output
            case output is
                when "1010" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"0";
                when "1011" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"1";
                when "1100" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"2";
                when "1101" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"3";
                when "1110" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"4";
                when "1111" => DataLED7seg(1) <= x"1"; DataLED7seg(0) <= x"5";
                when others => DataLED7seg(1) <= x"b"; DataLED7seg(0) <= output;
            end case;
            DataLED7seg(3) <= x"b"; DataLED7seg(2) <= x"b";-- LED(3), LED(2): off
        end if;
    else -- signed number
        if (DIO = '0') then -- input
            case input0 is
                when "1000" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"8";
                when "1001" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"7";
                when "1010" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"6";
                when "1011" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"5";
                when "1100" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"4";
                when "1101" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"3";
                when "1110" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"2";
                when "1111" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"1";
                when others => DataLEd7seg(1) <= x"b"; DataLED7seg(0) <= input0;
            end case;
            case input1 is
                when "1000" => DataLEd7seg(3) <= x"a"; DataLED7seg(2) <= x"8";
                when "1001" => DataLEd7seg(3) <= x"a"; DataLED7seg(2) <= x"7";
                when "1010" => DataLEd7seg(3) <= x"a"; DataLED7seg(2) <= x"6";
                when "1011" => DataLEd7seg(3) <= x"a"; DataLED7seg(2) <= x"5";
                when "1100" => DataLEd7seg(3) <= x"a"; DataLED7seg(2) <= x"4";
                when "1101" => DataLEd7seg(3) <= x"a"; DataLED7seg(2) <= x"3";
                when "1110" => DataLEd7seg(3) <= x"a"; DataLED7seg(2) <= x"2";
                when "1111" => DataLEd7seg(3) <= x"a"; DataLED7seg(2) <= x"1";
                when others => DataLEd7seg(3) <= x"b"; DataLED7seg(2) <= input1;
            end case;
        else -- output
            case output is
                when "1000" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"8";
                when "1001" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"7";
                when "1010" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"6";
                when "1011" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"5";
                when "1100" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"4";
                when "1101" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"3";
                when "1110" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"2";
                when "1111" => DataLEd7seg(1) <= x"a"; DataLED7seg(0) <= x"1";
                when others => DataLEd7seg(1) <= x"b"; DataLED7seg(0) <= output;
                DataLED7seg(3) <= x"b"; DataLED7seg(2) <= x"b";-- LED(3), LED(2): off
            end case;
        end if;
    end if;
end process;
end Display7seg_RTL;

