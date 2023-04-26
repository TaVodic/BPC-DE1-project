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
signal buff : std_logic_vector(4 downto 0) := "00000";
signal pulse_cnt : natural;
signal pulse_cnt_pause : natural;
signal index : natural;

-- contans for the board
--constant c_dot : unsigned(18 downto 0) := b"001_1000_0110_1010_0000";
--constant c_dash : unsigned(18 downto 0) := b"001_1000_0110_1010_0000";
--constant c_pause : unsigned(18 downto 0) := b"001_1000_0110_1010_0000";

-- contans for simulation
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
      -- 1 - is only for simulaton -> no prescaler
      g_MAX => 2000000
    )
    port map (
      clk => clk,
      ce  => sig_en
    );
    
    p_morse_bin_decoder : process (clk) is
    
    begin
    
        if (rising_edge(clk)) then
            
            if (sig_en = '1') then
                if (morse = '1') then -- increment counter for high level of morse signal
                    pulse_cnt <= pulse_cnt + 1;
                    pulse_cnt_pause <= 0;
                end if;
                if (morse = '0') then -- increment counter for low level of morse signal
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
                    
                    -- buff variable represents received morse letter
                    -- dot is 0, dash is 1 (be carefull, bits of morse are reversed)
                    -- always use 5 bits of buff
                    -- the length of incoming morse letter is determine with index value
                    -- bin is output value to hex7seg module
                    
                    -- ._ A   => bin 00001
                    if (buff = "00010" and index = 2) then 
                        bin <= "00001";
                    end if;                  
                    
                    -- -... B => bin 00010
                    if (buff = "00001" and index = 4) then 
                        bin <= "00010";
                    end if; 

                    -- -.-. C => bin 00011
                    if (buff = "00101" and index = 4) then 
                        bin <= "00011";
                    end if; 

                    -- -.. D => bin 00100
                    if (buff = "00001" and index = 3) then 
                        bin <= "00100";
                    end if; 

                    -- . E => bin 00101
                    if (buff = "00000" and index = 1) then 
                        bin <= "00101";
                    end if; 

                    -- ..-. F => bin 00110
                    if (buff = "00100" and index = 4) then 
                        bin <= "00110";
                    end if; 

                    -- --. G => bin 00111
                    if (buff = "00011" and index = 3) then 
                        bin <= "00111";
                    end if; 

                    -- .... H => bin 01000
                    if (buff = "00000" and index = 4) then 
                        bin <= "01000";
                    end if; 
                    
                    -- .. I => bin 01001
                    if (buff = "00000" and index = 2) then 
                        bin <= "01001";
                    end if; 

                    -- .--- J => bin 01010
                    if (buff = "01110" and index = 4) then 
                        bin <= "01010";
                    end if; 

                    -- -.- K => bin 01011
                    if (buff = "00101" and index = 3) then 
                        bin <= "01011";
                    end if; 

                    -- .-.. L => bin 01100
                    if (buff = "00010" and index = 4) then 
                        bin <= "01100";
                    end if; 

                    -- -- M => bin 01101
                    if (buff = "00011" and index = 2) then 
                        bin <= "01101";
                    end if; 

                    -- -. N => bin 01110
                    if (buff = "00001" and index = 2) then 
                        bin <= "01110";
                    end if; 

                    -- --- O => bin 01111
                    if (buff = "00111" and index = 3) then 
                        bin <= "01111";
                    end if; 

                    -- .--. P => bin 10000
                    if (buff = "00110" and index = 4) then 
                        bin <= "10000";
                    end if; 

                    -- --.- Q => bin 10001
                    if (buff = "01101" and index = 4) then 
                        bin <= "10001";
                    end if; 

                    -- .-. R => bin 10010
                    if (buff = "00010" and index = 3) then 
                        bin <= "10010";
                    end if; 

                    -- ... S => bin 10011
                    if (buff = "00000" and index = 3) then 
                        bin <= "10011";
                    end if; 

                    -- - T => bin 10100
                    if (buff = "00001" and index = 1) then 
                        bin <= "10100";
                    end if; 

                    -- ..- U => bin 10101
                    if (buff = "00100" and index = 3) then 
                        bin <= "10101";
                    end if; 

                    -- ...- V => bin 10110
                    if (buff = "01000" and index = 4) then 
                        bin <= "10110";
                    end if; 

                    -- .-- W => bin 10111
                    if (buff = "00110" and index = 3) then 
                        bin <= "10111";
                    end if; 

                    -- -..- X => bin 11000
                    if (buff = "01001" and index = 4) then 
                        bin <= "11000";
                    end if; 

                    -- -.-- Y => bin 11001
                    if (buff = "01101" and index = 4) then 
                        bin <= "11001";
                    end if; 

                    -- --.. Z => bin 11010
                    if (buff = "00011" and index = 4) then 
                        bin <= "11010";
                    end if; 

                    
                    index <= 0;
                    buff <= (others => '0');                   
                end if;        
            end if;
        end if;
        
    end process p_morse_bin_decoder;

end Behavioral;

--report std_logic'image(buff(4));
-- report "Number of cycles taken = " & integer'image(letter'length);
--report std_logic'image(buff(1));
--                    report natural'image(index);