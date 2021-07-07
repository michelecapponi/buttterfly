library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY DATAPATH IS
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
END DATAPATH;

ARCHITECTURE RTL OF DATAPATH IS

COMPONENT MUX_4_TO_1 IS
	GENERIC( N   : INTEGER:=20);
	port(
		  IN_1     : in signed(N-1 downto 0);
        IN_2     : in signed(N-1 downto 0);
		  IN_3     : in signed(N-1 downto 0);
		  IN_4     : in signed(N-1 downto 0);
        SEL      : in std_logic_vector(1 downto 0);
		  MUX_OUT  : out signed(N-1 downto 0));
END COMPONENT;

COMPONENT MUX_3_TO_1 IS
	GENERIC( N   : INTEGER:=20);
	port(
		  IN_1     : in signed(N-1 downto 0);
        IN_2     : in signed(N-1 downto 0);
		  IN_3     : in signed(N-1 downto 0);
        SEL      : in std_logic_vector(1 downto 0);
		  MUX_OUT  : out signed(N-1 downto 0));
END COMPONENT;

COMPONENT MUX_2_TO_1 IS
	GENERIC( N   : INTEGER:=20);
	port(
		  IN_1     : in signed(N-1 downto 0);
        IN_2     : in signed(N-1 downto 0);
        SEL      : in std_logic;
		  MUX_OUT  : out signed(N-1 downto 0));
END COMPONENT;

COMPONENT REG IS
	GENERIC( N   : INTEGER:=20);
	PORT (D      : IN SIGNED(N-1 DOWNTO 0);
			CLOCK  : IN STD_LOGIC;
			ENABLE : IN STD_LOGIC;
			RESETN : IN STD_LOGIC;
			Q      : OUT SIGNED(N-1 DOWNTO 0));
END COMPONENT;

COMPONENT MULTIPLIER IS
	GENERIC( N   : INTEGER:=20);
	port(
		  mult_in_A  : in signed(N-1 downto 0);
        mult_in_B  : in signed(N-1 downto 0);
        sh_mult_n  : in std_logic;
		  clock      : in std_logic;
		  resetn     : in std_logic;  
		  mult_out   : out signed(2*N-1 downto 0));
END COMPONENT;

COMPONENT ADDER_SUBTRACTOR IS
	GENERIC( N   : INTEGER:=40);
	port(
		  adder_in_A : in signed(N-1 downto 0);
        adder_in_B : in signed(N-1 downto 0);
        sub_add_n  : in std_logic;
		  clock      : in std_logic;
		  resetn     : in std_logic;  
		  adder_out  : out signed(N-1 downto 0));
END COMPONENT;

COMPONENT SWAP IS
	GENERIC( N   : INTEGER:=40);
	PORT (IN_1   : IN SIGNED(N-1 DOWNTO 0);
			IN_2   : IN SIGNED(N-1 DOWNTO 0);
			SW     : IN STD_LOGIC;
			OUT_1  : OUT SIGNED(N-1 DOWNTO 0);
			OUT_2  : OUT SIGNED(N-1 DOWNTO 0));
END COMPONENT;

COMPONENT ROUND_TO_NEAREST_EVEN IS
	GENERIC( N   : INTEGER:=20);
	port (IN_TO_ROUND   : in signed(2*N-1 downto 0);
         clock         : in std_logic;
			resetn        : in std_logic;
			en_round      : in std_logic;
			ROUNDED_DATA  : out signed(N-1 downto 0));
END COMPONENT;

SIGNAL IN_REG_0, OUT_REG_0, MUX_1_OUT, OUT_REG_7, ROUNDED_DATA: SIGNED(N-1 DOWNTO 0);
SIGNAL MULT_OUT: SIGNED(2*N-1 DOWNTO 0);
SIGNAL OUT_REG_1_EXT, AR_EXT, AI_EXT, IN_REG_2, OUT_REG_2, SUM_OUT, SUM_IN_A, SUM_IN_B: SIGNED(2*N-1 DOWNTO 0);
SIGNAL IN_REG_1, OUT_REG_1: SIGNED(2*N-2 DOWNTO 0);

BEGIN

