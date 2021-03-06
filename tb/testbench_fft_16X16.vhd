LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY TESTBENCH_FFT_16X16 IS
END ENTITY;

ARCHITECTURE BEHAVIOR OF TESTBENCH_FFT_16X16 IS 

COMPONENT FFT_16X16 IS
GENERIC( N   : INTEGER:=20);
	PORT(
		r0         : in signed(N-1 downto 0);
        i0         : in signed(N-1 downto 0);
		r1         : in signed(N-1 downto 0);
        i1         : in signed(N-1 downto 0);
		r2         : in signed(N-1 downto 0);
        i2         : in signed(N-1 downto 0);
		r3         : in signed(N-1 downto 0);
        i3         : in signed(N-1 downto 0);
		r4         : in signed(N-1 downto 0);
        i4         : in signed(N-1 downto 0);
		r5         : in signed(N-1 downto 0);
        i5         : in signed(N-1 downto 0);
		r6         : in signed(N-1 downto 0);
        i6         : in signed(N-1 downto 0);
		r7         : in signed(N-1 downto 0);
        i7         : in signed(N-1 downto 0);
		r8         : in signed(N-1 downto 0);
        i8         : in signed(N-1 downto 0);
		r9         : in signed(N-1 downto 0);
        i9         : in signed(N-1 downto 0);
		r10        : in signed(N-1 downto 0);
        i10        : in signed(N-1 downto 0);
		r11        : in signed(N-1 downto 0);
        i11        : in signed(N-1 downto 0);
		r12        : in signed(N-1 downto 0);
        i12        : in signed(N-1 downto 0);
		r13        : in signed(N-1 downto 0);
        i13        : in signed(N-1 downto 0);
		r14        : in signed(N-1 downto 0);
        i14        : in signed(N-1 downto 0);
		r15        : in signed(N-1 downto 0);
        i15        : in signed(N-1 downto 0);
		start      : in std_logic;
		clock      : in std_logic;
		resetn     : in std_logic;
		done       : out std_logic;
		Xr0        : out signed(N-1 downto 0);
        Xi0        : out signed(N-1 downto 0);
		Xr1        : out signed(N-1 downto 0);
        Xi1        : out signed(N-1 downto 0);
        Xr2        : out signed(N-1 downto 0);
        Xi2        : out signed(N-1 downto 0);
        Xr3        : out signed(N-1 downto 0);
        Xi3        : out signed(N-1 downto 0);
        Xr4        : out signed(N-1 downto 0);
        Xi4        : out signed(N-1 downto 0);
        Xr5        : out signed(N-1 downto 0);
        Xi5        : out signed(N-1 downto 0);
        Xr6        : out signed(N-1 downto 0);
        Xi6        : out signed(N-1 downto 0);
        Xr7        : out signed(N-1 downto 0);
        Xi7        : out signed(N-1 downto 0);
        Xr8        : out signed(N-1 downto 0);
        Xi8        : out signed(N-1 downto 0);
        Xr9        : out signed(N-1 downto 0);
        Xi9        : out signed(N-1 downto 0);
        Xr10       : out signed(N-1 downto 0);
        Xi10       : out signed(N-1 downto 0);
        Xr11       : out signed(N-1 downto 0);
        Xi11       : out signed(N-1 downto 0);
        Xr12       : out signed(N-1 downto 0);
        Xi12       : out signed(N-1 downto 0);
        Xr13       : out signed(N-1 downto 0);
        Xi13       : out signed(N-1 downto 0);
        Xr14       : out signed(N-1 downto 0);
        Xi14       : out signed(N-1 downto 0);
        Xr15       : out signed(N-1 downto 0);
        Xi15       : out signed(N-1 downto 0)		  
		  );

END COMPONENT;

SIGNAL CLK, RST_N,start,done: STD_LOGIC;

SIGNAL r0, i0, r1, i1, r2, i2, r3, i3, r4, i4, r5, i5, r6, i6, r7, i7, r8, i8, r9, i9, 
	   r10, i10, r11, i11, r12, i12, r13, i13, r14, i14, r15, i15, Xr0, Xi0, Xr1, Xi1, Xr2,
	   Xi2, Xr3, Xi3, Xr4, Xi4, Xr5, Xi5, Xr6, Xi6, Xr7, Xi7, Xr8, Xi8, Xr9, Xi9, Xr10, Xi10,
	   Xr11, Xi11, Xr12, Xi12, Xr13, Xi13, Xr14, Xi14, Xr15, Xi15 : SIGNED (19 DOWNTO 0);

