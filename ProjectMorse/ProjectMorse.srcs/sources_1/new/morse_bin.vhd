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

begin
  clk_en0 : entity work.clock_enable
    generic map (
      -- FOR SIMULATION, KEEP THIS VALUE TO 1
      -- FOR IMPLEMENTATION, CALCULATE VALUE: 250 ms / (1/100 MHz) aka 250ms*100MHz
      -- 1   @ 10 ns
      -- ??? @ 250 ms
      -- 10000000 -- 100ms
      -- 5 -- 50ns
      g_MAX => 5
    )
    port map (
      clk => clk,
      ce  => sig_en
    );
    
    p_morse_bin_decoder : process (clk) is
    
    begin
        
    end process p_morse_bin_decoder;

end Behavioral;
