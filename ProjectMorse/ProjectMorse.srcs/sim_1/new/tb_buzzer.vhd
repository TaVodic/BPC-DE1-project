----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2023 22:26:15
-- Design Name: 
-- Module Name: tb_bin_morse - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_buzzer is
   
end tb_buzzer;

architecture Behavioral of tb_buzzer is
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    
    signal s_clk_100MHz : std_logic;
    signal s_buzzer : std_logic;
begin
    uut_tb_bin_morse : entity work.buzzer
    port map(
        clk     => s_clk_100MHz,        
        buzz => s_buzzer
    );
    
    p_clk_gen : process
    begin
        while now < 2000 ns loop -- 20 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                -- Process is suspended forever
    end process p_clk_gen;

    p_stimulus : process
    begin
        report "Stimulus process started";
        
        report "Stimulus process finished";
        wait;
    end process p_stimulus;
end Behavioral;
