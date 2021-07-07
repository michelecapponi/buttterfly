library ieee;
use ieee.std_logic_1164.all;

entity MUX_2_TO_1_IR is
	GENERIC( N   : INTEGER:=22);
	port(
		  IN_1     : in std_logic_vector(N-1 downto 0);
        IN_2     : in std_logic_vector(N-1 downto 0);
        SEL      : in std_logic;
		  MUX_OUT  : out std_logic_vector(N-1 downto 0));
end MUX_2_TO_1_IR;


ARCHITECTURE BEHAVIOR OF MUX_2_TO_1_IR IS

BEGIN

MUX : process(IN_1,IN_2,SEL)
	 begin
      case SEL is
        when '0' =>
        		MUX_OUT <= IN_1;
        when '1' =>
            MUX_OUT <= IN_2;
        when others =>
          	MUX_OUT <= IN_1;
      end case;
    end process MUX;
	 
END BEHAVIOR;