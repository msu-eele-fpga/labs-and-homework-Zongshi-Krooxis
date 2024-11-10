library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pattern3 is
    port (
	rst     : in std_ulogic;
	clk     : in std_ulogic;
	pattern : out std_ulogic_vector(7 downto 0)
    );
end entity;

architecture pattern3_arch of pattern3 is

    signal cnt : integer := 0;

    begin
	CNTR : process (clk)
	    begin
		if(rst = '0') then
		    if(rising_edge(clk)) then
			if (cnt = 255) then
			    cnt <= 0;
			else
			    cnt <= cnt+1;
			end if;
		    end if;
		else
		    cnt <= 0;
		end if;
	end process;

	pattern <= std_ulogic_vector(to_unsigned(cnt, 8));

end architecture;