library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY FFT_16X16 IS
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
END FFT_16X16;

ARCHITECTURE RTL OF FFT_16X16 IS

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

------------------------BISOGNA SCALARE I DATI IN INGRESSO
SIGNAL r0s, i0s, r1s, i1s, r2s, i2s, r3s, i3s, r4s, i4s, r5s, i5s, r6s, i6s, r7s, i7s, r8s, i8s, 
		 r9s, i9s, r10s, i10s, r11s, i11s, r12s, i12s, r13s, i13s, r14s, i14s, r15s, i15s: SIGNED(N-1 DOWNTO 0);
		 
SIGNAL Wr0, Wi0, Wr1, Wi1, Wr2, Wi2, Wr3, Wi3, Wr4, Wi4, Wr5, Wi5, Wr6, Wi6, Wr7, Wi7: SIGNED(N-1 DOWNTO 0);


SIGNAL Ar_out_core_0, Ar_out_core_1, Ar_out_core_2, Ar_out_core_3, Ar_out_core_4, Ar_out_core_5, Ar_out_core_6, 
		 Ar_out_core_7, Ar_out_core_8, Ar_out_core_9, Ar_out_core_10, Ar_out_core_11, Ar_out_core_12, Ar_out_core_13, 
		 Ar_out_core_14, Ar_out_core_15, Ar_out_core_16, Ar_out_core_17, Ar_out_core_18, Ar_out_core_19, Ar_out_core_20, 
		 Ar_out_core_21, Ar_out_core_22, Ar_out_core_23: SIGNED(N-1 DOWNTO 0); 
		 
SIGNAL Ai_out_core_0, Ai_out_core_1, Ai_out_core_2, Ai_out_core_3, Ai_out_core_4, Ai_out_core_5, Ai_out_core_6, 
		 Ai_out_core_7, Ai_out_core_8, Ai_out_core_9, Ai_out_core_10, Ai_out_core_11, Ai_out_core_12, Ai_out_core_13, 
		 Ai_out_core_14, Ai_out_core_15, Ai_out_core_16, Ai_out_core_17, Ai_out_core_18, Ai_out_core_19, Ai_out_core_20, 
		 Ai_out_core_21, Ai_out_core_22, Ai_out_core_23: SIGNED(N-1 DOWNTO 0); 
		 
SIGNAL Br_out_core_0, Br_out_core_1, Br_out_core_2, Br_out_core_3, Br_out_core_4, Br_out_core_5, Br_out_core_6, 
		 Br_out_core_7, Br_out_core_8, Br_out_core_9, Br_out_core_10, Br_out_core_11, Br_out_core_12, Br_out_core_13, 
		 Br_out_core_14, Br_out_core_15, Br_out_core_16, Br_out_core_17, Br_out_core_18, Br_out_core_19, Br_out_core_20, 
		 Br_out_core_21, Br_out_core_22, Br_out_core_23: SIGNED(N-1 DOWNTO 0); 
		 
SIGNAL Bi_out_core_0, Bi_out_core_1, Bi_out_core_2, Bi_out_core_3, Bi_out_core_4, Bi_out_core_5, Bi_out_core_6, 
		 Bi_out_core_7, Bi_out_core_8, Bi_out_core_9, Bi_out_core_10, Bi_out_core_11, Bi_out_core_12, Bi_out_core_13, 
		 Bi_out_core_14, Bi_out_core_15, Bi_out_core_16, Bi_out_core_17, Bi_out_core_18, Bi_out_core_19, Bi_out_core_20, 
		 Bi_out_core_21, Bi_out_core_22, Bi_out_core_23: SIGNED(N-1 DOWNTO 0); 

SIGNAL done_0, done_1, done_2, done_3, done_4, done_5, done_6, done_7, done_8, done_9, done_10, done_11, done_12,
		 done_13, done_14, done_15, done_16, done_17, done_18, done_19, done_20, done_21, done_22, done_23, done_24,
		 done_25, done_26, done_27, done_28, done_29, done_30, done_31: STD_LOGIC;

