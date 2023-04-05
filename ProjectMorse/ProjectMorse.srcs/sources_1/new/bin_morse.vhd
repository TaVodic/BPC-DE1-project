library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for seven7-segment display decoder
------------------------------------------------------------

entity bin_morse is
  port (
    send  : in    std_logic;                    --! 
    bin   : in    std_logic_vector(4 downto 0); --!  
    clk   : in    std_logic;                    --! Main clock
    morse : out   std_logic                     --! Morse code
  );
end entity bin_morse;

------------------------------------------------------------
-- Architecture body for seven-segment display decoder
------------------------------------------------------------

architecture behavioral of bin_morse is

  signal sig_en : std_logic;
  signal send_en : std_logic;

  -- Local delay counter
  signal sig_cnt : unsigned(4 downto 0);

  -- Specific values for local counter
  constant c_DELAY_dot : unsigned(4 downto 0) := b"1_0000"; --! 100ms
  constant c_DELAY_dash : unsigned(4 downto 0) := b"0_1000"; --! 300ms

begin

  clk_en0 : entity work.clock_enable
    generic map (
      -- FOR SIMULATION, KEEP THIS VALUE TO 1
      -- FOR IMPLEMENTATION, CALCULATE VALUE: 250 ms / (1/100 MHz)
      -- 1   @ 10 ns
      -- ??? @ 250 ms
      g_MAX => 10000000 -- 100ms
    )
    port map (
      clk => clk,
      ce  => sig_en
    );

  p_bin_morse_decoder : process (send, bin) is

  begin

    if (send = '1') then
        send_en <= '1';
    end if;
    
    if (rising_edge(clk)) and (send_en = '1') then
      if (sig_en = '1') then -- every g_MAX
        
        case bin is        
            when "00001" =>     --A .-                if sig_cnt = 0 then
            
                if (sig_cnt < 1) then  
                  morse <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 5) then                  
                  morse <= '0';
                  send_en <= '0';                  
                end if;            

                         
          
            when "00010" =>     -- B -...
    
                
    
            when "00011" =>     -- C -.-.
    
              
              
            when "00100" =>     -- D -..
    
               
    
            when "00101" =>     -- E .
    
              
              
            when "00110" =>     -- F ..-.
    
              
            
            when "00111" =>     -- G --.
    
              
            
            when "01000" =>     -- H ....
    
              
            
            when "01001" =>     -- I ..
    
              
            
            when "01010" =>     -- J .---
    
              
            
            when "01011" =>     -- K -.-
    
              
            
            when "01100" =>     -- L .-..
    
              
            
            when "01101" =>     -- M --
    
              
            
            when "01110" =>     -- N -.
    
              
            
            when "01111" =>     -- O ---
    
              
            
            when "10000" =>     -- P .--.
    
              
            
            when "10001" =>     -- Q --.-
    
              
            
            when "10010" =>     -- R .-.
    
              
            
            when "10011" =>     -- S ...
    
              
            
            when "10100" =>     -- T -
    
              
            
            when "10101" =>     -- U ..-
    
              
            
            when "10110" =>     -- V ...-
    
              
            
            when "10111" =>     -- W .--
    
              
            
            when "11000" =>     -- X -..-
    
              
            
            when "11001" =>     -- Y -.--
    
              
            
            when "11010" =>     -- Z --..

              

            when others =>      -- Other - send nothing



          end case;
    
    send_en <= '0';
    end if;
  end if;

  end process p_bin_morse_decoder;

end architecture behavioral;
