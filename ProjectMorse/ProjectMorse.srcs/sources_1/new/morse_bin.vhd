----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2023 23:48:20
-- Design Name: 
-- Module Name: morse_bin - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity morse_bin is
    Port ( morse    : in STD_LOGIC;
           clk      : in STD_LOGIC;
           bin      : out STD_LOGIC_VECTOR (4 downto 0));
end morse_bin;

architecture Behavioral of morse_bin is

-- signal from prescaler (clock_enable)
signal sig_en : std_logic;
signal buff : std_logic_vector(4 downto 0);
signal pulse_cnt : natural;
signal pulse_cnt_pause : natural;
signal index : natural;

--constant c_dot : unsigned(18 downto 0) := b"001_1000_0110_1010_0000";
--constant c_dash : unsigned(18 downto 0) := b"001_1000_0110_1010_0000";
--constant c_pause : unsigned(18 downto 0) := b"001_1000_0110_1010_0000";

constant c_dot : unsigned(4 downto 0) := b"0_0101";
constant c_dash : unsigned(4 downto 0) := b"0_1111";
constant c_pause : unsigned(4 downto 0) := b"0_1010";

begin
  clk_en0 : entity work.clock_enable
    generic map (
      -- FOR SIMULATION, KEEP THIS VALUE TO 1
      -- FOR IMPLEMENTATION, CALCULATE VALUE: 250 ms / (1/100 MHz) aka 250ms*100MHz
      -- 1   @ 10 ns
      -- ??? @ 250 ms
      -- 10000000 -- 100ms
      -- 5 -- 50ns
      -- 100000 -- 1ms      
      -- 500 -- 5us
      g_MAX => 1
    )
    port map (
      clk => clk,
      ce  => sig_en
    );
    
    p_morse_bin_decoder : process (clk) is
    
    begin
    
        if (rising_edge(clk)) then
            
            if (sig_en = '1') then
                if (morse = '1') then -- increment counter for high level
                    pulse_cnt <= pulse_cnt + 1;
                    pulse_cnt_pause <= 0;
                end if;
                if (morse = '0') then -- increment counter for low level
                    pulse_cnt_pause <= pulse_cnt_pause + 1;
                end if;
                
                if (morse = '0' and pulse_cnt /= 0) then -- find falling edge of morse
                    if ( pulse_cnt = c_dot) then -- save dot
                        buff(index) <= '0';
                        index <= index + 1; 
                    end if;
                    if ( pulse_cnt = c_dash) then -- save dash
                        buff(index) <= '1';
                        index <= index + 1; 
                    end if;
                    pulse_cnt <= 0;                  
                end if;               
                
                if (pulse_cnt_pause = c_pause) then -- end of letter, set bin output
                    index <= 0;
                    
                    --if (buff = "1000X") then -- -... B => bin 00010
                        --bin <= "00010";
                    --end if;
                    
                    
                    buff <= (others => '0');
                end if;        
            end if;
        end if;
        
    end process p_morse_bin_decoder;

end Behavioral;
