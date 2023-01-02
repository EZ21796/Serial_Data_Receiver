library ieee;

use ieee.std_logic_1164.all;

entity top_level is
port (
    SI : in std_logic; -- SERIAL DATA INPUT
    clk : in std_logic; -- CLOCK
    reset : in std_logic; -- RESET
    D : out std_logic_vector (7 downto 0); -- PARALLEL DATA OUTPUT
    drdy : out std_logic); -- DATA READY FLAG
end top_level;

architecture top_level_arch of top_level is



--begin



-- START COMPONENT :CONTROL FSM
component CONTROL
    port (CLK : in std_logic; -- CLOCK
          Q : in std_logic_vector(7 downto 3); -- COUNTER VALUE
          RESET : in std_logic; -- RESET
          SI : in std_logic; -- SERIAL DATA INPUT
          CLR : out std_logic; -- CLEAR COUNTERS/REGSITERS ETC
          DRDY : out std_logic; -- DATA READY FLAG
          ENSR : out std_logic -- ENABLE SHIFT
          );
end component;

component CNT8m
    Port ( clk : in std_logic; --CLOCK
           --clr : in std_logic; -- CLEAR (SYNC)
           m : in std_logic_vector(1 downto 0); -- m INPUT
           q : out std_logic_vector(7 downto 0)); -- COUNTER OUTPUT
end component;

component shiftd
   port(din : in std_logic; -- DATA IN
        en : in std_logic; -- CHIP ENABLE
        clk : in std_logic; -- CLOCK
        y : out std_logic_vector(7 downto 0); -- SHIFTER OUTPUT
        dirup : in std_logic); -- SHIFT DIRECTION

end component;




------------------SIGNALS
------Controller
signal Q : std_logic_vector (7 downto 0);
signal CLEAR,ENSR : std_logic;
signal GND : std_logic :='0' ;
signal VCC: std_logic := '1';
----shifter


----- Counter

signal m : std_logic_vector(1 downto 0);

begin



-- INSTANTIATE CONTROLLER AS TYPE CONTROL
Controller : control
port map(
   clk => clk,
   q => q(7 downto 3),
   reset => reset,
   SI => SI,
   clr => CLEAR,
   drdy => drdy,
   ensr => ENSR
   );
   
shifter : shiftd
port map(
   clk => clk,
   din => SI,
   dirup => GND,
   y => D (7 downto 0),
   en => ENSR
   );


counter : CNT8m
port map(
   clk => clk,
   q => q(7 downto 0),
   m(1) => CLEAR,
   m(0) => VCC
   );


end top_level_arch;