BEGIN
----------------------------------COSTANTI Wr E Wi--------------------------------------------------------------------
Wr0 <= B"01111111111111111111";
Wi0 <= B"00000000000000000000";
Wr1 <= B"01110110010000011011";
Wi1 <= B"11001111000001000100";
Wr2 <= B"01011010100000101000";
Wi2 <= B"10100101011111011000";
Wr3 <= B"00110000111110111100";
Wi3 <= B"10001001101111100101";
Wr4 <= B"00000000000000000000";
Wi4 <= B"10000000000000000000";
Wr5 <= Wi1;
Wi5 <= Wi3;
Wr6 <= Wi2;
Wi6 <= Wi2;
Wr7 <= Wi3;
Wi7 <= Wi1;
----------------------------------SCALAMENTO INGRESSI-----------------------------------------------------------------
r0s  <= r0(N-1) & r0(N-1) & r0(N-2 DOWNTO 1);
r1s  <= r1(N-1) & r1(N-1) & r1(N-2 DOWNTO 1);
r2s  <= r2(N-1) & r2(N-1) & r2(N-2 DOWNTO 1);
r3s  <= r3(N-1) & r3(N-1) & r3(N-2 DOWNTO 1);
r4s  <= r4(N-1) & r4(N-1) & r4(N-2 DOWNTO 1);
r5s  <= r5(N-1) & r5(N-1) & r5(N-2 DOWNTO 1);
r6s  <= r6(N-1) & r6(N-1) & r6(N-2 DOWNTO 1);
r7s  <= r7(N-1) & r7(N-1) & r7(N-2 DOWNTO 1);
r8s  <= r8(N-1) & r8(N-1) & r8(N-2 DOWNTO 1);
r9s  <= r9(N-1) & r9(N-1) & r9(N-2 DOWNTO 1);
r10s <= r10(N-1) & r10(N-1) & r10(N-2 DOWNTO 1);
r11s <= r11(N-1) & r11(N-1) & r11(N-2 DOWNTO 1);
r12s <= r12(N-1) & r12(N-1) & r12(N-2 DOWNTO 1);
r13s <= r13(N-1) & r13(N-1) & r13(N-2 DOWNTO 1);
r14s <= r14(N-1) & r14(N-1) & r14(N-2 DOWNTO 1);
r15s <= r15(N-1) & r15(N-1) & r15(N-2 DOWNTO 1);

i0s  <= i0(N-1) & i0(N-1) & i0(N-2 DOWNTO 1);
i1s  <= i1(N-1) & i1(N-1) & i1(N-2 DOWNTO 1);
i2s  <= i2(N-1) & i2(N-1) & i2(N-2 DOWNTO 1);
i3s  <= i3(N-1) & i3(N-1) & i3(N-2 DOWNTO 1);
i4s  <= i4(N-1) & i4(N-1) & i4(N-2 DOWNTO 1);
i5s  <= i5(N-1) & i5(N-1) & i5(N-2 DOWNTO 1);
i6s  <= i6(N-1) & i6(N-1) & i6(N-2 DOWNTO 1);
i7s  <= i7(N-1) & i7(N-1) & i7(N-2 DOWNTO 1);
i8s  <= i8(N-1) & i8(N-1) & i8(N-2 DOWNTO 1);
i9s  <= i9(N-1) & i9(N-1) & i9(N-2 DOWNTO 1);
i10s <= i10(N-1) & i10(N-1) & i10(N-2 DOWNTO 1);
i11s <= i11(N-1) & i11(N-1) & i11(N-2 DOWNTO 1);
i12s <= i12(N-1) & i12(N-1) & i12(N-2 DOWNTO 1);
i13s <= i13(N-1) & i13(N-1) & i13(N-2 DOWNTO 1);
i14s <= i14(N-1) & i14(N-1) & i14(N-2 DOWNTO 1);
i15s <= i15(N-1) & i15(N-1) & i15(N-2 DOWNTO 1);
----------------------------------LAYER 1-----------------------------------------------------------------------------

core_0: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>r0s, Ai=>i0s, Br=>r8s, Bi=>i8s, Wr=>Wr0, Wi=>Wi0, start=>start,
																  done=>done_0, Ar_out=>Ar_out_core_0, Ai_out=>Ai_out_core_0, 
																  Br_out=>Br_out_core_0, Bi_out=>Bi_out_core_0, clock=>clock, resetn=>resetn);

core_1: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>r1s, Ai=>i1s, Br=>r9s, Bi=>i9s, Wr=>Wr0, Wi=>Wi0, start=>start,
																  done=>done_1, Ar_out=>Ar_out_core_1, Ai_out=>Ai_out_core_1, 
																  Br_out=>Br_out_core_1, Bi_out=>Bi_out_core_1, clock=>clock, resetn=>resetn);

