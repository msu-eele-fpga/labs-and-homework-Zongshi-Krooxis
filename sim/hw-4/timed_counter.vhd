library ieee;
use ieee.std_logic_1164.all;

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

    begin

end architecture timed_counter_arch;