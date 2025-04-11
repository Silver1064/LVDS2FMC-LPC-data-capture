
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
entity FRAME_CLOCK is
  Port (    CLK             : in std_logic;
            EN              : in std_logic;
            RST             : in std_logic;
            FCLK_reg        : in std_logic_vector(5 downto 0);
            
            SLIPBIT         : out std_logic:='0';
            FRAME_ALIGN_DONE: out std_logic);
end FRAME_CLOCK;

architecture Behavioral of FRAME_CLOCK is
signal FRAME_VAL: std_logic;
signal inframe: std_logic;
type state is (initial,wait_ISERDESE2,update, detect, action,action_complete,align_done);
signal st : state := initial;
signal count: std_logic_vector(4 downto 0);
begin

FRAME_VAL <= '1' when FCLK_reg = "000111" else '0';
--FRAME_VAL <= '1' when FCLK_reg = "000111"  else '0';
process(CLK,EN,RST,st,FRAME_VAL,inframe)
begin
    if RST = '1' then
        st <= initial;
        FRAME_ALIGN_DONE <= '0';
    elsif rising_edge(CLK) and EN = '1' then
        case st is
            when initial =>
                inframe <= '0';
                SLIPBIT <= '0';
                FRAME_ALIGN_DONE <= '0';
                count <= (others => '0');
                st <= wait_ISERDESE2;   
            when wait_ISERDESE2 =>
            if count < 20 then 
                count <= count + 1;
            else
                count <= (others => '0');
                st <= update;
            end if;             
            when update =>
                inframe <= FRAME_VAL;
                st <= detect;
                
            when detect =>
                if inframe = '1' then
                    st <= align_done;
                else 
                    st <= action;
                end if;
            when action =>
                SLIPBIT <= '1';
                st <= action_complete;
            when action_complete =>
                SLIPBIT <= '0';
                if count > 20 then 
                    count <= (others => '0');
                    st <= update;
                else count <= count +1;
                end if;
            when align_done =>
                FRAME_ALIGN_DONE <= '1';
        end case;
    end if;
end process;

end Behavioral;
