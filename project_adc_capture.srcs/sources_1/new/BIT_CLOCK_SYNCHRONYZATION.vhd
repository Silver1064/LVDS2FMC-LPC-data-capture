library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.ALL;

entity BIT_CLOCK_SYNCHRONYZATION is
    Port (  CLK_SYS_in              : in  std_logic;
            RST                     : in  std_logic;
            Bit_clock               : in  std_logic;
            CLK_DIV_IN              : in  std_logic; --100MHZ
            CLK_IN                  : in  std_logic; --300MHZ
            Bit_clock_align_done    : out std_logic;
            CLK_DIV_OUT             : out std_logic;
            CLK_OUT                 : out std_logic;
            DCLK_reg_out            : out std_logic_vector(5 downto 0));
end BIT_CLOCK_SYNCHRONYZATION;

architecture STRUCTURE of BIT_CLOCK_SYNCHRONYZATION is
constant HIGH   : std_logic := '1';
constant LOW    : std_logic := '0';
attribute LOC   : string ;
    attribute LOC of MMCME2_ADV_X0Y0 : label is "MMCME2_ADV_X0Y0";
    
signal DCLK_reg     : std_logic_vector(5 downto 0);
signal PSDONE       : std_logic;
signal CLKFB_in     : std_logic;
signal CLKFB_out    : std_logic;
signal LOCKED       : std_logic;
signal PSEN         : std_logic;
signal PSINCDEC     : std_logic;
signal ALIGN_DONE   : std_logic;
begin
DCLK_reg_out <= DCLK_reg;
MMCME2_ADV_X0Y0 : MMCME2_ADV
generic map (
BANDWIDTH => "OPTIMIZED", -- Jitter programming (OPTIMIZED, HIGH, LOW)
CLKFBOUT_MULT_F => 12.0, -- Multiply value for all CLKOUT (2.000-64.000).
CLKFBOUT_PHASE => 0.0, -- Phase offset in degrees of CLKFB (-360.000-360.000).
-- CLKIN_PERIOD: Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
CLKIN1_PERIOD => 10.0,
CLKIN2_PERIOD => 0.0,
-- CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for CLKOUT (1-128)
CLKOUT1_DIVIDE => 12,--100MHZ
CLKOUT2_DIVIDE => 1,
CLKOUT3_DIVIDE => 1,
CLKOUT4_DIVIDE => 1,
CLKOUT5_DIVIDE => 1,
CLKOUT6_DIVIDE => 1,
CLKOUT0_DIVIDE_F => 2.0, --600MHz
-- CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for CLKOUT outputs (0.01-0.99).
CLKOUT0_DUTY_CYCLE => 0.5,
CLKOUT1_DUTY_CYCLE => 0.5,
CLKOUT2_DUTY_CYCLE => 0.5,
CLKOUT3_DUTY_CYCLE => 0.5,
CLKOUT4_DUTY_CYCLE => 0.5,
CLKOUT5_DUTY_CYCLE => 0.5,
CLKOUT6_DUTY_CYCLE => 0.5,
-- CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for CLKOUT outputs (-360.000-360.000).
CLKOUT0_PHASE => 0.0,
CLKOUT1_PHASE => 0.0,
CLKOUT2_PHASE => 0.0,
CLKOUT3_PHASE => 0.0,
CLKOUT4_PHASE => 0.0,
CLKOUT5_PHASE => 0.0,
CLKOUT6_PHASE => 0.0,
CLKOUT4_CASCADE => FALSE, -- Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
COMPENSATION => "ZHOLD", -- ZHOLD, BUF_IN, EXTERNAL, INTERNAL
DIVCLK_DIVIDE => 1, -- Master division value (1-106)
-- REF_JITTER: Reference input jitter in UI (0.000-0.999).
REF_JITTER1 => 0.0,
REF_JITTER2 => 0.0,
STARTUP_WAIT => FALSE, -- Delays DONE until MMCM is locked (FALSE, TRUE)
-- Spread Spectrum: Spread Spectrum Attributes
SS_EN => "FALSE", -- Enables spread spectrum (FALSE, TRUE)
SS_MODE => "CENTER_HIGH", -- CENTER_HIGH, CENTER_LOW, DOWN_HIGH, DOWN_LOW
SS_MOD_PERIOD => 10000, -- Spread spectrum modulation period (ns) (VALUES)
-- USE_FINE_PS: Fine phase shift enable (TRUE/FALSE)
CLKFBOUT_USE_FINE_PS => FALSE,
CLKOUT0_USE_FINE_PS  => TRUE,
CLKOUT1_USE_FINE_PS  => TRUE,
CLKOUT2_USE_FINE_PS  => FALSE,
CLKOUT3_USE_FINE_PS  => FALSE,
CLKOUT4_USE_FINE_PS  => FALSE,
CLKOUT5_USE_FINE_PS  => FALSE,
CLKOUT6_USE_FINE_PS  => FALSE
)
port map (
-- Clock Outputs: 1-bit (each) output: User configurable clock outputs
CLKOUT0  => CLK_OUT, -- 1-bit output: CLKOUT0
CLKOUT0B => OPEN, -- 1-bit output: Inverted CLKOUT0
CLKOUT1  => CLK_DIV_OUT, -- 1-bit output: CLKOUT1
CLKOUT1B => OPEN, -- 1-bit output: Inverted CLKOUT1
CLKOUT2  => OPEN, -- 1-bit output: CLKOUT2
CLKOUT2B => OPEN, -- 1-bit output: Inverted CLKOUT2
CLKOUT3  => OPEN, -- 1-bit output: CLKOUT3
CLKOUT3B => OPEN, -- 1-bit output: Inverted CLKOUT3
CLKOUT4  => OPEN, -- 1-bit output: CLKOUT4
CLKOUT5  => OPEN, -- 1-bit output: CLKOUT5
CLKOUT6  => OPEN, -- 1-bit output: CLKOUT6
-- DRP Ports: 16-bit (each) output: Dynamic reconfiguration ports
DO   => OPEN, -- 16-bit output: DRP data
DRDY => OPEN, -- 1-bit output: DRP ready
-- Dynamic Phase Shift Ports: 1-bit (each) output: Ports used for dynamic phase shifting of the outputs
PSDONE => PSDONE, -- 1-bit output: Phase shift done
-- Feedback Clocks: 1-bit (each) output: Clock feedback ports
CLKFBOUT => CLKFB_in, -- 1-bit output: Feedback clock
CLKFBOUTB => OPEN, -- 1-bit output: Inverted CLKFBOUT
-- Status Ports: 1-bit (each) output: MMCM status ports
CLKFBSTOPPED => open, -- 1-bit output: Feedback clock stopped
CLKINSTOPPED => open, -- 1-bit output: Input clock stopped
LOCKED => LOCKED, -- 1-bit output: LOCK
-- Clock Inputs: 1-bit (each) input: Clock inputs
CLKIN1 => CLK_SYS_in, -- 1-bit input: Primary clock
CLKIN2 => LOW, -- 1-bit input: Secondary clock
-- Control Ports: 1-bit (each) input: MMCM control ports
CLKINSEL => HIGH, -- 1-bit input: Clock select, High=CLKIN1 Low=CLKIN2
PWRDWN => LOW, -- 1-bit input: Power-down
RST => LOW, -- 1-bit input: Reset
-- DRP Ports: 7-bit (each) input: Dynamic reconfiguration ports
DADDR => (others => '0'), -- 7-bit input: DRP address
DCLK => LOW, -- 1-bit input: DRP clock
DEN => LOW, -- 1-bit input: DRP enable
DI => (others => '0'), -- 16-bit input: DRP data
DWE => LOW, -- 1-bit input: DRP write enable
-- Dynamic Phase Shift Ports: 1-bit (each) input: Ports used for dynamic phase shifting of the outputs
PSCLK => CLK_DIV_IN, -- 1-bit input: Phase shift clock
PSEN => PSEN, -- 1-bit input: Phase shift enable
PSINCDEC => PSINCDEC, -- 1-bit input: Phase shift increment/decrement
-- Feedback Clocks: 1-bit (each) input: Clock feedback ports
CLKFBIN => CLKFB_out -- 1-bit input: Feedback clock
);

