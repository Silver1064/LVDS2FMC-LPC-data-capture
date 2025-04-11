----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2024 03:43:36 PM
-- Design Name: 
-- Module Name: ADC_DATA_CAPTURING - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity ADC_DATA_CAPTURING is
  Port ( 
         CLK_SYS        : in std_logic;
         Bit_clock      : in std_logic;
         Frame_clock    : in std_logic;
         RST            : in std_logic;
         DA0            : in std_logic;
         DA1            : in std_logic;
         DB0            : in std_logic;
         DB1            : in std_logic
         ;
--         DA_out     : out std_logic_vector(11 downto 0);
--         DB_out     : out std_logic_vector(11 downto 0);
         DCLK_done  : out std_logic;
         FCLK_done  : out std_logic
         );
end ADC_DATA_CAPTURING;

architecture STRUCTURE of ADC_DATA_CAPTURING is
constant HIGH : std_logic := '1';
constant LOW : std_logic := '0';
signal CLK_SYS_in           : std_logic;
signal CLK_out              : std_logic;
signal CLK_DIV_out          : std_logic;
signal CLK                  : std_logic;
signal CLK_DIV              : std_logic;
signal Bit_clock_align_done : std_logic_vector(0 downto 0);
signal Bit_slip             : std_logic;
signal Frame_locked         : std_logic_vector(0 downto 0);
signal DA_out               : std_logic_vector(11 downto 0);
signal DB_out               : std_logic_vector(11 downto 0);
signal FCLK_reg             : std_logic_vector(5 downto 0);
signal DCLK_reg             : std_logic_vector(5 downto 0);
begin

BUFG_SYNC : BUFG
port map (O => CLK_SYS_in, I => CLK_SYS );

BIT_CLOCK_SYNC: entity work.BIT_CLOCK_SYNCHRONYZATION(STRUCTURE)
        Port map (  CLK_SYS_in              => CLK_SYS_in,
                    RST                     => RST,
                    Bit_clock               => Bit_clock,
                    CLK_DIV_IN              => CLK_DIV, --100MHZ
                    CLK_IN                  => CLK, --300MHZ
                    Bit_clock_align_done    => Bit_clock_align_done(0),
                    CLK_DIV_OUT             => CLK_DIV_out,
                    CLK_OUT                 => CLK_out,
                    DCLK_reg_out            => DCLK_reg);
BUFG_CLK1 : BUFG
port map (O => CLK_DIV, I => CLK_DIV_out);

BUFG_CLK0 : BUFG
port map (O => CLK, I => CLK_out);               


FRAME_ALIGN:    entity work.FRAME_ALIGNMENT(STRUCTURE)
        Port map (  CLK_DIV                 => CLK_DIV,
                    CLK                     => CLK,
                    Bit_clock_align_done    => Bit_clock_align_done(0),
                    Reset                   => RST,
                    Bit_slip_in             => Bit_slip,
                    Frame_clock             => Frame_clock,
                
                    Frame_locked            => Frame_locked(0),
                    Bit_slip_out            => Bit_slip,
                    FCLK_reg_out            => FCLK_reg
                    );  
                  

DATA_RECEIVE:   entity work.DATA_RECEIVE(STRUCTURE)
        Port map (      CLK             => CLK,
                        CLK_DIV         => CLK_DIV,
                        EN              => HIGH,
                        ENABLE          => Frame_locked(0),
                        RST             => RST,          
                        DA0             => DA0,
                        DA1             => DA1,
                        DB0             => DB0,
                        DB1             => DB1,
                        BITSLIP         => Bit_slip,
                        
                        DA_out          => DA_out,
                        DB_out          => DB_out );   
DCLK_done <= Bit_clock_align_done(0);
FCLK_done <= Frame_locked(0);     
ILA_debug: entity work.ILA(STRUCTURE)
port map 
  ( CLK         => CLK_DIV,
    DA_out      => DA_out,
    DB_out      => DB_out,
    DCLK_done   => Bit_clock_align_done,
    DCLK_reg    => DCLK_reg,
    FCLK_done   => Frame_locked,
    FCLK_reg    => FCLK_reg  );                
end STRUCTURE;
