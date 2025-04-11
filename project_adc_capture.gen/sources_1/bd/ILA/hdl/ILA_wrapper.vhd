--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
--Date        : Mon Mar 24 20:46:57 2025
--Host        : DESKTOP-KKO2LTN running 64-bit major release  (build 9200)
--Command     : generate_target ILA_wrapper.bd
--Design      : ILA_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ILA_wrapper is
  port (
    CLK : in STD_LOGIC;
    DA_out : in STD_LOGIC_VECTOR ( 11 downto 0 );
    DB_out : in STD_LOGIC_VECTOR ( 11 downto 0 );
    DCLK_done : in STD_LOGIC_VECTOR ( 0 to 0 );
    DCLK_reg : in STD_LOGIC_VECTOR ( 5 downto 0 );
    FCLK_done : in STD_LOGIC_VECTOR ( 0 to 0 );
    FCLK_reg : in STD_LOGIC_VECTOR ( 5 downto 0 )
  );
end ILA_wrapper;

architecture STRUCTURE of ILA_wrapper is
  component ILA is
  port (
    CLK : in STD_LOGIC;
    DA_out : in STD_LOGIC_VECTOR ( 11 downto 0 );
    DB_out : in STD_LOGIC_VECTOR ( 11 downto 0 );
    DCLK_done : in STD_LOGIC_VECTOR ( 0 to 0 );
    FCLK_done : in STD_LOGIC_VECTOR ( 0 to 0 );
    DCLK_reg : in STD_LOGIC_VECTOR ( 5 downto 0 );
    FCLK_reg : in STD_LOGIC_VECTOR ( 5 downto 0 )
  );
  end component ILA;
begin
ILA_i: component ILA
     port map (
      CLK => CLK,
      DA_out(11 downto 0) => DA_out(11 downto 0),
      DB_out(11 downto 0) => DB_out(11 downto 0),
      DCLK_done(0) => DCLK_done(0),
      DCLK_reg(5 downto 0) => DCLK_reg(5 downto 0),
      FCLK_done(0) => FCLK_done(0),
      FCLK_reg(5 downto 0) => FCLK_reg(5 downto 0)
    );
end STRUCTURE;
