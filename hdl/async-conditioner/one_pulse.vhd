library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tb_pkg.all;

entity one_pulse is
    port (
	clk : in std_ulogic;
	rst : in std_ulogic;
	input : in std_ulogic;
	pulse : out std_ulogic
    );
end entity one_pulse;

architecture one_pulse_arch of one_pulse is

--    signal cnt : integer := 0;
--    signal cnt_enable : boolean := false;
--    signal done : boolean := true;

    type State_type is (start, pulse_state, wait_state);
    signal cur_state, next_state : State_Type;

    begin

--	CNTR : process(clk, cnt)
--	    begin
--		if(cnt_enable) then
--		    if(rising_edge(clk)) then
--			if (cnt = 0) then
--			    done <= true;
--			else
--			    cnt <= cnt + 1;
--			end if;
--		    end if;
--		else
--		    done <= false;
--		    cnt <= 0;
--		end if;
--	end process;

	STATE_MEM : process (clk)
	    begin
		if(rising_edge(clk)) then
		    cur_state <= next_state;
		end if;
	end process;

	NEXT_STATE_LOGIC : process(cur_state, input)
	    begin
		if (rst = '1')  then
		    next_state <= start;
		else
		    case cur_state is
		    	when start		=> 	if(input = '1') then
						    	    next_state <= pulse_state;
							else
						    	    next_state <= start;
							end if;
		    	when pulse_state	=>	next_state <= wait_state;
		    	when wait_state		=>	if(input = '0') then
						    	    next_state <= start;
							end if;
		    end case;
		end if;
	end process;

	OUTPUT_LOGIC : process(cur_state)
	    begin
		if(cur_state = pulse_state) then
		    pulse <= '1';
		else
		    pulse <= '0';
		end if;
	end process;

end architecture;