core_2: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>r2s, Ai=>i2s, Br=>r10s, Bi=>i10s, Wr=>Wr0, Wi=>Wi0, start=>start,
																  done=>done_2, Ar_out=>Ar_out_core_2, Ai_out=>Ai_out_core_2, 
																  Br_out=>Br_out_core_2, Bi_out=>Bi_out_core_2, clock=>clock, resetn=>resetn);	
																  
core_3: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>r3s, Ai=>i3s, Br=>r11s, Bi=>i11s, Wr=>Wr0, Wi=>Wi0, start=>start,
																  done=>done_3, Ar_out=>Ar_out_core_3, Ai_out=>Ai_out_core_3, 
																  Br_out=>Br_out_core_3, Bi_out=>Bi_out_core_3, clock=>clock, resetn=>resetn);
																  
core_4: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>r4s, Ai=>i4s, Br=>r12s, Bi=>i12s, Wr=>Wr0, Wi=>Wi0, start=>start,
																  done=>done_4, Ar_out=>Ar_out_core_4, Ai_out=>Ai_out_core_4, 
																  Br_out=>Br_out_core_4, Bi_out=>Bi_out_core_4, clock=>clock, resetn=>resetn);
																  
core_5: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>r5s, Ai=>i5s, Br=>r13s, Bi=>i13s, Wr=>Wr0, Wi=>Wi0, start=>start,
																  done=>done_5, Ar_out=>Ar_out_core_5, Ai_out=>Ai_out_core_5, 
																  Br_out=>Br_out_core_5, Bi_out=>Bi_out_core_5, clock=>clock, resetn=>resetn);

core_6: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>r6s, Ai=>i6s, Br=>r14s, Bi=>i14s, Wr=>Wr0, Wi=>Wi0, start=>start,
																  done=>done_6, Ar_out=>Ar_out_core_6, Ai_out=>Ai_out_core_6, 
																  Br_out=>Br_out_core_6, Bi_out=>Bi_out_core_6, clock=>clock, resetn=>resetn);																  

core_7: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>r7s, Ai=>i7s, Br=>r15s, Bi=>i15s, Wr=>Wr0, Wi=>Wi0, start=>start,
																  done=>done_7, Ar_out=>Ar_out_core_7, Ai_out=>Ai_out_core_7, 
																  Br_out=>Br_out_core_7, Bi_out=>Bi_out_core_7, clock=>clock, resetn=>resetn);
																  
----------------------------------LAYER 2-----------------------------------------------------------------------------

core_8: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_0, Ai=>Ai_out_core_0, Br=>Ar_out_core_4, Bi=>Ai_out_core_4,
                                                  Wr=>Wr0, Wi=>Wi0, start=>done_0, done=>done_8, Ar_out=>Ar_out_core_8,
																  Ai_out=>Ai_out_core_8, Br_out=>Br_out_core_8, Bi_out=>Bi_out_core_8, clock=>clock, resetn=>resetn);

core_9: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_1, Ai=>Ai_out_core_1, Br=>Ar_out_core_5, Bi=>Ai_out_core_5,
                                                  Wr=>Wr0, Wi=>Wi0, start=>done_1, done=>done_9, Ar_out=>Ar_out_core_9,
																  Ai_out=>Ai_out_core_9, Br_out=>Br_out_core_9, Bi_out=>Bi_out_core_9, clock=>clock, resetn=>resetn);

core_10: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_2, Ai=>Ai_out_core_2, Br=>Ar_out_core_6, Bi=>Ai_out_core_6,
                                                   Wr=>Wr0, Wi=>Wi0, start=>done_2, done=>done_10, Ar_out=>Ar_out_core_10,
																   Ai_out=>Ai_out_core_10, Br_out=>Br_out_core_10, Bi_out=>Bi_out_core_10, clock=>clock, resetn=>resetn);
																	
core_11: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_3, Ai=>Ai_out_core_3, Br=>Ar_out_core_7, Bi=>Ai_out_core_7,
                                                   Wr=>Wr0, Wi=>Wi0, start=>done_3, done=>done_11, Ar_out=>Ar_out_core_11,
																   Ai_out=>Ai_out_core_11, Br_out=>Br_out_core_11, Bi_out=>Bi_out_core_11, clock=>clock, resetn=>resetn);
																	
