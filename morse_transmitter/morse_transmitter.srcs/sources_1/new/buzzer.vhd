library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Used for generating a 1Khz PWM signal with a 50% duty cycle for a buzzer
entity buzzer is
  port (
    buzz : out std_logic;
    clk : in std_logic);
end entity buzzer;

architecture behavioral of buzzer is

  signal sig_en : std_logic;
  signal sig_cnt : natural;
  signal latch : std_logic;

begin
  clk_en0 : entity work.clock_enable
    generic map(
      -- FOR SIMULATION, KEEP THIS VALUE TO 1
      -- FOR IMPLEMENTATION, CALCULATE VALUE: 250 ms / (1/100 MHz)
      -- 10000000 -- 1kHz
      g_MAX => 100000
    )
    port map(
      clk => clk,
      ce => sig_en
    );

  p_buzzer : process (clk) is
  begin
    --After detecting a falling edge, keep holding the output 'High'
    if (falling_edge(clk)) then
      if (sig_en = '1') then
        latch <= '1';
      end if;
      if (sig_cnt < 50000 and latch = '1') then
        buzz <= '1';
        sig_cnt <= sig_cnt + 1;
      --After counting half of the signal period change the ouput to 'Low'
      elsif (sig_cnt >= 50000) then
        latch <= '0';
        buzz <= '0';
        sig_cnt <= 0;
      end if;
    end if;
  end process p_buzzer;
end architecture behavioral;
