library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity andGate is
port(
	a, b : in std_logic;
	c : out std_logic
);
end andGate;

architecture a_andGate of andGate is
begin
	c<= a and b;
end architecture;