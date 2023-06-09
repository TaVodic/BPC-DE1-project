library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for seven7-segment display decoder
------------------------------------------------------------

entity bin_morse is
  port (
    send  : in    std_logic;                    --! Send button
    bin   : in    std_logic_vector(4 downto 0); --! Switches input 
    clk   : in    std_logic;                    --! Main clock
    morse : out   std_logic;                     --! Morse code
    buzz : out std_logic
  );
end entity bin_morse;

------------------------------------------------------------
-- Architecture body for seven-segment display decoder
------------------------------------------------------------

architecture behavioral of bin_morse is
  
  -- signal from prescaler (clock_enable)
  signal sig_en : std_logic;
  -- hold siganl for sending 
  signal send_en : std_logic;
  -- buffer for sending letter
  signal bin_current : std_logic_vector(4 downto 0); 
  -- sending latch
  signal latch : std_logic;
  --morse buffer
  signal morse_buff : std_logic;
  
  --Buzzer signal
  signal sig_buzz : std_logic;

  -- Local delay counter
  signal sig_cnt : natural;

  -- Specific values for local counter
  constant c_DELAY_dot : unsigned(4 downto 0) := b"1_0000"; --! 100ms
  constant c_DELAY_dash : unsigned(4 downto 0) := b"0_1000"; --! 300ms

begin

  clk_en0 : entity work.clock_enable
    generic map (
      -- FOR SIMULATION, KEEP THIS VALUE TO 1
      -- FOR IMPLEMENTATION, CALCULATE VALUE: 250 ms / (1/100 MHz) aka 250ms*100MHz
      -- 1   @ 10 ns  @  testbench
      -- 10000000 -- 100ms  @  Reality
      g_MAX => 10000000
    )
    port map (
      clk => clk,
      ce  => sig_en
    );

  buzzer : entity work.buzzer
      port map(
        clk => clk,
        buzz => sig_buzz
      );

  p_bin_morse_decoder : process (clk) is

  begin
      
    if (rising_edge(clk)) then    
    --set morse output
    morse <= morse_buff;
    
    -- set hold signal 
    if (send = '1' and latch = '0') then 
        send_en <= '1';
        bin_current <= bin;
        latch <= '1';
    end if;
    if (send = '0') then
        latch <= '0';
    end if;
    
    --detects and send a PWM signal for the buzzer
    if (morse_buff = '1') then
      buzz <= sig_buzz;
    else
      buzz <= '0';
    end if;
    
      if (send_en = '1') then     
        if (sig_en = '1') then -- every g_MAX
          case bin_current is        
            when "00001" =>     --A .-                if sig_cnt = 0 then                          
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 5) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                    
                end if;           
                      
          when "00010" =>     -- B -...
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 8) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 9) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;           
                
    
          when "00011" =>     -- C -.-.
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 10) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 11) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 11) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;         
              
              
          when "00100" =>     -- D -..
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 7) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;  
               
    
          when "00101" =>     -- E .
                if (sig_cnt < 1) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 1) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if; 
              
              
          when "00110" =>     -- F ..-.
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 3) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 8) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 9) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if; 
              
            
          when "00111" =>     -- G --.
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 8) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 9) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if; 
              
            
          when "01000" =>     -- H ....
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 3) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 7) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "01001" =>     -- I ..
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 3) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 3) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "01010" =>     -- J .---
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 10) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 13) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 13) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "01011" =>     -- K -.-
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 9) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if; 
              
            
          when "01100" =>     -- L .-..
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 8) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 9) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "01101" =>     -- M --
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 7) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "01110" =>     -- N -.
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 5) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "01111" =>     -- O ---
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 8) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 11) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 11) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "10000" =>     -- P .--.
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 10) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 11) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 11) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "10001" =>     -- Q --.-
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 8) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 10) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 13) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 13) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "10010" =>     -- R .-.
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 7) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "10011" =>     -- S ...
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 3) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 5) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "10100" =>     -- T -
                if (sig_cnt < 3) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 3) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if; 
              
            
          when "10101" =>     -- U ..-
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 3) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 7) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "10110" =>     -- V ...-
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 3) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 9) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "10111" =>     -- W .--
                if (sig_cnt < 1) then  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 2) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 9) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "11000" =>     -- X -..-
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 8) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 11) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 11) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "11001" =>     -- Y -.--
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 5) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 6) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 10) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 13) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 13) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              
            
          when "11010" =>     -- Z --..
                if (sig_cnt < 3) then  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 4) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 7) then                  
                  morse_buff <= '1';                     -- 300ms dash
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 8) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 9) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt < 10) then                  
                  morse_buff <= '0';                     -- 100ms pause
                  sig_cnt <= sig_cnt + 1;    
                elsif (sig_cnt < 11) then                  
                  morse_buff <= '1';                     -- 100ms dot
                  sig_cnt <= sig_cnt + 1;
                elsif (sig_cnt = 11) then                  
                  morse_buff <= '0';
                  send_en <= '0';
                  sig_cnt <= 0;
                  bin_current <= "00000";                                     
                end if;
              

          when others =>      -- Other - send nothing
            send_en <= '0';
          end case;
        end if;
      end if;
    end if;
  end process p_bin_morse_decoder;

end architecture behavioral;
