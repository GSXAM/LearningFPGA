-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Fri May  6 11:01:43 2022
-- Host        : GSXAMPC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               D:/VHDL/Basys3_18N39/Counter0to9_7seg/Counter0to9_7seg.sim/sim_1/impl/func/xsim/tb_Counter0to9_func_impl.vhd
-- Design      : Counter0to9_7seg
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity clock_divider_100MHz_to_1Hz is
  port (
    CLK : out STD_LOGIC;
    temporal_reg_0 : in STD_LOGIC;
    AR : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end clock_divider_100MHz_to_1Hz;

architecture STRUCTURE of clock_divider_100MHz_to_1Hz is
  signal \^clk\ : STD_LOGIC;
  signal counter : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal \counter0_carry__0_n_0\ : STD_LOGIC;
  signal \counter0_carry__1_n_0\ : STD_LOGIC;
  signal \counter0_carry__2_n_0\ : STD_LOGIC;
  signal \counter0_carry__3_n_0\ : STD_LOGIC;
  signal \counter0_carry__4_n_0\ : STD_LOGIC;
  signal counter0_carry_n_0 : STD_LOGIC;
  signal \counter[25]_i_2_n_0\ : STD_LOGIC;
  signal \counter[25]_i_3_n_0\ : STD_LOGIC;
  signal \counter[25]_i_4_n_0\ : STD_LOGIC;
  signal \counter[25]_i_5_n_0\ : STD_LOGIC;
  signal \counter[25]_i_6_n_0\ : STD_LOGIC;
  signal \counter[25]_i_7_n_0\ : STD_LOGIC;
  signal \counter[25]_i_8_n_0\ : STD_LOGIC;
  signal counter_0 : STD_LOGIC_VECTOR ( 25 downto 0 );
  signal data0 : STD_LOGIC_VECTOR ( 25 downto 1 );
  signal temporal_i_1_n_0 : STD_LOGIC;
  signal NLW_counter0_carry_CO_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_counter0_carry__0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_counter0_carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_counter0_carry__2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_counter0_carry__3_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_counter0_carry__4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_counter0_carry__5_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_counter0_carry__5_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of counter0_carry : label is 35;
  attribute OPT_MODIFIED : string;
  attribute OPT_MODIFIED of counter0_carry : label is "SWEEP";
  attribute ADDER_THRESHOLD of \counter0_carry__0\ : label is 35;
  attribute OPT_MODIFIED of \counter0_carry__0\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \counter0_carry__1\ : label is 35;
  attribute OPT_MODIFIED of \counter0_carry__1\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \counter0_carry__2\ : label is 35;
  attribute OPT_MODIFIED of \counter0_carry__2\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \counter0_carry__3\ : label is 35;
  attribute OPT_MODIFIED of \counter0_carry__3\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \counter0_carry__4\ : label is 35;
  attribute OPT_MODIFIED of \counter0_carry__4\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \counter0_carry__5\ : label is 35;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \counter[10]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \counter[11]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \counter[12]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \counter[13]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \counter[14]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \counter[15]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \counter[16]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \counter[17]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \counter[18]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \counter[19]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \counter[1]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \counter[20]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \counter[21]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \counter[22]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \counter[23]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \counter[24]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \counter[25]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \counter[2]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \counter[3]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \counter[4]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \counter[5]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \counter[6]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \counter[7]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \counter[8]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \counter[9]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of temporal_i_1 : label is "soft_lutpair15";
begin
  CLK <= \^clk\;
counter0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => counter0_carry_n_0,
      CO(2 downto 0) => NLW_counter0_carry_CO_UNCONNECTED(2 downto 0),
      CYINIT => counter(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(4 downto 1),
      S(3 downto 0) => counter(4 downto 1)
    );
\counter0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => counter0_carry_n_0,
      CO(3) => \counter0_carry__0_n_0\,
      CO(2 downto 0) => \NLW_counter0_carry__0_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(8 downto 5),
      S(3 downto 0) => counter(8 downto 5)
    );
