----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2023 01:08:51 PM
-- Design Name: 
-- Module Name: top_receiver - Behavioral
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

entity top_receiver is
    Port ( CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);           
           BTNC : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           JD : in STD_LOGIC
           );
end top_receiver;

architecture Behavioral of top_receiver is

signal s_bin : std_logic_vector(4 downto 0);

begin
  bin2seg : entity work.bin_7seg
    port map (
      blank  => BTNC,
      bin    => s_bin,
      seg(7) => CA,
      seg(6) => CB,
      seg(5) => CC,
      seg(4) => CD,
      seg(3) => CE,
      seg(2) => CF,
      seg(1) => CG,
      seg(0) => DP
    );
    
  morse2bin : entity work.morse_bin
    port map (
      morse => JD,
      bin => s_bin,
      clk => CLK100MHZ
  );

   AN <= b"0111_1111";
end Behavioral;
