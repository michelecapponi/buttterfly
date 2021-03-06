library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROUND_TO_NEAREST_EVEN is
	GENERIC( N   : INTEGER:=20);
	port(
		   IN_TO_ROUND   : in signed(2*N-1 downto 0);
         clock         : in std_logic;
			resetn        : in std_logic;
			en_round      : in std_logic;
			ROUNDED_DATA  : out signed(N-1 downto 0));
end ROUND_TO_NEAREST_EVEN;


ARCHITECTURE BEHAVIOR OF ROUND_TO_NEAREST_EVEN IS

SIGNAL PIPE_IN_TO_ROUND: SIGNED(2*N-1 DOWNTO 0);
SIGNAL SAT, ZERO, HALF_DYN: STD_LOGIC;
SIGNAL ROUNDING_OUT: SIGNED(N-1 DOWNTO 0);
SIGNAL ADDER_IN, ADDER_OUT: SIGNED(N DOWNTO 0);             --l'uscita del sommatore ha 1 bit in più che verrà troncato

BEGIN

ADDER_IN <= (N DOWNTO 1 => '0') & '1';          --creo il segnale che è tutti zeri con l'LSB a '1'

pipe_round: PROCESS (CLOCK, RESETN)
	   BEGIN
		IF RESETN = '0' THEN
			PIPE_IN_TO_ROUND<=(OTHERS=>'0');
		ELSE IF RISING_EDGE(CLOCK) THEN
			IF  en_round='1' THEN
				PIPE_IN_TO_ROUND<=IN_TO_ROUND;
			END IF;
	   END IF;
		END IF;
END PROCESS pipe_round;
			
check_sat: PROCESS (PIPE_IN_TO_ROUND(2*N-1 DOWNTO N))       --faccio una AND tra tutti i bit significativi e l'MSB negato per controllare la saturazione
VARIABLE temp : STD_LOGIC;
		BEGIN
		temp := '1';
		AND_LOOP : FOR i IN N TO 2*N-2 LOOP
			temp := temp AND PIPE_IN_TO_ROUND(i);
		END LOOP AND_LOOP;
		temp := temp AND NOT(PIPE_IN_TO_ROUND(2*N-1));
		SAT <= temp;
END PROCESS check_sat;

check_zero: PROCESS (PIPE_IN_TO_ROUND(2*N-1 DOWNTO N))       --faccio una AND tra tutti i bit significativi
VARIABLE temp : STD_LOGIC;
		BEGIN
		temp := '1';
		AND_LOOP : FOR i IN N TO 2*N-1 LOOP
			temp := temp AND PIPE_IN_TO_ROUND(i);
		END LOOP AND_LOOP;
		ZERO <= temp;
END PROCESS check_zero;

check_half_dyn: PROCESS (PIPE_IN_TO_ROUND(N-1 DOWNTO 0))       --faccio una AND tra tutti i bit non significativi negati e l'MSB normale per controllare se mi trovo a metà dinamica
VARIABLE temp : STD_LOGIC;
		BEGIN
		temp := '1';
		AND_LOOP : FOR i IN 0 TO N-2 LOOP
			temp := temp AND NOT(PIPE_IN_TO_ROUND(i));
		END LOOP AND_LOOP;
		temp := temp AND (PIPE_IN_TO_ROUND(N-1));
		HALF_DYN <= temp;
END PROCESS check_half_dyn;

rounding: PROCESS (PIPE_IN_TO_ROUND, HALF_DYN, ZERO, ADDER_IN, ADDER_OUT)                          --processo che effettua l'arrotondamento del dato istanziando il sommatore
		BEGIN
		ADDER_OUT<=PIPE_IN_TO_ROUND(2*N-1 DOWNTO N-1)+ADDER_IN;
		IF(PIPE_IN_TO_ROUND(N)='1') THEN              --controllo se è un numero pari o dispari
			IF(ZERO='1') THEN                          -- controllo se c'è uno zero di '1'
				ROUNDING_OUT<=(OTHERS=>'0');            --arrotondo a zero se è presente
			ELSE
				ROUNDING_OUT<=ADDER_OUT(N DOWNTO 1);    --sommo e tronco se è dispari
			END IF;
		ELSE                                          --altrimenti se è pari devo capire se mi trovo a metà dinamica (dopo la virgola "1 e tutti zeri")
			IF(HALF_DYN='1') THEN
				ROUNDING_OUT<=PIPE_IN_TO_ROUND(2*N-1 DOWNTO N);  --se mi trovo a metà dinamica tronco senza sommare
			ELSE
				ROUNDING_OUT<=ADDER_OUT(N DOWNTO 1);  --se non mi trovo a metà dinamica sommo e tronco
			END IF;
		END IF;
END PROCESS rounding;

output_generation: PROCESS(SAT,PIPE_IN_TO_ROUND,ROUNDING_OUT)    --MUX che sceglie l'uscita da fornire, il dato troncato se c'è saturazione altrimenti il dato arrotondato
		BEGIN
		IF SAT='1' THEN
			ROUNDED_DATA<=PIPE_IN_TO_ROUND(2*N-1 DOWNTO N);
		ELSE
			ROUNDED_DATA<=ROUNDING_OUT;
		END IF;
END PROCESS output_generation;

END BEHAVIOR;