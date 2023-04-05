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
    seg   : out   std_logic_vector(6 downto 0)  --! Seven active-low segments in the order: a, b, ..., g
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
      seg <= "1111111";     -- Blanking display
    else

      case bin is
    
        when "00001" =>

          seg <= "0001000"; -- A          
      
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
