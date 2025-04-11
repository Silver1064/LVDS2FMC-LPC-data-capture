
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity DATA_RECEIVE is
Port (      CLK             : in std_logic; --
            CLK_DIV         : in std_logic;
            EN              : in std_logic;
            ENABLE          : in std_logic;
            RST             : in std_logic;            
            DA0             : in std_logic;
            DA1             : in std_logic;
            DB0             : in std_logic;
            DB1             : in std_logic;
            BITSLIP         : in std_logic;
            
            DA_out          : out std_logic_vector(11 downto 0);
            DB_out          : out std_logic_vector(11 downto 0) );
end DATA_RECEIVE;

architecture STRUCTURE of DATA_RECEIVE is
constant HIGH: std_logic:= '1';
constant LOW : std_logic:= '0';
signal A0_in,A1_in,B0_in,B1_in: std_logic_vector(5 downto 0);
signal A_reg,B_reg: std_logic_vector(11 downto 0);
begin

A0 : ISERDESE2
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
Q1 => A0_in(5),
Q2 => A0_in(4),
Q3 => A0_in(3),
Q4 => A0_in(2),
Q5 => A0_in(1),
Q6 => A0_in(0),
Q7 => OPEN,
Q8 => OPEN,
SHIFTOUT1 => OPEN,
SHIFTOUT2 => OPEN,
BITSLIP => BITSLIP, 
CE1     => EN,
CE2     => HIGH,
CLKDIVP => LOW, -- 1-bit input: TBD
CLK     => CLK, -- 1-bit input: High-speed clock
CLKB    => LOW, -- 1-bit input: High-speed secondary clock
CLKDIV  => CLK_DIV, -- 1-bit input: Divided clock
OCLK    => LOW, -- 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY"
DYNCLKDIVSEL => LOW, -- 1-bit input: Dynamic CLKDIV inversion
DYNCLKSEL    => LOW, -- 1-bit input: Dynamic CLK/CLKB inversion
D            => DA0, -- 1-bit input: Data input
DDLY         => LOW, -- 1-bit input: Serial data from IDELAYE2
OFB          => LOW, -- 1-bit input: Data feedback from OSERDESE2
OCLKB        => LOW, -- 1-bit input: High speed negative edge output clock
RST          => RST, -- 1-bit input: Active high asynchronous reset
SHIFTIN1     => LOW,
SHIFTIN2     => LOW);

A1 : ISERDESE2
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
Q1 => A1_in(5),
Q2 => A1_in(4),
Q3 => A1_in(3),
Q4 => A1_in(2),
Q5 => A1_in(1),
Q6 => A1_in(0),
Q7 => OPEN,
Q8 => OPEN,
SHIFTOUT1 => OPEN,
SHIFTOUT2 => OPEN,
BITSLIP => BITSLIP, 
CE1     => EN,
CE2     => HIGH,
CLKDIVP => LOW, -- 1-bit input: TBD
CLK     => CLK, -- 1-bit input: High-speed clock
CLKB    => LOW, -- 1-bit input: High-speed secondary clock
CLKDIV  => CLK_DIV, -- 1-bit input: Divided clock
OCLK    => LOW, -- 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY"
DYNCLKDIVSEL => LOW, -- 1-bit input: Dynamic CLKDIV inversion
DYNCLKSEL    => LOW, -- 1-bit input: Dynamic CLK/CLKB inversion
D            => DA1, -- 1-bit input: Data input
DDLY         => LOW, -- 1-bit input: Serial data from IDELAYE2
OFB          => LOW, -- 1-bit input: Data feedback from OSERDESE2
OCLKB        => LOW, -- 1-bit input: High speed negative edge output clock
RST          => RST, -- 1-bit input: Active high asynchronous reset
SHIFTIN1     => LOW,
SHIFTIN2     => LOW);

B0 : ISERDESE2
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
Q1 => B0_in(5),
Q2 => B0_in(4),
Q3 => B0_in(3),
Q4 => B0_in(2),
Q5 => B0_in(1),
Q6 => B0_in(0),
Q7 => OPEN,
Q8 => OPEN,
SHIFTOUT1 => OPEN,
SHIFTOUT2 => OPEN,
BITSLIP => BITSLIP, 
CE1     => EN,
CE2     => HIGH,
CLKDIVP => LOW, -- 1-bit input: TBD
CLK     => CLK, -- 1-bit input: High-speed clock
CLKB    => LOW, -- 1-bit input: High-speed secondary clock
CLKDIV  => CLK_DIV, -- 1-bit input: Divided clock
OCLK    => LOW, -- 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY"
DYNCLKDIVSEL => LOW, -- 1-bit input: Dynamic CLKDIV inversion
DYNCLKSEL    => LOW, -- 1-bit input: Dynamic CLK/CLKB inversion
D            => DB0, -- 1-bit input: Data input
DDLY         => LOW, -- 1-bit input: Serial data from IDELAYE2
OFB          => LOW, -- 1-bit input: Data feedback from OSERDESE2
OCLKB        => LOW, -- 1-bit input: High speed negative edge output clock
RST          => RST, -- 1-bit input: Active high asynchronous reset
SHIFTIN1     => LOW,
SHIFTIN2     => LOW);

B1 : ISERDESE2
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
Q1 => B1_in(5),
Q2 => B1_in(4),
Q3 => B1_in(3),
Q4 => B1_in(2),
Q5 => B1_in(1),
Q6 => B1_in(0),
Q7 => OPEN,
Q8 => OPEN,
SHIFTOUT1 => OPEN,
SHIFTOUT2 => OPEN,
BITSLIP => BITSLIP, 
CE1     => EN,
CE2     => HIGH,
CLKDIVP => LOW, -- 1-bit input: TBD
CLK     => CLK, -- 1-bit input: High-speed clock
CLKB    => LOW, -- 1-bit input: High-speed secondary clock
CLKDIV  => CLK_DIV, -- 1-bit input: Divided clock
OCLK    => LOW, -- 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY"
DYNCLKDIVSEL => LOW, -- 1-bit input: Dynamic CLKDIV inversion
DYNCLKSEL    => LOW, -- 1-bit input: Dynamic CLK/CLKB inversion
D            => DB1, -- 1-bit input: Data input
DDLY         => LOW, -- 1-bit input: Serial data from IDELAYE2
OFB          => LOW, -- 1-bit input: Data feedback from OSERDESE2
OCLKB        => LOW, -- 1-bit input: High speed negative edge output clock
RST          => RST, -- 1-bit input: Active high asynchronous reset
SHIFTIN1     => LOW,
SHIFTIN2     => LOW);


PROCESS(CLK_DIV,ENABLE,RST,A1_in,A0_in,B1_in,B0_in)
BEGIN
    if RST = '1' then 
        A_reg <= (others => '0');
        B_reg <= (others => '0');
    elsif rising_edge(CLK_DIV) and ENABLE = '1' then
        A_reg <= A1_in & A0_in;
        B_reg <= B1_in & B0_in;
    end if;
END PROCESS;


DA_out <= A_reg;
DB_out <= B_reg;


END STRUCTURE;
