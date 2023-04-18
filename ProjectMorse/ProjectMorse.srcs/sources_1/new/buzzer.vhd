library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buzzer is
    Port ( buzz   : out STD_LOGIC;
           clk    : in STD_LOGIC);
end buzzer;

architecture Behavioral of buzzer is

signal sig_en : std_logic;
signal sig_cnt : natural;

begin
  clk_en0 : entity work.clock_enable
    generic map (
      -- FOR SIMULATION, KEEP THIS VALUE TO 1
      -- FOR IMPLEMENTATION, CALCULATE VALUE: 250 ms / (1/100 MHz)
      -- 1   @ 10 ns
      -- ??? @ 250 ms
      -- 10000000 -- 100ms
      g_MAX => 1000
    )
    port map (
      clk => clk,
      ce  => sig_en
    );
  
  p_buzzer : procces(clk) is 
    
    if (sig_cnt  => 500) then
      sig_cnt <= 0;
    end if

    if (rising_edge(clock)) then
      if (sig_en = '1') then
        buzz <= '1';
        sig_cnt <= sig_cnt + 1;
      else 
        buzz <= '0';
      end if;
    end if;
  end process p_buzzer
end Behavioral;