\counter0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter0_carry__0_n_0\,
      CO(3) => \counter0_carry__1_n_0\,
      CO(2 downto 0) => \NLW_counter0_carry__1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(12 downto 9),
      S(3 downto 0) => counter(12 downto 9)
    );
\counter0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter0_carry__1_n_0\,
      CO(3) => \counter0_carry__2_n_0\,
      CO(2 downto 0) => \NLW_counter0_carry__2_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(16 downto 13),
      S(3 downto 0) => counter(16 downto 13)
    );
\counter0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter0_carry__2_n_0\,
      CO(3) => \counter0_carry__3_n_0\,
      CO(2 downto 0) => \NLW_counter0_carry__3_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(20 downto 17),
      S(3 downto 0) => counter(20 downto 17)
    );
\counter0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter0_carry__3_n_0\,
      CO(3) => \counter0_carry__4_n_0\,
      CO(2 downto 0) => \NLW_counter0_carry__4_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(24 downto 21),
      S(3 downto 0) => counter(24 downto 21)
    );
\counter0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \counter0_carry__4_n_0\,
      CO(3 downto 0) => \NLW_counter0_carry__5_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_counter0_carry__5_O_UNCONNECTED\(3 downto 1),
      O(0) => data0(25),
      S(3 downto 1) => B"000",
      S(0) => counter(25)
    );
\counter[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => counter(0),
      O => counter_0(0)
    );
\counter[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(10),
      O => counter_0(10)
    );
\counter[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(11),
      O => counter_0(11)
    );
\counter[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(12),
      O => counter_0(12)
    );
\counter[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(13),
      O => counter_0(13)
    );
\counter[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(14),
      O => counter_0(14)
    );
\counter[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(15),
      O => counter_0(15)
    );
\counter[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(16),
      O => counter_0(16)
    );
\counter[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(17),
      O => counter_0(17)
    );
\counter[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(18),
      O => counter_0(18)
    );
\counter[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(19),
      O => counter_0(19)
    );
\counter[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(1),
      O => counter_0(1)
    );
\counter[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(20),
      O => counter_0(20)
    );
\counter[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(21),
      O => counter_0(21)
    );
\counter[22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(22),
      O => counter_0(22)
    );
\counter[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(23),
      O => counter_0(23)
    );
\counter[24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(24),
      O => counter_0(24)
    );
\counter[25]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(25),
      O => counter_0(25)
    );
\counter[25]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \counter[25]_i_3_n_0\,
      I1 => \counter[25]_i_4_n_0\,
      I2 => \counter[25]_i_5_n_0\,
      I3 => \counter[25]_i_6_n_0\,
      I4 => \counter[25]_i_7_n_0\,
      I5 => \counter[25]_i_8_n_0\,
      O => \counter[25]_i_2_n_0\
    );
\counter[25]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF7F"
    )
        port map (
      I0 => counter(15),
      I1 => counter(14),
      I2 => counter(17),
      I3 => counter(16),
      O => \counter[25]_i_3_n_0\
    );
\counter[25]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DFFF"
    )
        port map (
      I0 => counter(19),
      I1 => counter(18),
      I2 => counter(21),
      I3 => counter(20),
      O => \counter[25]_i_4_n_0\
    );
\counter[25]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
        port map (
      I0 => counter(6),
      I1 => counter(7),
      I2 => counter(9),
      I3 => counter(8),
      O => \counter[25]_i_5_n_0\
    );
\counter[25]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFF"
    )
        port map (
      I0 => counter(11),
      I1 => counter(10),
      I2 => counter(13),
      I3 => counter(12),
      O => \counter[25]_i_6_n_0\
    );
\counter[25]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => counter(3),
      I1 => counter(2),
      I2 => counter(5),
      I3 => counter(4),
      O => \counter[25]_i_7_n_0\
    );
\counter[25]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BFFFFFFFFFFFFFFF"
    )
        port map (
      I0 => counter(24),
      I1 => counter(25),
      I2 => counter(22),
      I3 => counter(23),
      I4 => counter(1),
      I5 => counter(0),
      O => \counter[25]_i_8_n_0\
    );
\counter[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(2),
      O => counter_0(2)
    );
\counter[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(3),
      O => counter_0(3)
    );