SIGNAL r0_bus, i0_bus, r1_bus, i1_bus, r2_bus, i2_bus, r3_bus, i3_bus, r4_bus, i4_bus, 
	   r5_bus, i5_bus, r6_bus, i6_bus, r7_bus, i7_bus, r8_bus, i8_bus, r9_bus, i9_bus, 
	   r10_bus, i10_bus, r11_bus, i11_bus, r12_bus, i12_bus, r13_bus, i13_bus, r14_bus,
	   i14_bus, r15_bus, i15_bus : STD_LOGIC_VECTOR (19 DOWNTO 0);

SIGNAL END_FILE, SAVE_DATA, START_DEL: STD_LOGIC;

BEGIN


r0<= SIGNED(r0_bus);
i0<= SIGNED(i0_bus);
r1<= SIGNED(r1_bus);
i1<= SIGNED(i1_bus);
r2<= SIGNED(r2_bus);
i2<= SIGNED(i2_bus);
r3<= SIGNED(r3_bus);
i3<= SIGNED(i3_bus);
r4<= SIGNED(r4_bus);
i4<= SIGNED(i4_bus);
r5<= SIGNED(r5_bus);
i5<= SIGNED(i5_bus);
r6<= SIGNED(r6_bus);
i6<= SIGNED(i6_bus);
r7<= SIGNED(r7_bus);
i7<= SIGNED(i7_bus);
r8<= SIGNED(r8_bus);
i8<= SIGNED(i8_bus);
r9<= SIGNED(r9_bus);
i9<= SIGNED(i9_bus);
r10<= SIGNED(r10_bus);
i10<= SIGNED(i10_bus);
r11<= SIGNED(r11_bus);
i11<= SIGNED(i11_bus);
r12<= SIGNED(r12_bus);
i12<= SIGNED(i12_bus);
r13<= SIGNED(r13_bus);
i13<= SIGNED(i13_bus);
r14<= SIGNED(r14_bus);
i14<= SIGNED(i14_bus);
r15<= SIGNED(r15_bus);
i15<= SIGNED(i15_bus);

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
	wait for 110 ns;       --110 ESECUZIONE SINGOLA 50 ESECUZIONE CONTINUA
end loop;

END PROCESS start_PROCESS;
---------------------------------------------------

LOAD_INPUT_SAMPLES : PROCESS 
FILE INFILE : TEXT IS IN "input_fft.txt";
VARIABLE L : LINE;
VARIABLE N : STD_LOGIC_VECTOR(19 DOWNTO 0);
BEGIN
	r0_bus<=b"00000000000000000000";
	i0_bus<=b"00000000000000000000";
	r1_bus<=b"00000000000000000000";
	i1_bus<=b"00000000000000000000";
	r2_bus<=b"00000000000000000000";
	i2_bus<=b"00000000000000000000";
	r3_bus<=b"00000000000000000000";
	i3_bus<=b"00000000000000000000";
	r4_bus<=b"00000000000000000000";
	i4_bus<=b"00000000000000000000";
	r5_bus<=b"00000000000000000000";
	i5_bus<=b"00000000000000000000";
	r6_bus<=b"00000000000000000000";
	i6_bus<=b"00000000000000000000";
	r7_bus<=b"00000000000000000000";
	i7_bus<=b"00000000000000000000";
	r8_bus<=b"00000000000000000000";
	i8_bus<=b"00000000000000000000";
	r9_bus<=b"00000000000000000000";
	i9_bus<=b"00000000000000000000";
	r10_bus<=b"00000000000000000000";
	i10_bus<=b"00000000000000000000";
	r11_bus<=b"00000000000000000000";
	i11_bus<=b"00000000000000000000";
	r12_bus<=b"00000000000000000000";
	i12_bus<=b"00000000000000000000";
	r13_bus<=b"00000000000000000000";
	i13_bus<=b"00000000000000000000";
	r14_bus<=b"00000000000000000000";
	i14_bus<=b"00000000000000000000";
	r15_bus<=b"00000000000000000000";
	i15_bus<=b"00000000000000000000";
	END_FILE<='0';
  WAIT FOR 120 NS;  --1 colpo dopo lo start
