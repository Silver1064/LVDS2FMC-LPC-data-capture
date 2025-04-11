
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library UNISIM;
use UNISIM.VComponents.all;

entity FRAME_ALIGNMENT is
    Port (  CLK_DIV                 :   in std_logic;
            CLK                     :   in std_logic;
            Bit_clock_align_done    :   in std_logic;
            Reset                   :   in std_logic;
            Bit_slip_in             :   in std_logic;
            Frame_clock             :   in std_logic;
            
            Frame_locked            :   out std_logic;
            Bit_slip_out            :   out std_logic;
            FCLK_reg_out            :   out std_logic_vector(5 downto 0)
);
end FRAME_ALIGNMENT;

architecture STRUCTURE of FRAME_ALIGNMENT is
constant HIGH: std_logic:= '1';
constant LOW : std_logic:= '0';
signal FCLK_reg: std_logic_vector(5 downto 0);
begin
FCLK_reg_out <=  FCLK_reg;
ISERDESE2_FCLK : ISERDESE2
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
Q1 => FCLK_reg(5),
Q2 => FCLK_reg(4),
Q3 => FCLK_reg(3),
Q4 => FCLK_reg(2),
Q5 => FCLK_reg(1),
Q6 => FCLK_reg(0),
Q7 => OPEN,
Q8 => OPEN,
SHIFTOUT1 => OPEN,
SHIFTOUT2 => OPEN,
BITSLIP => Bit_slip_in, 
CE1     => HIGH,
CE2     => HIGH,
CLKDIVP => LOW, -- 1-bit input: TBD
CLK     => CLK, -- 1-bit input: High-speed clock
CLKB    => LOW, -- 1-bit input: High-speed secondary clock
CLKDIV  => CLK_DIV, -- 1-bit input: Divided clock
OCLK    => LOW, -- 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY"
DYNCLKDIVSEL => LOW, -- 1-bit input: Dynamic CLKDIV inversion
DYNCLKSEL    => LOW, -- 1-bit input: Dynamic CLK/CLKB inversion
D            => Frame_clock, -- 1-bit input: Data input
DDLY         => LOW, -- 1-bit input: Serial data from IDELAYE2
OFB          => LOW, -- 1-bit input: Data feedback from OSERDESE2
OCLKB        => LOW, -- 1-bit input: High speed negative edge output clock
RST          => Reset, -- 1-bit input: Active high asynchronous reset
SHIFTIN1     => LOW,
SHIFTIN2     => LOW);

FCLK_ALIGN: entity work.FRAME_CLOCK(Behavioral)
  Port map
       (    CLK              => CLK_DIV,
            EN               => Bit_clock_align_done,
            RST              => Reset,
            FCLK_reg         => FCLK_reg,
            
            SLIPBIT          => Bit_slip_out,
            FRAME_ALIGN_DONE => Frame_locked);
end STRUCTURE;