BUFG_CLKFB : BUFG
port map (O => CLKFB_out, I => CLKFB_in);

--BUFG_CLK1 : BUFG
--port map (O => CLK_DIV_OUT, I => CLKOUT1);

--BUFG_CLK0 : BUFG
--port map (O => CLK_OUT, I => CLKOUT0);

ISERDESE2_DCLK : ISERDESE2
generic map (
DATA_RATE   => "SDR", -- DDR, SDR
DATA_WIDTH  => 6, -- Parallel data width (2-8,10,14)
DYN_CLKDIV_INV_EN => "FALSE", -- Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
DYN_CLK_INV_EN    => "FALSE", -- Enable DYNCLKINVSEL inversion (FALSE, TRUE)
INIT_Q1 => '0',
INIT_Q2 => '0',
INIT_Q3 => '0',
INIT_Q4 => '0',
INTERFACE_TYPE  => "NETWORKING", -- MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
IOBDELAY        => "NONE", -- NONE, BOTH, IBUF, IFD
NUM_CE          => 1, -- Number of clock enables (1,2)
OFB_USED        => "FALSE", -- Select OFB path (FALSE, TRUE)
SERDES_MODE     => "MASTER", -- MASTER, SLAVE
SRVAL_Q1 => '0',
SRVAL_Q2 => '0',
SRVAL_Q3 => '0',
SRVAL_Q4 => '0')
port map (
O  => OPEN, 
Q1 => DCLK_reg(0),
Q2 => DCLK_reg(1),
Q3 => DCLK_reg(2),
Q4 => DCLK_reg(3),
Q5 => DCLK_reg(4),
Q6 => DCLK_reg(5),
Q7 => OPEN,
Q8 => OPEN,
SHIFTOUT1 => OPEN,
SHIFTOUT2 => OPEN,
BITSLIP => LOW, 
CE1     => LOCKED,
CE2     => HIGH,
CLKDIVP => LOW, -- 1-bit input: TBD
CLK     => CLK_IN, -- 1-bit input: High-speed clock
CLKB    => LOW, -- 1-bit input: High-speed secondary clock
CLKDIV  => CLK_DIV_IN, -- 1-bit input: Divided clock
OCLK    => LOW, -- 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY"
DYNCLKDIVSEL => LOW, -- 1-bit input: Dynamic CLKDIV inversion
DYNCLKSEL    => LOW, -- 1-bit input: Dynamic CLK/CLKB inversion
D            => bit_clock, -- 1-bit input: Data input
DDLY         => LOW, -- 1-bit input: Serial data from IDELAYE2
OFB          => LOW, -- 1-bit input: Data feedback from OSERDESE2
OCLKB        => LOW, -- 1-bit input: High speed negative edge output clock
RST          => RST, -- 1-bit input: Active high asynchronous reset
SHIFTIN1     => LOW,
SHIFTIN2     => LOW);




PSA: entity work.Phase_shift_alignment(Behavioral) 
port map(   
            CLK         => CLK_DIV_IN,
            EN          => LOCKED,
            RST         => RST,
            CLK_reg     => DCLK_reg,
            
            PSDONE      => PSDONE,
            PSEN        => PSEN,
            PSINCDEC    => PSINCDEC,
            PADONE      => ALIGN_DONE  );
            
Bit_clock_align_done   <= ALIGN_DONE;

end STRUCTURE;
