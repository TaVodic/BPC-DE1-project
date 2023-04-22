----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2023 02:10:52 PM
-- Design Name: 
-- Module Name: tb_morse_bin - Behavioral
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

entity tb_morse_bin is
--  Port ( );
end tb_morse_bin;

architecture Behavioral of tb_morse_bin is
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    
    signal s_clk_100MHz : std_logic;
    signal s_bin        : std_logic_vector(4 downto 0);
    signal s_morse      : std_logic;
begin
    uut_tb_morse_bin : entity work.morse_bin
    port map(
        clk     => s_clk_100MHz,        
        bin     => s_bin,
        morse   => s_morse        
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
        
        s_morse <= '0';
        wait for 100 ns; -- start
        s_morse <= '1'; 
        wait for 150 ns; -- 1
        s_morse <= '0';
        wait for 50 ns;
        s_morse <= '1';
        wait for 50 ns;  -- 2
        s_morse <= '0';
        wait for 50 ns;
        s_morse <= '1';    
        wait for 50 ns;  -- 3
        s_morse <= '0';
        wait for 50 ns;
        s_morse <= '1';    
        wait for 50 ns;  -- 4
        s_morse <= '0';
        wait;
        
        wait for 50 ns;
        s_morse <= '1';    
        wait for 150 ns; -- 5
        s_morse <= '0';

        report "Stimulus process finished";
        wait;
    end process p_stimulus;

end Behavioral;
