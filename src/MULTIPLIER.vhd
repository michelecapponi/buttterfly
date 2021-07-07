library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MULTIPLIER is
	GENERIC( N   : INTEGER:=20);
	port(
		  mult_in_A  : in signed(N-1 downto 0);
        mult_in_B  : in signed(N-1 downto 0);
        sh_mult_n  : in std_logic;
		  clock      : in std_logic;
		  resetn     : in std_logic;  
		  mult_out   : out signed(2*N-1 downto 0));
end MULTIPLIER;


ARCHITECTURE BEHAVIOR OF MULTIPLIER IS


signal A,B: signed(N-1 downto 0);

BEGIN


	
pipe_mult: PROCESS (CLOCK, RESETN)
	   BEGIN
		IF RESETN = '0' THEN
			A<=(OTHERS=>'0');
			B<=(OTHERS=>'0');
		ELSE IF RISING_EDGE(CLOCK) THEN
			A<=mult_in_A;
			B<=mult_in_B;
		END IF;
	   END IF;
	   END PROCESS pipe_mult;
	
	
mult: PROCESS(A,B,sh_mult_n)
			BEGIN
			IF sh_mult_n='0' THEN
				mult_out<=A*B;
			ELSE
				--mult_out<= (N*2-1 DOWNTO N-1 => B(N-1)) & B(N-3 DOWNTO 0) & '0';
				mult_out<= '0' & B(N-1) & B(N-3 downto 0) & (N-1 DOWNTO 0 => '0');
			END IF;
			END PROCESS mult;
				
	
END BEHAVIOR;