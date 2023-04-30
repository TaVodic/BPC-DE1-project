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

entity tb_bin_morse is
   
end tb_bin_morse;

architecture Behavioral of tb_bin_morse is
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    
    signal s_clk_100MHz : std_logic;
    signal s_bin        : std_logic_vector(4 downto 0);
    signal s_morse      : std_logic;
    signal s_send       : std_logic;
    signal s_sig_en     : std_logic;
begin
    uut_tb_bin_morse : entity work.bin_morse
    port map(
        clk     => s_clk_100MHz,        
        bin     => s_bin,
        morse   => s_morse,
        send    => s_send       
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
    
    p_reset_gen : process
    begin
    
        s_send <= '0';
        wait for 100 ns;
        s_send <= '1';
        wait for 100 ns;
        s_send <= '0';
        wait for 100 ns;
        s_send <= '1';
        wait for 100 ns;
        s_send <= '0';
        wait for 100 ns;
        s_send <= '1';
        wait for 100 ns;
        s_send <= '0';
        wait for 100 ns;
        s_send <= '1';
        wait for 100 ns;
        s_send <= '0';
        
        wait;
    end process p_reset_gen;

    p_stimulus : process
    begin
        report "Stimulus process started";
        
        s_bin <= "11010";   -- Z
        wait for 250 ns;
        s_bin <= "00001";   -- A
        wait for 200 ns;
        s_bin <= "00010";   -- B
        wait for 200 ns;
        s_bin <= "01000";   -- H

        report "Stimulus process finished";
        wait;
    end process p_stimulus;
end Behavioral;
