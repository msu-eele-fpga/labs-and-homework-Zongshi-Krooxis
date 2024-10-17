-- Author: Aaron McLean
--
-- Help from Ken Vincent
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
    generic (
	clk_period : time := 20 ns;
	debounce_time : time := 100 ns
    );
    port (
	clk : in std_ulogic;
	rst : in std_ulogic;
	input : in std_ulogic;
	debounced : out std_ulogic
    );
end entity debouncer;

architecture debouncer_arch of debouncer is

    type State_type is (start, press, debounce_wait, depress);
    signal cur_state, next_state : State_Type;

    signal done : boolean := true;
    signal cnt_enable : boolean := false;

    constant MAX_CNT : integer := debounce_time/clk_period;

    signal cnt : integer := 0;

    begin

	CNTR : process(clk, cnt)
	    begin
		if(cnt_enable) then
		    if(rising_edge(clk)) then
			if (cnt = MAX_CNT-3) then
			    DONE <= true;
			else
			    cnt <= cnt + 1;
			end if;
		    end if;
		else
		    DONE <= false;
		    cnt <= 0;
		end if;
	end process;

	STATE_MEMORY : process (clk, rst)
	    begin 
		if (rising_edge(clk)) then
		    if (rst = '1') then
			cur_state <= start;
		    else
			cur_state <= next_state;
		    end if;
		end if;


--		if (rst = '1') then
--		    cur_state <= start;
--		elsif(rising_edge(clk)) then
--		    cur_state <= next_state;
--		end if;
	end process;

	NEXT_STATE_LOGIC : process (cur_state, input, DONE)
	    begin 
		if (rst = '1') then
		    next_state <= start;
		end if;

		case (cur_state) is
		    when start   	=>	if (input = '1') then
					    	    next_state <= press;
						end if;
		    when press   	=>	if (DONE) then
					    	    next_state <= debounce_wait;
						end if;
		    when debounce_wait	=>	if (input = '0') then
						    next_state <= depress;
						end if;
		    when depress 	=>	if (DONE) then
					    	    next_state <= start;
						end if;
		    when others	 	=>	next_state <= start;
		end case;
	end process;

	OUTPUT_LOGIC : process (cur_state, input)
	    begin
		case (cur_state) is
		    when press	   	=> debounced <= '1';
					   cnt_enable <= true;
		    when debounce_wait	=> debounced <= '1';
					   cnt_enable <= false;
		    when depress	=> debounced <= '0';
					   cnt_enable <= true;
		    when others	  	=> debounced <= '0';
					   cnt_enable <= false;
		end case;
	end process;

end architecture;