library ieee;
use ieee.std_logic_1164.all;

entity vending_machine is
    port(
	clk	: in	std_ulogic;
	rst	: in	std_ulogic;
	nickle	: in	std_ulogic;
	dime	: in	std_ulogic;
	dispense: out	std_ulogic;
	amount	: natural range 0 to 15
    );
end entity;

architecture vending_machine_arch of vending_machine is
    begin
end architecture;