library ieee;
use ieee.std_logic_1164.all;

entity synchronizer is
    port (
        clk   : in    std_ulogic;
        async : in    std_ulogic;
        sync  : out   std_ulogic
    );
end entity synchronizer;

architecture synchronizer_arch of synchronizer is

    signal D1 : std_ulogic;
    signal D2 : std_ulogic;
    signal Q1 : std_ulogic;
    signal Q2 : std_ulogic;

    begin
	D1 <= async;
	D2 <= Q1;
	sync <= Q2;

	process(clk)
	    begin
		if (rising_edge(clk)) then
		    Q1 <= D1;
		    Q2 <= D2;
		end if;
	end process;


end architecture synchronizer_arch;
