LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY REG IS
	GENERIC( N   : INTEGER:=20);
	PORT (D      : IN SIGNED(N-1 DOWNTO 0);
			CLOCK  : IN STD_LOGIC;
			ENABLE : IN STD_LOGIC;
			RESETN : IN STD_LOGIC;
			Q      : OUT SIGNED(N-1 DOWNTO 0));
END REG;

ARCHITECTURE BEHAVIOR OF REG  IS

BEGIN
	
	PROCESS (RESETN,CLOCK)
	BEGIN
		 IF RESETN = '0' THEN
			 Q<=(OTHERS=>'0');
		 ELSIF RISING_EDGE(CLOCK) THEN
			IF (ENABLE = '1') THEN
				Q<=D;
			END IF;
		 END IF;
	END PROCESS;
	
END BEHAVIOR;