library ieee;

use ieee.std_logic_1164.all;

entity shiftd is
    port (

        din : in std_logic; -- DATA IN
        en : in std_logic; -- CHIP ENABLE
        clk : in std_logic; -- CLOCK
        y : out std_logic_vector(7 downto 0); -- SHIFTER OUTPUT
        dirup : in std_logic); -- SHIFT DIRECTION

end shiftd;

architecture shiftd_arch of shiftd is

--SIGNALS
signal s_register : std_logic_vector (7 downto 0); --REGISTER CONTENTS
begin

--PROCESS : SHIFT
shift : process (clk)
begin
    if rising_edge(clk) and en='1' then -- FULLY SYNCHRONOUS AND ENABLED
      if dirup='1' then
       for i in 7 downto 1 loop 
          s_register(i) <= s_register(i-1); -- SHIFT ALL BITS UP 1
       end loop;
        s_register(0) <= din;  -- INSERT DATA BIT IN LSB
      elsif dirup='0' then
       for j in 0 to 6 loop 
          s_register(j) <= s_register(j+1); -- SHIFT ALL BITS DOWN 1
       end loop;
       s_register(7) <= din;  -- INSERT DATA BIT IN MSB
      else null;
      end if;
       --s_register(0) <= din;  -- INSERT DATA BIT IN LSB
    else null;
    end if;
end process;
y <= s_register; -- WRITE REGISTER CONTENTS TO OUTPUT
end shiftd_arch;



