library ieee;
use ieee.std_logic_1164.all;

entity MUX_2_TO_1_1_BIT is
	port(
		  IN_1     : in std_logic;
        IN_2     : in std_logic;
        SEL      : in std_logic;
		  MUX_OUT  : out std_logic);
end MUX_2_TO_1_1_BIT;


ARCHITECTURE BEHAVIOR OF MUX_2_TO_1_1_BIT IS

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