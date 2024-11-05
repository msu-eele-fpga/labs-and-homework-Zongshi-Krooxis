library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pattern1 is
    port (
	rst     : in std_ulogic;
	clk     : in std_ulogic;
	pattern : out std_ulogic_vector(7 downto 0)
    );
end entity;

architecture pattern1_arch of pattern1 is
    begin
end architecture;