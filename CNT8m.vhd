-- Group Number:   SDR_test.vhd
-- People in the group: 	Dheeraj Polanki - ez21796
--						 	Siraj Salih		- ik21797
--							
-- Target Device:  








library IEEE; -- INCLUDE IEEE LIBRARY 
use IEEE.STD_LOGIC_1164.ALL; --USE all components to std_logic_1164 package in ieee library
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--8 bit counter
entity CNT8m is
    Port ( clk : in std_logic; --CLOCK
           --clr : in std_logic; -- CLEAR (SYNC)
           m : in std_logic_vector(1 downto 0); -- m INPUT
           q : out std_logic_vector(7 downto 0)); -- COUNTER OUTPUT
end CNT8m;

architecture CNT8m_arch of CNT8m is

--SIGNALS 
signal c_value : integer range 0 to 255; -- ONLY NEED 0 TO 255 (8 BITS)

begin

-- PROCESS : DECREMENT COUNTER
increment : process (clk)
begin
	if rising_edge(clk) then
	   if m="11" then -- check reset
	      c_value<=0; -- RESET
	   elsif m="01" then
       			if c_value=255 then c_value<= 0;
                else c_value<=c_value+1;-- INCREMENT
                end if;
                             
	   elsif m="00" then
	      c_value<=c_value;-- Stays the same
	   elsif m="10" then
	     if c_value=0 then -- Check overflow
	         c_value<=255;
	     else c_value<=c_value-1;-- DECREMENT
	     end if;
	   end if;
	--else null;
	end if;
end process;
q<=conv_std_logic_vector(c_value,8); -- convert integer to bit string
end CNT8m_arch;