core_12: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_0, Ai=>Bi_out_core_0, Br=>Br_out_core_4, Bi=>Bi_out_core_4,
                                                   Wr=>Wr4, Wi=>Wi4, start=>done_4, done=>done_12, Ar_out=>Ar_out_core_12,
																   Ai_out=>Ai_out_core_12, Br_out=>Br_out_core_12, Bi_out=>Bi_out_core_12, clock=>clock, resetn=>resetn);
																  
core_13: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_1, Ai=>Bi_out_core_1, Br=>Br_out_core_5, Bi=>Bi_out_core_5,
                                                   Wr=>Wr4, Wi=>Wi4, start=>done_1, done=>done_13, Ar_out=>Ar_out_core_13,
																   Ai_out=>Ai_out_core_13, Br_out=>Br_out_core_13, Bi_out=>Bi_out_core_13, clock=>clock, resetn=>resetn);
																	
core_14: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_2, Ai=>Bi_out_core_2, Br=>Br_out_core_6, Bi=>Bi_out_core_6,
                                                   Wr=>Wr4, Wi=>Wi4, start=>done_2, done=>done_14, Ar_out=>Ar_out_core_14,
																   Ai_out=>Ai_out_core_14, Br_out=>Br_out_core_14, Bi_out=>Bi_out_core_14, clock=>clock, resetn=>resetn);
																	
core_15: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_3, Ai=>Bi_out_core_3, Br=>Br_out_core_7, Bi=>Bi_out_core_7,
                                                   Wr=>Wr4, Wi=>Wi4, start=>done_3, done=>done_15, Ar_out=>Ar_out_core_15,
																   Ai_out=>Ai_out_core_15, Br_out=>Br_out_core_15, Bi_out=>Bi_out_core_15, clock=>clock, resetn=>resetn);

----------------------------------LAYER 3-----------------------------------------------------------------------------

core_16: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_8, Ai=>Ai_out_core_8, Br=>Ar_out_core_10, Bi=>Ai_out_core_10,
                                                   Wr=>Wr0, Wi=>Wi0, start=>done_8, done=>done_16, Ar_out=>Ar_out_core_16,
																   Ai_out=>Ai_out_core_16, Br_out=>Br_out_core_16, Bi_out=>Bi_out_core_16, clock=>clock, resetn=>resetn);
																	
core_17: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_9, Ai=>Ai_out_core_9, Br=>Ar_out_core_11, Bi=>Ai_out_core_11,
                                                   Wr=>Wr0, Wi=>Wi0, start=>done_9, done=>done_17, Ar_out=>Ar_out_core_17,
																   Ai_out=>Ai_out_core_17, Br_out=>Br_out_core_17, Bi_out=>Bi_out_core_17, clock=>clock, resetn=>resetn);
																	
core_18: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_8, Ai=>Bi_out_core_8, Br=>Br_out_core_10, Bi=>Bi_out_core_10,
                                                   Wr=>Wr4, Wi=>Wi4, start=>done_8, done=>done_18, Ar_out=>Ar_out_core_18,
																   Ai_out=>Ai_out_core_18, Br_out=>Br_out_core_18, Bi_out=>Bi_out_core_18, clock=>clock, resetn=>resetn);
																	
core_19: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_9, Ai=>Bi_out_core_9, Br=>Br_out_core_11, Bi=>Bi_out_core_11,
                                                   Wr=>Wr4, Wi=>Wi4, start=>done_9, done=>done_19, Ar_out=>Ar_out_core_19,
																   Ai_out=>Ai_out_core_19, Br_out=>Br_out_core_19, Bi_out=>Bi_out_core_19, clock=>clock, resetn=>resetn);
																	
core_20: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_12, Ai=>Ai_out_core_12, Br=>Ar_out_core_14, Bi=>Ai_out_core_14,
                                                   Wr=>Wr2, Wi=>Wi2, start=>done_12, done=>done_20, Ar_out=>Ar_out_core_20,
																   Ai_out=>Ai_out_core_20, Br_out=>Br_out_core_20, Bi_out=>Bi_out_core_20, clock=>clock, resetn=>resetn);

core_21: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_13, Ai=>Ai_out_core_13, Br=>Ar_out_core_15, Bi=>Ai_out_core_15,
                                                   Wr=>Wr2, Wi=>Wi2, start=>done_13, done=>done_21, Ar_out=>Ar_out_core_21,
																   Ai_out=>Ai_out_core_21, Br_out=>Br_out_core_21, Bi_out=>Bi_out_core_21, clock=>clock, resetn=>resetn);