\counter[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(4),
      O => counter_0(4)
    );
\counter[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(5),
      O => counter_0(5)
    );
\counter[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(6),
      O => counter_0(6)
    );
\counter[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(7),
      O => counter_0(7)
    );
\counter[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(8),
      O => counter_0(8)
    );
\counter[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => data0(9),
      O => counter_0(9)
    );
\counter_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(0),
      Q => counter(0)
    );
\counter_reg[10]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(10),
      Q => counter(10)
    );
\counter_reg[11]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(11),
      Q => counter(11)
    );
\counter_reg[12]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(12),
      Q => counter(12)
    );
\counter_reg[13]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(13),
      Q => counter(13)
    );
\counter_reg[14]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(14),
      Q => counter(14)
    );
\counter_reg[15]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(15),
      Q => counter(15)
    );
\counter_reg[16]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(16),
      Q => counter(16)
    );
\counter_reg[17]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(17),
      Q => counter(17)
    );
\counter_reg[18]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(18),
      Q => counter(18)
    );
\counter_reg[19]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(19),
      Q => counter(19)
    );
\counter_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(1),
      Q => counter(1)
    );
\counter_reg[20]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(20),
      Q => counter(20)
    );
\counter_reg[21]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(21),
      Q => counter(21)
    );
\counter_reg[22]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(22),
      Q => counter(22)
    );
\counter_reg[23]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(23),
      Q => counter(23)
    );
\counter_reg[24]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(24),
      Q => counter(24)
    );
\counter_reg[25]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(25),
      Q => counter(25)
    );
\counter_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(2),
      Q => counter(2)
    );
\counter_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(3),
      Q => counter(3)
    );
\counter_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(4),
      Q => counter(4)
    );
\counter_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(5),
      Q => counter(5)
    );
\counter_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(6),
      Q => counter(6)
    );
\counter_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(7),
      Q => counter(7)
    );
\counter_reg[8]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(8),
      Q => counter(8)
    );
\counter_reg[9]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => counter_0(9),
      Q => counter(9)
    );
temporal_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \counter[25]_i_2_n_0\,
      I1 => \^clk\,
      O => temporal_i_1_n_0
    );
temporal_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal_reg_0,
      CE => '1',
      CLR => AR(0),
      D => temporal_i_1_n_0,
      Q => \^clk\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity hex2seg is
  port (
    Seg7_OBUF : out STD_LOGIC_VECTOR ( 6 downto 0 );
    Q : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end hex2seg;

architecture STRUCTURE of hex2seg is
begin
\Seg7_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2094"
    )
        port map (
      I0 => Q(3),
      I1 => Q(2),
      I2 => Q(0),
      I3 => Q(1),
      O => Seg7_OBUF(0)
    );
\Seg7_OBUF[1]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A4C8"
    )
        port map (
      I0 => Q(3),
      I1 => Q(2),
      I2 => Q(1),
      I3 => Q(0),
      O => Seg7_OBUF(1)
    );
\Seg7_OBUF[2]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A210"
    )
        port map (
      I0 => Q(3),
      I1 => Q(0),
      I2 => Q(1),
      I3 => Q(2),
      O => Seg7_OBUF(2)
    );
\Seg7_OBUF[3]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C214"
    )
        port map (
      I0 => Q(3),
      I1 => Q(2),
      I2 => Q(0),
      I3 => Q(1),
      O => Seg7_OBUF(3)
    );
\Seg7_OBUF[4]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5710"
    )
        port map (
      I0 => Q(3),
      I1 => Q(1),
      I2 => Q(2),
      I3 => Q(0),
      O => Seg7_OBUF(4)
    );
\Seg7_OBUF[5]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5190"
    )
        port map (
      I0 => Q(3),
      I1 => Q(2),
      I2 => Q(0),
      I3 => Q(1),
      O => Seg7_OBUF(5)
    );
