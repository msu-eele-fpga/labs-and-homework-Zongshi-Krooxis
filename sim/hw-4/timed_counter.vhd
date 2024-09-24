library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity timed_counter is
    generic(
	clk_period : time;
	count_time : time
    );
    port (
        clk    : in    std_logic;
        enable : in    boolean;
        done   : out   boolean
    );
end entity timed_counter;

architecture timed_counter_arch of timed_counter is

    constant count_max : integer := count_time/clk_period;

    signal cnt : integer;

    begin

	CNTR1 : process(clk, enable)
	    begin
	    	if (rising_edge(clk)) then
		    if (enable) then
			if (cnt = count_max) then
			    cnt <= 0;
			    done <= true;
			else
			    cnt <= cnt + 1;
			    done <= false;
			end if;
		    else
			cnt <= 0;
			done <= false;
		    end if;
	    	end if;
	end process;

end architecture timed_counter_arch;