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

    type State_type is (S0, S1, S2, S3, S4, S5, S6, S7);
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


	NEXT_STATE_LOGIC : process(cur_state)
	    begin
		if (rst = '1')  then
		    next_state <= S0;
		else
		    case cur_state is
		    	when S0	=> 	next_state <= S1;
		    	when S1	=>	next_state <= S2;
		    	when S2	=>	next_state <= S3;
		    	when S3	=>	next_state <= S4;
		    	when S4	=>	next_state <= S5;
		    	when S5	=>	next_state <= S6;
		    	when S6	=>	next_state <= S7;
		    	when S7	=>	next_state <= S0;
		    end case;
		end if;
	end process;


	OUTPUT_LOGIC : process (cur_state)
	    begin
		case cur_state is
		    when S0	=> 	pattern(0) <= '1';
					pattern(7 downto 1) <= "0000000";
		    when S1	=>	pattern(1) <= '1';
					pattern(0) <= '0';
					pattern(7 downto 2) <= "000000";
		    when S2	=>	pattern(2) <= '1';
					pattern(1 downto 0) <= "00";
					pattern(7 downto 3) <= "00000";
		    when S3	=>	pattern(3) <= '1';
					pattern(2 downto 0) <= "000";
					pattern(7 downto 4) <= "0000";
		    when S4	=>	pattern(4) <= '1';
					pattern(3 downto 0) <= "0000";
					pattern(7 downto 5) <= "000";
		    when S5	=>	pattern(5) <= '1';
					pattern(4 downto 0) <= "00000";
					pattern(7 downto 6) <= "00";
		    when S6	=>	pattern(6) <= '1';
					pattern(5 downto 0) <= "000000";
					pattern(7) <= '0';
		    when S7	=>	pattern(7) <= '1';
					pattern(6 downto 0) <= "0000000";
		    end case;
	end process;

end architecture;