\Seg7_OBUF[6]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4025"
    )
        port map (
      I0 => Q(3),
      I1 => Q(0),
      I2 => Q(2),
      I3 => Q(1),
      O => Seg7_OBUF(6)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Counter0to9_7seg is
  port (
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    up_down : in STD_LOGIC;
    LED : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Seg7 : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Counter0to9_7seg : entity is true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of Counter0to9_7seg : entity is "29cbc1fe";
end Counter0to9_7seg;

architecture STRUCTURE of Counter0to9_7seg is
  signal Seg7_OBUF : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal clk_IBUF : STD_LOGIC;
  signal clk_IBUF_BUFG : STD_LOGIC;
  signal \counter_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \counter_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \counter_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \counter_out[3]_i_1_n_0\ : STD_LOGIC;
  signal counter_out_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal reset_IBUF : STD_LOGIC;
  signal temporal : STD_LOGIC;
  signal up_down_IBUF : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \counter_out[0]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \counter_out[1]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \counter_out[2]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \counter_out[3]_i_1\ : label is "soft_lutpair16";
begin
Clock_source: entity work.clock_divider_100MHz_to_1Hz
     port map (
      AR(0) => reset_IBUF,
      CLK => temporal,
      temporal_reg_0 => clk_IBUF_BUFG
    );
\LED_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => LED(0)
    );
\LED_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => LED(1)
    );
\LED_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '1',
      O => LED(2)
    );
\LED_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => LED(3)
    );
Seg7Anode: entity work.hex2seg
     port map (
      Q(3 downto 0) => counter_out_reg(3 downto 0),
      Seg7_OBUF(6 downto 0) => Seg7_OBUF(6 downto 0)
    );
\Seg7_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Seg7_OBUF(0),
      O => Seg7(0)
    );
\Seg7_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Seg7_OBUF(1),
      O => Seg7(1)
    );
\Seg7_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Seg7_OBUF(2),
      O => Seg7(2)
    );
\Seg7_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Seg7_OBUF(3),
      O => Seg7(3)
    );
\Seg7_OBUF[4]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Seg7_OBUF(4),
      O => Seg7(4)
    );
\Seg7_OBUF[5]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Seg7_OBUF(5),
      O => Seg7(5)
    );
\Seg7_OBUF[6]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Seg7_OBUF(6),
      O => Seg7(6)
    );
clk_IBUF_BUFG_inst: unisim.vcomponents.BUFG
     port map (
      I => clk_IBUF,
      O => clk_IBUF_BUFG
    );
clk_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => clk,
      O => clk_IBUF
    );
\counter_out[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => counter_out_reg(0),
      O => \counter_out[0]_i_1_n_0\
    );
\counter_out[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => counter_out_reg(0),
      I1 => up_down_IBUF,
      I2 => counter_out_reg(1),
      O => \counter_out[1]_i_1_n_0\
    );
\counter_out[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"D2B4"
    )
        port map (
      I0 => counter_out_reg(0),
      I1 => up_down_IBUF,
      I2 => counter_out_reg(2),
      I3 => counter_out_reg(1),
      O => \counter_out[2]_i_1_n_0\
    );
\counter_out[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BF40FD02"
    )
        port map (
      I0 => up_down_IBUF,
      I1 => counter_out_reg(0),
      I2 => counter_out_reg(1),
      I3 => counter_out_reg(3),
      I4 => counter_out_reg(2),
      O => \counter_out[3]_i_1_n_0\
    );
\counter_out_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal,
      CE => '1',
      CLR => reset_IBUF,
      D => \counter_out[0]_i_1_n_0\,
      Q => counter_out_reg(0)
    );
\counter_out_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal,
      CE => '1',
      CLR => reset_IBUF,
      D => \counter_out[1]_i_1_n_0\,
      Q => counter_out_reg(1)
    );
\counter_out_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal,
      CE => '1',
      CLR => reset_IBUF,
      D => \counter_out[2]_i_1_n_0\,
      Q => counter_out_reg(2)
    );
\counter_out_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => temporal,
      CE => '1',
      CLR => reset_IBUF,
      D => \counter_out[3]_i_1_n_0\,
      Q => counter_out_reg(3)
    );
reset_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => reset,
      O => reset_IBUF
    );
up_down_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => up_down,
      O => up_down_IBUF
    );
end STRUCTURE;
