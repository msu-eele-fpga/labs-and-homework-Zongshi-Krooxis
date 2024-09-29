library ieee;
use ieee.std_logic_1164.all;

entity vending_machine is
    port(
	clk	: in	std_ulogic;
	rst	: in	std_ulogic;
	nickel	: in	std_ulogic;
	dime	: in	std_ulogic;
	dispense: out	std_ulogic;
	amount	: out	natural range 0 to 15
    );
end entity;

architecture vending_machine_arch of vending_machine is

    type State_Type is (cents_0, cents_5, cents_10, cents_15);

    signal cur_state : State_Type;

    begin

	State_Memory : process(clk, rst)
	    begin
		if (rst = '0') then
		    if (rising_edge(clk)) then
			if(cur_state = cents_0) then
			    if(dime = '1') then
				cur_state <= cents_10;
			    elsif(nickel = '1') then
				cur_state <= cents_5;
			    end if;
			elsif(cur_state = cents_5) then
			    if(dime = '1') then
				cur_state <= cents_15;
			    elsif(nickel = '1') then
				cur_state <= cents_10;
			    end if;
			elsif(cur_state = cents_10) then
			    if(dime = '1' or nickel = '1') then
				cur_state <= cents_15;
			    end if;
			else
			    cur_state <= cents_0;
			end if;
		    end if;
		else
		    cur_state <= cents_0;
		end if;
	end process;

	output_logic : process(cur_state, rst)
	    begin
		if(rst = '1') then
		    dispense <= '0';
		    amount <= 0;
		elsif(cur_state = cents_0) then
		    dispense <= '0';
		    amount <= 0;
		elsif(cur_state = cents_5) then
		    dispense <= '0';
		    amount <= 5;
		elsif(cur_state = cents_10) then
		    dispense <= '0';
		    amount <= 10;
		else
		    dispense <= '1';
		    amount <= 15;
		end if;
	end process;
end architecture;