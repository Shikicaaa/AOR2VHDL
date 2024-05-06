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
end kolo;

architecture a_kolo of kolo is
begin
	generator: for i in 0 to n-1 generate
		signal y : std_logic;
		begin
		prvi: if i = 0 generate
			prviAnd: entity work.andGate(a_andGate)
				port map(a(i), b(i), y);
			prviOr: entity work.orGate(a_orGate)
				port map(y, c, d(i));
		end generate prvi;
		drugi: if i /= 0 generate
			ntiAnd: entity work.andGate(a_andGate)
				port map(a(i), b(i), y);
			ntiOr: entity work.orGate(a_orGate)
				port map(y, d(i-1), d(i));
		end generate drugi;
	end generate generator;
end architecture;