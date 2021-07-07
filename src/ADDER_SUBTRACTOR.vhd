library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADDER_SUBTRACTOR is
	GENERIC( N   : INTEGER:=40);
	port(
		  adder_in_A : in signed(N-1 downto 0);
        adder_in_B : in signed(N-1 downto 0);
        sub_add_n  : in std_logic;
		  clock      : in std_logic;
		  resetn     : in std_logic;  
		  adder_out  : out signed(N-1 downto 0));
end ADDER_SUBTRACTOR;


ARCHITECTURE BEHAVIOR OF ADDER_SUBTRACTOR IS


signal A,B: signed(N-1 downto 0);

BEGIN


	
pipe_adder: PROCESS (CLOCK, RESETN)
	   BEGIN
		IF RESETN = '0' THEN
			A<=(OTHERS=>'0');
			B<=(OTHERS=>'0');
		ELSE IF RISING_EDGE(CLOCK) THEN
			A<=adder_in_A;
			B<=adder_in_B;
		END IF;
	   END IF;
	   END PROCESS pipe_adder;
	
	
add_sub: PROCESS(A,B,sub_add_n)
			BEGIN
			IF sub_add_n='0' THEN
				adder_out<=A+B;
			ELSE
				adder_out<=A-B;
			END IF;
			END PROCESS add_sub;
				
	
END BEHAVIOR;