library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity orGate is
  port (
    a, b : in std_logic;
    y : out std_logic
  ) ;
end orGate ; 

architecture a_orGate of orGate is
begin
  y <= a or b;
end architecture ;

--------
library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity xorGate is
  port (
    a, b : in std_logic;
    y : out std_logic
  );
end xorGate ; 

architecture a_xorGate of xorGate is
begin
  y <= a xor b;
end architecture ;

--------
library ieee;
	use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    
entity kolo is
	generic(
    	n : integer := 4
    );
    port(
    	a, b : in std_logic_vector(0 to n-1);
        c : in std_logic;
        d : out std_logic_vector(0 to n-1)
    );
end entity;

architecture a_kolo of kolo is
begin
	gen: for i in 0 to n-1 generate
    	signal yXor : std_logic;
      	begin
        	uslovi: if i = 0 generate
              	begin
                  	prviXor: entity work.xorGate(a_xorGate)
                      		port map(a(i), b(i), yXor);
                  	prviOr: entity work.orGate(a_orGate)
                      		port map(yXor, c, d(i));
            	end generate;
		uslov: if i /= 0 generate
                	ntiXor:	entity work.xorGate(a_xorGate)
                    		port map(a(i), b(i), yXor);
			ntiOr: entity work.orGate(a_orGate)
                    		port map(yXor, d(i-1), d(i));
		end generate uslov;
	end generate gen;
end architecture;
--------
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity tb is
	generic(
    	n : integer := 4
    );
end entity;

architecture a_tb of tb is
	signal a, b, d : std_logic_vector(0 to n-1);
    signal c : std_logic;
begin
	dut: entity work.kolo(a_kolo)
		port map(a, b, c, d);
         
   	stimulus: process
    begin
    	a <= "0011";
        b <= "1100";
        c <= '1';
        wait for 50 ns;
        a <= "0000";
        b <= "0000";
        c <= '1';
        wait for 50 ns;
        c <= '1';
        wait for 50 ns;
        a <= "1111";
        b <= "1111";
        c <= '0';
        wait for 50 ns;
        c <= '1';
        wait for 50 ns;
        a <= "0000";
        b <= "1111";
        wait for 50 ns;
        c <= '0';
    	wait for 50 ns;
	end process;
end architecture;
