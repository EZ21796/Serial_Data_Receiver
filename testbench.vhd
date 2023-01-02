

--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:58:44 07/25/2005
-- Design Name:   top_level
-- Module Name:   SDR_test.vhd
-- Project Name:  SDR_LAB_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_level
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY tb_top_level IS END;

ARCHITECTURE tb_top_level_arch OF tb_top_level IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT top_level
	PORT(
		SI : IN std_logic;
		CLK : IN std_logic;
		RESET : IN std_logic;          
		D : OUT std_logic_vector(7 downto 0);
		DRDY : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL SI :  std_logic := '0';
	SIGNAL CLK :  std_logic := '0';
	SIGNAL RESET :  std_logic := '0';

	--Outputs
	SIGNAL D :  std_logic_vector(7 downto 0);
	SIGNAL DRDY :  std_logic;
	

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: top_level PORT MAP(
		SI => SI,
		CLK => CLK,
		RESET => RESET,
		D => D,
		DRDY => DRDY
	);
   
   --PROCESS : CLOCK WITYH 100 ns TIME PERIOD
	clock : PROCESS
	BEGIN
		wait for 50 ns;
   		CLK<='1';
      wait for 50 ns;
	   CLK<='0';	
	END PROCESS;
   
   --PROCESS : POWER UP RESET
   p_reset: process
   begin
      reset<='1';
      wait for 200 ns;
      reset<='0';
      wait;  
   end process;
   
   --PROCESS : DATA INPUT
   data : process
   begin
       SI<='1'; --STOP BIT
       wait for 1650 ns;
       SI<='0'; -- START BIT
       wait for 1600 ns;
       ---DATA STARTS HERE (10011001)
       SI<='1';
       wait for 1600 ns;
       SI<='0';
       wait for 1600 ns;
       SI<='0';
       wait for 1600 ns;
       SI<='1';
       wait for 1600 ns;
       SI<='1';
       wait for 1600 ns;
       SI<='0';
       wait for 1600 ns;
       SI<='0';
       wait for 1600 ns;
       SI<='1'; 
       wait for 1600 ns;
       SI<='1'; --STOP BIT
       wait for 1700 ns;
       SI<='0'; -- START BIT
       wait for 1600 ns;
       ---DATA STARTS HERE (10011011)
       SI<='1';
       wait for 1600 ns;
       SI<='1';
       wait for 1600 ns;
       SI<='0';
       wait for 1600 ns;
       SI<='1';
       wait for 1600 ns;
       SI<='1';
       wait for 1600 ns;
       SI<='0';
       wait for 1600 ns;
       SI<='0';
       wait for 1600 ns;
       SI<='1'; 
       wait for 1700 ns;
       SI<='1'; --STOP BIT
       wait for 1600 ns;
	   --CHECK FOR GLITCHED START BIT
	   SI<='0'; -- START BIT GLITCHED
       wait for 200 ns;
	   SI<='1'; --STOP BIT
       wait for 1600 ns;
	   --CHECK WHEN TRANSMITTER RUNS SLIGHTLY SLOWER
	   SI<='0'; -- START BIT
       wait for 1650 ns;
	   ---DATA STARTS HERE (10101001)
	   SI<='1';
       wait for 1650 ns;
       SI<='0';
       wait for 1650 ns;
       SI<='0';
       wait for 1650 ns;
       SI<='1';
       wait for 1650 ns;
       SI<='0';
       wait for 1650 ns;
       SI<='1';
       wait for 1650 ns;
       SI<='0';
       wait for 1650 ns;
       SI<='1'; 
       wait for 1650 ns;
       SI<='1'; --STOP BIT
	   wait;
   end process;
END tb_top_level_arch;
