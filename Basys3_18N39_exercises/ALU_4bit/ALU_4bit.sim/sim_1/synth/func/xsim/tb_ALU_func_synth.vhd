-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Sun May  1 20:55:57 2022
-- Host        : GSXAMPC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               D:/VHDL/Basys3_18N39/ALU_4bit/ALU_4bit.sim/sim_1/synth/func/xsim/tb_ALU_func_synth.vhd
-- Design      : ALU_4bit
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ALU_4bit is
  port (
    Din0 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    Din1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    Sel : in STD_LOGIC_VECTOR ( 1 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ALU_4bit : entity is true;
end ALU_4bit;

architecture STRUCTURE of ALU_4bit is
  signal Carry_2 : STD_LOGIC;
  signal Din0_IBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Din1_IBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Dout_OBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Sel_IBUF : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \Dout_OBUF[1]_inst_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \Dout_OBUF[3]_inst_i_2\ : label is "soft_lutpair0";
begin
\Din0_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => Din0(0),
      O => Din0_IBUF(0)
    );
\Din0_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => Din0(1),
      O => Din0_IBUF(1)
    );
\Din0_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => Din0(2),
      O => Din0_IBUF(2)
    );
\Din0_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => Din0(3),
      O => Din0_IBUF(3)
    );
\Din1_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => Din1(0),
      O => Din1_IBUF(0)
    );
\Din1_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => Din1(1),
      O => Din1_IBUF(1)
    );
\Din1_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => Din1(2),
      O => Din1_IBUF(2)
    );
\Din1_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => Din1(3),
      O => Din1_IBUF(3)
    );
\Dout_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Dout_OBUF(0),
      O => Dout(0)
    );
\Dout_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => Din0_IBUF(0),
      I1 => Din1_IBUF(0),
      O => Dout_OBUF(0)
    );
\Dout_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Dout_OBUF(1),
      O => Dout(1)
    );
\Dout_OBUF[1]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"69669666"
    )
        port map (
      I0 => Din0_IBUF(1),
      I1 => Din1_IBUF(1),
      I2 => Din0_IBUF(0),
      I3 => Din1_IBUF(0),
      I4 => Sel_IBUF(0),
      O => Dout_OBUF(1)
    );
\Dout_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Dout_OBUF(2),
      O => Dout(2)
    );
\Dout_OBUF[2]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6996"
    )
        port map (
      I0 => Din0_IBUF(2),
      I1 => Sel_IBUF(0),
      I2 => Din1_IBUF(2),
      I3 => Carry_2,
      O => Dout_OBUF(2)
    );
\Dout_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Dout_OBUF(3),
      O => Dout(3)
    );
\Dout_OBUF[3]_inst_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6999669699966966"
    )
        port map (
      I0 => Din0_IBUF(3),
      I1 => Din1_IBUF(3),
      I2 => Din0_IBUF(2),
      I3 => Sel_IBUF(0),
      I4 => Din1_IBUF(2),
      I5 => Carry_2,
      O => Dout_OBUF(3)
    );
\Dout_OBUF[3]_inst_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7EA40A2"
    )
        port map (
      I0 => Sel_IBUF(0),
      I1 => Din1_IBUF(0),
      I2 => Din0_IBUF(0),
      I3 => Din1_IBUF(1),
      I4 => Din0_IBUF(1),
      O => Carry_2
    );
\Sel_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => Sel(0),
      O => Sel_IBUF(0)
    );
end STRUCTURE;
