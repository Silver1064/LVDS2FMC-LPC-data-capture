--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
--Date        : Wed Nov  6 19:59:01 2024
--Host        : DESKTOP-KKO2LTN running 64-bit major release  (build 9200)
--Command     : generate_target ILA.bd
--Design      : ILA
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ILA is
  port (
    CLK : in STD_LOGIC;
    DA_out : in STD_LOGIC_VECTOR ( 11 downto 0 );
    DB_out : in STD_LOGIC_VECTOR ( 11 downto 0 );
    DCLK_done : in STD_LOGIC_VECTOR ( 0 to 0 );
    DCLK_reg : in STD_LOGIC_VECTOR ( 5 downto 0 );
    FCLK_done : in STD_LOGIC_VECTOR ( 0 to 0 );
    FCLK_reg : in STD_LOGIC_VECTOR ( 5 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of ILA : entity is "ILA,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=ILA,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of ILA : entity is "ILA.hwdef";
end ILA;

architecture STRUCTURE of ILA is
  component ILA_ila_0_0 is
  port (
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    probe1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    probe2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe3 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe4 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    probe5 : in STD_LOGIC_VECTOR ( 5 downto 0 )
  );
  end component ILA_ila_0_0;
  signal clk_0_1 : STD_LOGIC;
  signal probe0_0_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal probe1_0_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal probe2_0_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal probe3_0_1 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal probe4_0_1 : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal probe5_0_1 : STD_LOGIC_VECTOR ( 5 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of CLK : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of CLK : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN ILA_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
begin
  clk_0_1 <= CLK;
  probe0_0_1(11 downto 0) <= DA_out(11 downto 0);
  probe1_0_1(11 downto 0) <= DB_out(11 downto 0);
  probe2_0_1(0) <= DCLK_done(0);
  probe3_0_1(0) <= FCLK_done(0);
  probe4_0_1(5 downto 0) <= DCLK_reg(5 downto 0);
  probe5_0_1(5 downto 0) <= FCLK_reg(5 downto 0);
ila_0: component ILA_ila_0_0
     port map (
      clk => clk_0_1,
      probe0(11 downto 0) => probe0_0_1(11 downto 0),
      probe1(11 downto 0) => probe1_0_1(11 downto 0),
      probe2(0) => probe2_0_1(0),
      probe3(0) => probe3_0_1(0),
      probe4(5 downto 0) => probe4_0_1(5 downto 0),
      probe5(5 downto 0) => probe5_0_1(5 downto 0)
    );
end STRUCTURE;