IN_REG_1<=MULT_OUT(2*N-2 DOWNTO 0);                      --uscita del moltiplicatore senza MSB
OUT_REG_1_EXT <=  OUT_REG_1(2*N-2) & OUT_REG_1;          --estensione uscita registro moltiplicatore (da 1.38 a 2.38 nel caso di N=20)
Ar_EXT        <=  Ar(N-1) & Ar & (N-2 DOWNTO 0 => '0');  --estensione operando Ar (da 1.19 a 2.38 nel caso di N=20)
Ai_EXT        <=  Ai(N-1) & Ai & (N-2 DOWNTO 0 => '0');  --estensione operando Ai (da 1.38 a 2.38 nel caso di N=20)

MUX0 : MUX_4_TO_1 GENERIC MAP(N=>N)     PORT MAP(IN_1=>Ar, IN_2=>Ai, IN_3=>Br, IN_4=>Bi, SEL=>sel_0, MUX_OUT=>IN_REG_0);

MUX1 : MUX_2_TO_1 GENERIC MAP(N=>N)     PORT MAP(IN_1=>Wi, IN_2=>Wr, SEL=>sel_1, MUX_OUT=>MUX_1_OUT);

MUX2 : MUX_3_TO_1 GENERIC MAP(N=>2*N)   PORT MAP(IN_1=>SUM_OUT, IN_2=>Ai_EXT, IN_3=>Ar_EXT, SEL=>sel_2, MUX_OUT=>IN_REG_2);

REG_0 : REG GENERIC MAP(N=>N)     PORT MAP(D=>IN_REG_0, CLOCK=>CLOCK, ENABLE=>EN_0, RESETN=>RESETN, Q=>OUT_REG_0);

REG_1 : REG GENERIC MAP(N=>2*N-1) PORT MAP(D=>IN_REG_1, CLOCK=>CLOCK, ENABLE=>EN_1, RESETN=>RESETN, Q=>OUT_REG_1);

REG_2 : REG GENERIC MAP(N=>2*N)   PORT MAP(D=>IN_REG_2, CLOCK=>CLOCK, ENABLE=>EN_2, RESETN=>RESETN, Q=>OUT_REG_2);

REG_3 : REG GENERIC MAP(N=>N)     PORT MAP(D=>ROUNDED_DATA, CLOCK=>CLOCK, ENABLE=>EN_3, RESETN=>RESETN, Q=>Ar_out);

REG_4 : REG GENERIC MAP(N=>N)     PORT MAP(D=>ROUNDED_DATA, CLOCK=>CLOCK, ENABLE=>EN_4, RESETN=>RESETN, Q=>Ai_out);

REG_5 : REG GENERIC MAP(N=>N)     PORT MAP(D=>ROUNDED_DATA, CLOCK=>CLOCK, ENABLE=>EN_5, RESETN=>RESETN, Q=>Br_out);

REG_6 : REG GENERIC MAP(N=>N)     PORT MAP(D=>ROUNDED_DATA, CLOCK=>CLOCK, ENABLE=>EN_6, RESETN=>RESETN, Q=>Bi_out);

REG_7 : REG GENERIC MAP(N=>N)     PORT MAP(D=>MUX_1_OUT, CLOCK=>CLOCK, ENABLE=>EN_7, RESETN=>RESETN, Q=>OUT_REG_7);

MULT : MULTIPLIER GENERIC MAP(N=>N)   PORT MAP(MULT_IN_A=>OUT_REG_7, MULT_IN_B=>OUT_REG_0, SH_MULT_N=>SH_MULT_N, CLOCK=>CLOCK, RESETN=>RESETN, MULT_OUT=>MULT_OUT);

SWAP_BLOCK : SWAP GENERIC MAP(N=>2*N) PORT MAP(IN_1=>OUT_REG_1_EXT, IN_2=>OUT_REG_2, SW=>SW, OUT_1=>SUM_IN_B, OUT_2=>SUM_IN_A);

ADDER_SUB : ADDER_SUBTRACTOR     GENERIC MAP(N=>2*N)   PORT MAP(adder_in_A=>SUM_IN_A,adder_in_B=>SUM_IN_B,sub_add_n=>sub_add_n,clock=>clock,resetn=>resetn,adder_out=>SUM_OUT);

ROUNDING : ROUND_TO_NEAREST_EVEN GENERIC MAP(N=>N)     PORT MAP(IN_TO_ROUND=>SUM_OUT, CLOCK=>CLOCK, RESETN=>RESETN, EN_ROUND=>EN_ROUND, ROUNDED_DATA=>ROUNDED_DATA);


END RTL;