library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
    port (
	rst	: in  std_ulogic;
	in1 	: in  std_ulogic;
	in2 	: in  std_ulogic;
	in3 	: in  std_ulogic;
	in4 	: in  std_ulogic;
	in5 	: in  std_ulogic;
	sel	: in  integer;
	mux_out	: out std_ulogic
    );
end entity;

architecture mux_arch of mux is
    begin
        MUXING : process (sel, rst)
	    begin
		if (rst = '0') then
		    if    (sel = 0) then
			mux_out <= in1;
		    elsif (sel = 1) then
			mux_out <= in2;
		    elsif (sel = 2) then
			mux_out <= in3;
		    elsif (sel = 3) then
			mux_out <= in4;
		    elsif (sel = 4) then
			mux_out <= in5;
		    else
			mux_out <= '0';
		    end if;
		else
		    mux_out <= '0';
		end if;
        end process;


end architecture;