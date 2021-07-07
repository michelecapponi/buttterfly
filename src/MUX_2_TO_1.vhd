library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_2_TO_1 is
	GENERIC( N   : INTEGER:=20);
	port(
		  IN_1     : in signed(N-1 downto 0);
        IN_2     : in signed(N-1 downto 0);
        SEL      : in std_logic;
		  MUX_OUT  : out signed(N-1 downto 0));
end MUX_2_TO_1;


ARCHITECTURE BEHAVIOR OF MUX_2_TO_1 IS

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