core_22: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_12, Ai=>Bi_out_core_12, Br=>Br_out_core_14, Bi=>Bi_out_core_14,
                                                   Wr=>Wr6, Wi=>Wi6, start=>done_12, done=>done_22, Ar_out=>Ar_out_core_22,
																   Ai_out=>Ai_out_core_22, Br_out=>Br_out_core_22, Bi_out=>Bi_out_core_22, clock=>clock, resetn=>resetn);
																	
core_23: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_13, Ai=>Bi_out_core_13, Br=>Br_out_core_15, Bi=>Bi_out_core_15,
                                                   Wr=>Wr6, Wi=>Wi6, start=>done_13, done=>done_23, Ar_out=>Ar_out_core_23,
																   Ai_out=>Ai_out_core_23, Br_out=>Br_out_core_23, Bi_out=>Bi_out_core_23, clock=>clock, resetn=>resetn);

----------------------------------LAYER 4-----------------------------------------------------------------------------

core_24: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_16, Ai=>Ai_out_core_16, Br=>Ar_out_core_17, Bi=>Ai_out_core_17,
                                                   Wr=>Wr0, Wi=>Wi0, start=>done_16, done=>done_24, Ar_out=>Xr0,
																   Ai_out=>Xi0, Br_out=>Xr8, Bi_out=>Xi8, clock=>clock, resetn=>resetn);
																	
core_25: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_16, Ai=>Bi_out_core_16, Br=>Br_out_core_17, Bi=>Bi_out_core_17,
                                                   Wr=>Wr4, Wi=>Wi4, start=>done_16, done=>done_25, Ar_out=>Xr4,
																   Ai_out=>Xi4, Br_out=>Xr12, Bi_out=>Xi12, clock=>clock, resetn=>resetn);
																	
core_26: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_18, Ai=>Ai_out_core_18, Br=>Ar_out_core_19, Bi=>Ai_out_core_19,
                                                   Wr=>Wr2, Wi=>Wi2, start=>done_18, done=>done_26, Ar_out=>Xr2,
																   Ai_out=>Xi2, Br_out=>Xr10, Bi_out=>Xi10, clock=>clock, resetn=>resetn);
																	
core_27: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_18, Ai=>Bi_out_core_18, Br=>Br_out_core_19, Bi=>Bi_out_core_19,
                                                   Wr=>Wr6, Wi=>Wi6, start=>done_18, done=>done_27, Ar_out=>Xr6,
																   Ai_out=>Xi6, Br_out=>Xr14, Bi_out=>Xi14, clock=>clock, resetn=>resetn);
																	
core_28: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_20, Ai=>Ai_out_core_20, Br=>Ar_out_core_21, Bi=>Ai_out_core_21,
                                                   Wr=>Wr1, Wi=>Wi1, start=>done_20, done=>done_28, Ar_out=>Xr1,
																   Ai_out=>Xi1, Br_out=>Xr9, Bi_out=>Xi9, clock=>clock, resetn=>resetn);
																	
core_29: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_20, Ai=>Bi_out_core_20, Br=>Br_out_core_21, Bi=>Bi_out_core_21,
                                                   Wr=>Wr5, Wi=>Wi5, start=>done_20, done=>done_29, Ar_out=>Xr5,
																   Ai_out=>Xi5, Br_out=>Xr13, Bi_out=>Xi13, clock=>clock, resetn=>resetn);
																	
core_30: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Ar_out_core_22, Ai=>Ai_out_core_22, Br=>Ar_out_core_23, Bi=>Ai_out_core_23,
                                                   Wr=>Wr3, Wi=>Wi3, start=>done_22, done=>done_30, Ar_out=>Xr3,
																   Ai_out=>Xi3, Br_out=>Xr11, Bi_out=>Xi11, clock=>clock, resetn=>resetn);
																	
core_31: BUTTERFLY_CORE GENERIC MAP(N=>N) PORT MAP(Ar=>Br_out_core_22, Ai=>Bi_out_core_22, Br=>Br_out_core_23, Bi=>Bi_out_core_23,
                                                   Wr=>Wr7, Wi=>Wi7, start=>done_22, done=>done_31, Ar_out=>Xr7,
																   Ai_out=>Xi7, Br_out=>Xr15, Bi_out=>Xi15, clock=>clock, resetn=>resetn);
																	
done <= done_24 AND done_25 AND done_26 AND done_27 AND done_28 AND done_29 AND done_30 AND done_31;



END RTL;