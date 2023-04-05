library ieee;
  use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for seven7-segment display decoder
------------------------------------------------------------

entity bin_morse is
  port (
    send  : in    std_logic;                    --! Display is clear if blank = 1
    bin   : in    std_logic_vector(4 downto 0); --! Binary representation of one hexadecimal symbol   
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
  constant c_DELAY_dot : unsigned(4 downto 0) := b"1_0000"; --! 4-second delay
  constant c_DELAY_dash : unsigned(4 downto 0) := b"0_1000"; --! 2-second delay

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
        
      case bin is
    
        when "00001" => -- A

            if (sig_cnt < c_DELAY_2SEC) then
              sig_cnt <= sig_cnt + 1;
            else
              -- Move to the next state
              sig_state <= WEST_GO;
              -- Reset delay counter value
              sig_cnt   <= (others => '0');
            end if;       
      
        when "00010" =>

          seg <= "1100000"; -- B

        when "00011" =>

          seg <= "0110001"; -- C     
          
        when "00100" =>

          seg <= "1000010"; -- D             

        when "00101" =>

          seg <= "0110000"; -- E
          
        when "00110" =>

          seg <= "0111000"; -- F
        
        when "00111" =>

          seg <= "0100001"; -- G
        
        when "01000" =>

          seg <= "1101000"; -- H
        
        when "01001" =>

          seg <= "0111011"; -- I
        
        when "01010" =>

          seg <= "0100111"; -- J
        
        when "01011" =>

          seg <= "0101000"; -- K
        
        when "01100" =>

          seg <= "1110001"; -- L
        
        when "01101" =>

          seg <= "0101010"; -- M
        
        when "01110" =>

          seg <= "1101010"; -- N
        
        when "01111" =>

          seg <= "1100010"; -- O
        
        when "10000" =>

          seg <= "0011000"; -- P
        
        when "10001" =>

          seg <= "0001100"; -- Q
        
        when "10010" =>

          seg <= "1111010"; -- R
        
        when "10011" =>

          seg <= "0100101"; -- S
        
        when "10100" =>

          seg <= "1110000"; -- T
        
        when "10101" =>

          seg <= "1100011"; -- U
        
        when "10110" =>

          seg <= "1010101"; -- V
        
        when "10111" =>

          seg <= "1010100"; -- W
        
        when "11000" =>

          seg <= "1101011"; -- X
        
        when "11001" =>

          seg <= "1000100"; -- Y
        
        when "11010" =>

          seg <= "0010011"; -- Z       

        when others =>

          seg <= "1111111"; -- nothing

      end case;

    end if;

  end process p_7seg_decoder;

end architecture behavioral;
