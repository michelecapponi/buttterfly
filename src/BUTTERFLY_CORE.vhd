library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY BUTTERFLY_CORE IS
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
END BUTTERFLY_CORE;

ARCHITECTURE RTL OF BUTTERFLY_CORE IS

COMPONENT DATAPATH IS
GENERIC( N   : INTEGER:=20);
	PORT(
		  Ar         : in signed(N-1 downto 0);
        Ai         : in signed(N-1 downto 0);
		  Br         : in signed(N-1 downto 0);
        Bi         : in signed(N-1 downto 0);
		  Wr         : in signed(N-1 downto 0);
        Wi         : in signed(N-1 downto 0);
		  clock      : in std_logic;
		  resetn     : in std_logic;
		  sh_mult_n  : in std_logic;
		  sub_add_n  : in std_logic;
		  sel_0      : in std_logic_vector(1 downto 0);
		  sel_1      : in std_logic;
		  sel_2      : in std_logic_vector(1 downto 0);
		  en_0       : in std_logic;
		  en_1       : in std_logic;
		  en_2       : in std_logic;
		  en_3       : in std_logic;
		  en_4       : in std_logic;
		  en_5       : in std_logic;
		  en_6       : in std_logic;
		  en_7       : in std_logic;
		  en_round   : in std_logic;
		  sw         : in std_logic;
		  Ar_out     : out signed(N-1 downto 0);
        Ai_out     : out signed(N-1 downto 0);
		  Br_out     : out signed(N-1 downto 0);
        Bi_out     : out signed(N-1 downto 0)		  
		  );
END COMPONENT;

COMPONENT LATE_STATUS IS
	PORT(
			CLOCK, RESET_N, START : IN STD_LOGIC;
			SEL_0, SEL_2 : OUT STD_LOGIC_VECTOR(1 downto 0);
			SEL_1, EN_0, EN_7, SHIFT_MULT_N, EN_1, EN_2, SW, SUB_ADD_N, ROUND, EN_3, EN_4, EN_5, EN_6: OUT STD_LOGIC;
			DONE : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL sh_mult_n, sub_add_n, en_0, en_1, en_2, en_3, en_4, en_5, en_6, en_7, en_round, sel_1, sw: STD_LOGIC;
SIGNAL sel_0, sel_2: STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN

eu: DATAPATH GENERIC MAP(N=>N) PORT MAP(Ar=>Ar, Ai=>Ai, Br=>Br, Bi=>Bi, Wr=>Wr, Wi=>Wi, clock=>clock, resetn=>resetn,
													 sh_mult_n=>sh_mult_n, sub_add_n=>sub_add_n, sel_0=>sel_0, sel_1=>sel_1, sel_2=>sel_2,
													 en_0=>en_0, en_1=>en_1, en_2=>en_2, en_3=>en_3, en_4=>en_4, en_5=>en_5, en_6=>en_6,
													 en_7=>en_7, en_round=>en_round, sw=>sw, Ar_out=>Ar_out, Ai_out=>Ai_out, Br_out=>Br_out,
													 Bi_out=>Bi_out);
													 
cu: LATE_STATUS PORT MAP(CLOCK=>clock, RESET_N=>resetn, START=>start, SEL_0=>sel_0, SEL_1=>sel_1, SEL_2=>sel_2, en_0=>en_0,
                        en_1=>en_1, en_2=>en_2, en_3=>en_3, en_4=>en_4, en_5=>en_5, en_6=>en_6, en_7=>en_7, SHIFT_MULT_N=>sh_mult_n,
								SW=>sw, SUB_ADD_N=>sub_add_n, ROUND=>en_round, DONE=>done);


END RTL;