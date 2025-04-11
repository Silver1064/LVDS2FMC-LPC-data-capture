----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2023 02:35:10 PM
-- Design Name: 
-- Module Name: TOP_ADC - Behavioral
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

entity TOP_ADC_DATA_CAPTURING is
 Port ( CLK_IN      : in  std_logic;
        RST         : in  std_logic;
        DCLK_p      : in  std_logic;
        DCLK_n      : in  std_logic;
        FCLK_p      : in  std_logic;
        FCLK_n      : in  std_logic;        
        DA_p        : in  std_logic_vector(1 downto 0);
        DA_n        : in  std_logic_vector(1 downto 0);
        DB_p        : in  std_logic_vector(1 downto 0);
        DB_n        : in  std_logic_vector(1 downto 0);
--        DA          : out std_logic_vector(11 downto 0);
--        DB          : out std_logic_vector(11 downto 0);
        DCLK_DONE   : out std_logic;
        FCLK_DONE   : out std_logic 
        );
end TOP_ADC_DATA_CAPTURING;

architecture STRUCTURE of TOP_ADC_DATA_CAPTURING is
signal RESET  : std_logic;
signal DCLK   : std_logic;
signal FCLK   : std_logic;
signal DB1,DB0        :  std_logic;
signal DA1,DA0        :  std_logic;

begin
RESET <= not RST;
-- bit clock--
DCLK_buf : IBUFDS
generic map ( DIFF_TERM => TRUE, IBUF_LOW_PWR => TRUE, IOSTANDARD => "LVDS_25") 
port map (O => DCLK, I => DCLK_p, IB => DCLK_n );
fCLK_buf : IBUFDS
generic map ( DIFF_TERM => TRUE, IBUF_LOW_PWR => TRUE, IOSTANDARD => "LVDS_25") 
port map (O => FCLK, I => FCLK_p, IB => FCLK_n );

--channel A--
DA_0 : IBUFDS
generic map ( DIFF_TERM => TRUE, IBUF_LOW_PWR => TRUE, IOSTANDARD => "LVDS_25") 
port map (O => DA0, I => DA_p(0), IB => DA_n(0) );
DA_1 : IBUFDS
generic map ( DIFF_TERM => TRUE, IBUF_LOW_PWR => TRUE, IOSTANDARD => "LVDS_25") 
port map (O => DA1, I => DA_p(1), IB => DA_n(1) );

----channel B--
DB_0 : IBUFDS
generic map ( DIFF_TERM => TRUE, IBUF_LOW_PWR => TRUE, IOSTANDARD => "LVDS_25") 
port map (O => DB0, I => DB_p(0), IB => DB_n(0) );
DB_1 : IBUFDS
generic map ( DIFF_TERM => TRUE, IBUF_LOW_PWR => TRUE, IOSTANDARD => "LVDS_25") 
port map (O => DB1, I => DB_p(1), IB => DB_n(1) );
ADC_DATA_CAPTURING: entity work.ADC_DATA_CAPTURING(STRUCTURE)
Port map(CLK_SYS        => CLK_IN,
         Bit_clock      => DCLK,
         Frame_clock    => FCLK,
         RST            => RESET,
         DA0            => DA0,
         DA1            => DA1,
         DB0            => DB0,
         DB1            => DB1,
         DCLK_DONE      => DCLK_DONE,  
         FCLK_DONE      => FCLK_DONE 
         );
         
         
end STRUCTURE;
