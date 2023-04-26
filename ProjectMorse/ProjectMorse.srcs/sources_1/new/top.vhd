----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2023 01:55:27 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port ( SW : in STD_LOGIC_VECTOR (4 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           BTNC : in STD_LOGIC;
           BTND : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           IRLED : out STD_LOGIC;
           BU : out STD_LOGIC
           );
end top;

------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------

architecture behavioral of top is

signal temp_irled : std_logic; 

begin

  --------------------------------------------------------------------
  -- Instance (copy) of hex_7seg entity
  --------------------------------------------------------------------

  bin2seg : entity work.bin_7seg
    port map (
      blank  => BTNC,
      bin    => SW,
      seg(7) => CA,
      seg(6) => CB,
      seg(5) => CC,
      seg(4) => CD,
      seg(3) => CE,
      seg(2) => CF,
      seg(1) => CG,
      seg(0) => DP
    );
    
    bin2morse : entity work.bin_morse
    port map (
      morse => IRLED,
      send => BTND,
      bin => SW,
      clk => CLK100MHZ,
      buzz => BU
    );
   
  -- Connect one common anode to 3.3V
  AN <= b"1111_1110";
end architecture behavioral;
