------------------------------------------------------------
--
--! @title One-digit 7-segment display decoder
--! @author Tomas Fryza
--! Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
--!
--! @copyright (c) 2018 Tomas Fryza
--! This work is licensed under the terms of the MIT license
--!
--! Decoder for one-digit Seven-segment display, Common Anode
--! (active-low). Decoder defines 16 hexadecimal symbols: 0, 1,
--! ..., 9, A, b, C, d, E, F. All segments are turn off when
--! "blank" is high. Decimal Point is not implemented.
--
-- Hardware: Nexys A7-50T, xc7a50ticsg324-1L
-- Software: TerosHDL, Vivado 2020.2

library ieee;
  use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for seven7-segment display decoder
------------------------------------------------------------

entity bin_7seg is
  port (
    blank : in    std_logic;                    --! Display is clear if blank = 1
    bin   : in    std_logic_vector(4 downto 0); --! Binary representation of one hexadecimal symbol
    seg   : out   std_logic_vector(7 downto 0)  --! Seven active-low segments in the order: a, b, ..., g
  );
end entity bin_7seg;

------------------------------------------------------------
-- Architecture body for seven-segment display decoder
------------------------------------------------------------

architecture behavioral of bin_7seg is

begin

  p_7seg_decoder : process (blank, bin) is

  begin

    if (blank = '1') then
      seg <= "11111111";     -- Blanking display
    else

      case bin is
    
        when "00001" =>

          seg <= "00010001"; -- A          
      
        when "00010" =>

          seg <= "11000001"; -- B

        when "00011" =>

          seg <= "01100011"; -- C     
          
        when "00100" =>

          seg <= "10000101"; -- D             

        when "00101" =>

          seg <= "01100001"; -- E
          
        when "00110" =>

          seg <= "01110001"; -- F
        
        when "00111" =>

          seg <= "01000011"; -- G
        
        when "01000" =>

          seg <= "11010001"; -- H
        
        when "01001" =>

          seg <= "01110111"; -- I
        
        when "01010" =>

          seg <= "01001111"; -- J
        
        when "01011" =>

          seg <= "01010001"; -- K
        
        when "01100" =>

          seg <= "11100011"; -- L
        
        when "01101" =>

          seg <= "01010101"; -- M
        
        when "01110" =>

          seg <= "11010101"; -- N
        
        when "01111" =>

          seg <= "11000101"; -- O
        
        when "10000" =>

          seg <= "00110001"; -- P
        
        when "10001" =>

          seg <= "00011001"; -- Q
        
        when "10010" =>

          seg <= "11110101"; -- R
        
        when "10011" =>

          seg <= "01001011"; -- S
        
        when "10100" =>

          seg <= "11100001"; -- T
        
        when "10101" =>

          seg <= "11000111"; -- U
        
        when "10110" =>

          seg <= "10101011"; -- V
        
        when "10111" =>

          seg <= "10101001"; -- W
        
        when "11000" =>

          seg <= "11010111"; -- X
        
        when "11001" =>

          seg <= "10001001"; -- Y
        
        when "11010" =>

          seg <= "00100111"; -- Z       

        when others =>

          seg <= "11111111"; -- nothing

      end case;

    end if;

  end process p_7seg_decoder;

end architecture behavioral;