WHILE (ENDFILE(INFILE) = FALSE) LOOP


	READLINE(INFILE, L);
	READ(L,N);
	r0_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i0_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r1_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i1_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r2_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i2_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r3_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i3_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r4_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i4_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r5_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i5_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r6_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i6_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r7_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i7_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r8_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i8_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r9_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i9_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r10_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i10_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r11_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i11_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r12_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i12_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r13_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i13_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r14_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i14_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	r15_bus <= N;
	
	READLINE(INFILE, L);
	READ(L,N);
	i15_bus <= N;

	WAIT UNTIL START_DEL='1';

END LOOP;
END_FILE<='1';
WAIT;
END PROCESS LOAD_INPUT_SAMPLES;
-----------------------------------------------------
START_DEL <= START after 10 ns;
SAVE_DATA <= DONE after 10 ns;
-----------------------------------------------------
OUT_TO_FILE: PROCESS (DONE,CLK,Xr0, Xi0, Xr1, Xi1, Xr2,
	   Xi2, Xr3, Xi3, Xr4, Xi4, Xr5, Xi5, Xr6, Xi6, Xr7,
	   Xi7, Xr8, Xi8, Xr9, Xi9, Xr10, Xi10, Xr11, Xi11,
	   Xr12, Xi12, Xr13, Xi13, Xr14, Xi14, Xr15, Xi15)
FILE OUTFILE : TEXT IS OUT "output_fft.txt";
VARIABLE L : LINE;
VARIABLE N : STD_LOGIC_VECTOR (19 DOWNTO 0);
	
BEGIN
IF CLK'EVENT AND CLK ='0' THEN
  IF SAVE_DATA='1' THEN


	N:= STD_LOGIC_VECTOR(Xr0);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi0);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr1);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi1);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr2);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi2);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr3);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi3);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr4);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi4);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr5);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi5);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr6);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi6);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr7);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi7);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr8);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi8);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr9);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi9);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr10);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi10);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr11);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi11);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr12);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi12);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr13);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi13);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr14);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi14);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xr15);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	N:= STD_LOGIC_VECTOR(Xi15);
	WRITE(L,N);
	WRITELINE(OUTFILE, L);
	
	END IF;
END IF;
END PROCESS OUT_TO_FILE;
-----------------------------------------------------

FFT_PROCESSOR: FFT_16X16 GENERIC MAP(N=>20) PORT MAP(start=>start, clock=>clk, resetn=>rst_n, done=>done, r0=>r0, i0=>i0, r1=>r1,
													 i1=>i1, r2=>r2, i2=>i2, r3=>r3, i3=>i3, r4=>r4, i4=>i4, r5=>r5, i5=>i5, r6=>r6,
													 i6=>i6, r7=>r7, i7=>i7, r8=>r8, i8=>i8, r9=>r9, i9=>i9, r10=>r10, i10=>i10,
													 r11=>r11, i11=>i11, r12=>r12, i12=>i12, r13=>r13, i13=>i13, r14=>r14, i14=>i14,
													 r15=>r15, i15=>i15, Xr0=>Xr0, Xi0=>Xi0, Xr1=>Xr1, Xi1=>Xi1, Xr2=>Xr2, Xi2=>Xi2,
													 Xr3=>Xr3, Xi3=>Xi3, Xr4=>Xr4, Xi4=>Xi4, Xr5=>Xr5, Xi5=>Xi5, Xr6=>Xr6, Xi6=>Xi6,
													 Xr7=>Xr7, Xi7=>Xi7, Xr8=>Xr8, Xi8=>Xi8, Xr9=>Xr9, Xi9=>Xi9, Xr10=>Xr10, Xi10=>Xi10,
	                                                 Xr11=>Xr11, Xi11=>Xi11, Xr12=>Xr12, Xi12=>Xi12, Xr13=>Xr13, Xi13=>Xi13, Xr14=>Xr14,
													 Xi14=>Xi14, Xr15=>Xr15, Xi15=>Xi15);
													 
END BEHAVIOR;
