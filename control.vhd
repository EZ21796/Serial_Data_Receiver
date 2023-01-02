library ieee;

use ieee.std_logic_1164.all;

entity control is
    port (CLK : in std_logic; -- CLOCK
          Q : in std_logic_vector(7 downto 3); -- COUNTER VALUE
          RESET : in std_logic; -- RESET
          SI : in std_logic; -- SERIAL DATA INPUT
          CLR : out std_logic; -- CLEAR COUNTERS/REGSITERS ETC
          DRDY : out std_logic; -- DATA READY FLAG
          ENSR : out std_logic -- ENABLE SHIFT
          );
end control;

architecture control_arch of control is

type state_type is (s0,s1,s2,s3); --Definition of custom type to hold states.  You may add or remove states here.

signal next_state,current_state : state_type; --SIGNALS
signal counter_q3 : std_logic;

begin

control : process(current_state,si,q) --process for combinatorial logic

--Declaration of Variables
variable v_state : state_type;
variable v_clr,v_drdy,v_ensr : std_logic;
variable v_counter_q3 : std_logic;

begin
--YOU SHOULD INITIALISE YOUR VARIABLES HERE
v_state:=current_state;
v_clr:='0';
v_drdy:='0';
v_ensr:='0';


case v_state is

    when s0 =>
    --Detects the drop
        if SI='0' then v_clr:='1'; v_state:=s1;
        else  	  v_state:=s0;
        end if;

    when s1 =>
    --Validates if the start bit is not a glitch or noise
        if rising_edge(Q(3)) and SI='0'    then v_clr:='1'; v_state:=s2;
        elsif rising_edge(Q(3)) and SI='1' then v_state:=s0;
        end if;


    when s2 =>
	--Loops through the data until the last bit
        if Q="10000" and SI='1' then v_drdy:='1'; v_state:=s0;
        
        else
            if Q(3)='1'    	then v_state:=s3;
            elsif Q(3)='0' 	then v_state:=s2;
        	end if;
        end if;

    when s3 =>
    --After evvery bit shift register
        if Q(3)='1'    		then v_state:=s3;
        elsif Q(3)='0'      then v_state:=s2; v_ensr:='1';
        end if;





--------------------------------------------------------------                

    when others => NULL;--ENTER DEFAULT CODE FOR OTHER EVENTUALITIES

    end case;

--ASSIGN VARIABLES TO SIGNALS
next_state<=v_state;
CLR<=v_clr;
DRDY<=v_drdy;
ENSR<=v_ensr;

end process;

registers :process(clk,reset) --process for registers


begin
    --ENTER CODE TO COPY NEW STATE TO REGISTER ON RISING CLOCK EDGE
       if reset='1' 			then current_state<=s0;
       elsif rising_edge(clk) 	then current_state<=next_state;
       end if;
    --AND RESET STATE TO s0 ON ASYNC RESET
end process;

end control_arch;
