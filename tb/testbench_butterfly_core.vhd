LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY TESTBENCH_BUTTERFLY_CORE IS
END ENTITY;

ARCHITECTURE BEHAVIOR OF TESTBENCH_BUTTERFLY_CORE IS 

COMPONENT BUTTERFLY_CORE IS
GENERIC( N   : INTEGER:=20);
	PORT(
		Ar         : in signed(N-1 downto 0);
        Ai         : in signed(N-1 downto 0);
		Br         : in signed(N-1 downto 0);
        Bi         : in signed(N-1 downto 0);
		Wr         : in signed(N-1 downto 0);
        Wi         : in signed(N-1 downto 0);
		start      : in std_logic;
		clock      : in std_logic;
		resetn     : in std_logic;
		done       : out std_logic;
		Ar_out     : out signed(N-1 downto 0);
        Ai_out     : out signed(N-1 downto 0);
		Br_out     : out signed(N-1 downto 0);
        Bi_out     : out signed(N-1 downto 0)		  
		  );
END COMPONENT;

SIGNAL CLK, RST_N,start,done: STD_LOGIC;
SIGNAL Ar, Ai, Br, Bi, Wr, Wi, Ar_out, Ai_out, Br_out, Bi_out: SIGNED(19 DOWNTO 0);
SIGNAL Ar_bus, Ai_bus, Br_bus, Bi_bus, Wr_bus, Wi_bus: STD_LOGIC_VECTOR (19 DOWNTO 0);
SIGNAL END_FILE, SAVE_DATA, START_DEL: STD_LOGIC;

BEGIN


Ar<= SIGNED(Ar_bus);
Ai<= SIGNED(Ai_bus);
Br<= SIGNED(Br_bus);
Bi<= SIGNED(Bi_bus);
Wr<= SIGNED(Wr_bus);
Wi<= SIGNED(Wi_bus);

CLOCK_PROCESS : PROCESS 
BEGIN
CLK <= '1';
WAIT FOR 5 NS;
CLK <= '0';
WAIT FOR 5 NS;
END PROCESS CLOCK_PROCESS;

---------------------------------------------------
RST_PROCESS : PROCESS 
BEGIN
RST_N <= '0';
WAIT FOR 30 NS;
RST_N <= '1';
WAIT FOR 2 SEC;
END PROCESS RST_PROCESS;
---------------------------------------------------
start_PROCESS: PROCESS
BEGIN 
start<='0';
WAIT FOR 110 NS;
while(END_FILE='0') loop
	start<='1';
	wait for 10 ns;
	start<='0';
	wait for 50 ns;       --110 ESECUZIONE SINGOLA 50 ESECUZIONE CONTINUA
end loop;

END PROCESS start_PROCESS;
---------------------------------------------------

LOAD_INPUT_SAMPLES : PROCESS 
FILE INFILE : TEXT IS IN "samples.txt";
VARIABLE L : LINE;
VARIABLE N : STD_LOGIC_VECTOR(19 DOWNTO 0);
BEGIN
	Ar_bus<=b"00000000000000000000";
	Ai_bus<=b"00000000000000000000";
	Br_bus<=b"00000000000000000000";
	Bi_bus<=b"00000000000000000000";
	Wr_bus<=b"00000000000000000000";
	Wi_bus<=b"00000000000000000000";
	END_FILE<='0';
  WAIT FOR 120 NS;  --1 colpo dopo lo start
WHILE (ENDFILE(INFILE) = FALSE) LOOP


	READLINE(INFILE, L);
	READ(L,N);
	Ar_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	Ai_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	Br_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	Bi_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	Wr_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	Wi_bus <= N;

	WAIT UNTIL START_DEL='1';

END LOOP;
END_FILE<='1';
WAIT;
END PROCESS LOAD_INPUT_SAMPLES;
-----------------------------------------------------
START_DEL <= START after 10 ns;
SAVE_DATA <= DONE after 10 ns;
-----------------------------------------------------
OUT_TO_FILE: PROCESS (DONE,Ar_out,Ai_out,Br_out,Bi_out,CLK)
FILE OUTFILE : TEXT IS OUT "output_butterfly_modelsim.txt";
VARIABLE L : LINE;
VARIABLE N : STD_LOGIC_VECTOR (19 DOWNTO 0);
--VARIABLE I : INTEGER := 0;	
BEGIN
IF CLK'EVENT AND CLK ='0' THEN
  IF SAVE_DATA='1' THEN


	N:= STD_LOGIC_VECTOR(Ar_out);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Ai_out);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Br_out);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Bi_out);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	END IF;
END IF;
END PROCESS OUT_TO_FILE;
-----------------------------------------------------

CORE: BUTTERFLY_CORE GENERIC MAP(N=>20) PORT MAP(Ar=>Ar, Ai=>Ai, Br=>Br, Bi=>Bi, Wr=>Wr, Wi=>Wi, start=>start,
																  done=>done, Ar_out=>Ar_out, Ai_out=>Ai_out, 
																  Br_out=>Br_out, Bi_out=>Bi_out, clock=>clk, resetn=>rst_n);
END BEHAVIOR;
