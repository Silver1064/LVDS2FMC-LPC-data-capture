
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity Phase_shift_alignment is
  Port (    
            CLK         : in std_logic;
            EN          : in std_logic;
            RST         : in std_logic;
            CLK_reg     : in std_logic_vector(5 downto 0);
            PSDONE      : in std_logic;
            
            PSEN        : out std_logic;
            PSINCDEC    : out std_logic;
            PADONE      : out std_logic     );
end Phase_shift_alignment;

architecture Behavioral of Phase_shift_alignment is
constant HIGH: std_logic:= '1';
constant LOW : std_logic:= '0';
type state is (initial,wait_ISERDESE2,update,shift_up,shift_up_check,shift_down,shift_down_check,detect,check_edge,check_edge_shift,lock);
signal st : state:= initial;
signal edge_cal: std_logic;
signal edge_val: std_logic;
signal edge_known: std_logic;
signal cal_val : std_logic_vector(1 downto 0);
signal intaction: std_logic_vector (2 downto 0);
signal count: std_logic_vector (4 downto 0) := (others => '0');

begin

--EDGE_CAL <= '0' when clk_reg = "00000000" or clk_reg = "11111111" else '1';

--EDGE_VAL <= clk_reg(0) and clk_reg(1) and clk_reg(2) and clk_reg(3) and clk_reg(4) and clk_reg(5) and clk_reg(6) and clk_reg(7);
EDGE_CAL <= '0' when clk_reg = "010101" or clk_reg = "101010" else '1';
EDGE_VAL <= '1' when clk_reg = "101010" else '0';

CAL_VAL  <= EDGE_CAL & EDGE_VAL;

process(CLK,RST,EN,CAL_VAL,intaction,edge_known)
begin
if rst = '1' then
    st <= initial;
elsif rising_edge(CLK) and EN = '1' then
    case st is
        when initial => 
            edge_known <= '0';
            intaction <= (others => '0');
            count <= (others => '0');
            PADONE <= '0';

            st <= wait_ISERDESE2; 
        when wait_ISERDESE2 =>
            if count < 20 then 
                count <= count + 1;
            else
                count <= (others => '0');
                st <= update;
            end if;
        when update => 
            intaction <= CAL_VAL & edge_known;
            st <= detect;
        when detect => 
            case intaction is
                when "000" => st <= shift_up;
                when "001" => st <= shift_up;
                when "010" => st <= shift_down;
                when "011" => st <= shift_down;  
                when "100" => st <= check_edge; 
                when "101" => st <= lock;
--                when "110" => st <= check_edge; 
--                when "111" => st <= lock;
                when others => st <=  update;                            
            end case;
        when shift_up => 
            PSINCDEC <= '1';
            PSEN <= '1';
            edge_known <= '1';
            st <=  shift_up_check;
        when shift_up_check => 
            PSEN <= '0';
            if PSDONE = '1' then
                st <= update;
            end if;
        when shift_down => 
            PSINCDEC <= '0';
            PSEN <= '1';
            edge_known <= '1';
            st <=  shift_down_check;
        when shift_down_check => 
            PSEN <= '0';
            if PSDONE = '1' then
                st <= update;
            end if;
        when check_edge => 
            PSINCDEC <= '1';
            PSEN <= '1';
            st <=  check_edge_shift;
        when check_edge_shift =>
            PSEN <= '0';
            if PSDONE = '1' and count < 30 then
                count <= count + 1;
                st <= check_edge;
            elsif PSDONE = '1' and count >= 30 then
                st <= update;
            end if;
        when lock =>
            PADONE <= '1';
            st <= update;
    end case;
end if;
end process;

end Behavioral;
