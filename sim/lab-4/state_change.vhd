library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity state_change is
    generic(
	clk_per	: in  time := 20 ns
    );
    port(
	rst 	: in  std_ulogic;
	clk 	: in  std_ulogic;
	button	: in  std_ulogic;
	sw	: in  std_ulogic_vector(3 downto 0);
	sel	: out std_ulogic_vector(2 downto 0)
    );
end entity;

architecture state_change_arch of state_change is

    type State_type is (P0, P1, P2, P3, P4, wait_state);
    signal cur_state, next_state : State_Type;
    signal done : boolean := true;
    signal flag : boolean := false;
    signal cnt : integer := 0;

    component timed_counter is
    	generic(
	    clk_period : time;
	    count_time : time
    	);
    	port (
            clk    : in    std_logic;
            enable : in    boolean;
            done   : out   boolean
    	);
    end component timed_counter;


    begin

	CNTR : timed_counter 
	    generic map (
		clk_period => clk_per,
		count_time => 1000 ms -- worked at 100 ns
	    )
	    port map (
		clk => clk,
		enable => flag,
		done => done
	    );


	STATE_MEM : process(clk)
	    begin
		if(rst = '0') then
		    if(rising_edge(clk)) then
			cur_state <= next_state;
		    end if;
		end if;
	end process;


	NEXT_STATE_LOGIC : process(cur_state, button, done)
	    begin
		if (rst = '1')  then
		    next_state <= P0;
		else
		    case cur_state is
		    	when wait_state =>	if (done) then
						    flag <= false;
						    if    (sw = "0000") then
						    	next_state <= P0;
						    elsif (sw = "1000") then
						    	next_state <= P1;
						    elsif (sw = "0100") then
						    	next_state <= P2;
						    elsif (sw = "0010") then
						    	next_state <= P3;
						    elsif (sw = "0001") then
						    	next_state <= P4;
						    else
						    	next_state <= wait_state;
						    end if;
						end if;
			when others =>		if (button = '1') then
						    next_state <= wait_state;
						    flag <= true;
						end if;
		    end case;
		end if;
	end process;


	OUTPUT_LOGIC : process (cur_state)
	    begin
		case cur_state is
		    when P0		=> sel <= "000";
					   --flag <= false;
		    when P1		=> sel <= "001";
					   --flag <= false;
		    when P2		=> sel <= "010";
					   --flag <= false;
		    when P3		=> sel <= "011";
					   --flag <= false;
		    when P4		=> sel <= "100";
					   --flag <= false;
		    when wait_state	=> sel <= "101"; -- off state
					   --flag <= true;
		    end case;
	end process;

end architecture;