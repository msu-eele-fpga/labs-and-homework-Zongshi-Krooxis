library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity state_change is
    port(
	rst 	: in  std_ulogic;
	clk 	: in  std_ulogic;
	button	: in  std_ulogic;
	sel	: out std_ulogic_vector(2 downto 0)
    );
end entity;

architecture state_change_arch of state_change is

    type State_type is (S0, S1, S2, S3, S4);
    signal cur_state, next_state : State_Type;

    begin

	STATE_MEM : process(clk)
	    begin
		if(rst = '0') then
		    if(rising_edge(clk)) then
			cur_state <= next_state;
		    end if;
		end if;
	end process;


	NEXT_STATE_LOGIC : process(cur_state, button)
	    begin
		if (rst = '1')  then
		    next_state <= S0;
		else
		    case cur_state is
		    	when S0	=> 	if (button = '1') then
					    next_state <= S1;
					end if;
		    	when S1	=>	if (button = '1') then
					    next_state <= S2;
					end if;
		    	when S2	=>	if (button = '1') then
					    next_state <= S3;
					end if;
		    	when S3	=>	if (button = '1') then
					    next_state <= S4;
					end if;
		    	when S4	=>	if (button = '1') then
					    next_state <= S0;
					end if;
		    end case;
		end if;
	end process;


	OUTPUT_LOGIC : process (cur_state)
	    begin
		case cur_state is
		    when S0	=> 	sel <= "000";
		    when S1	=>	sel <= "001";
		    when S2	=>	sel <= "010";
		    when S3	=>	sel <= "011";
		    when S4	=>	sel <= "100";
		    end case;
	end process;

end architecture;