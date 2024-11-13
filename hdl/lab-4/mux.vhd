library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
    port (
	rst	: in  std_ulogic;
	in1 	: in  std_ulogic_vector(7 downto 0);
	in2 	: in  std_ulogic_vector(7 downto 0);
	in3 	: in  std_ulogic_vector(7 downto 0);
	in4 	: in  std_ulogic_vector(7 downto 0);
	in5 	: in  std_ulogic_vector(7 downto 0);
	sel	: in  std_ulogic_vector(2 downto 0);
	sw	: in  std_ulogic_vector(3 downto 0);
	mux_out	: out std_ulogic_vector(7 downto 0)
    );
end entity;

architecture mux_arch of mux is
    begin
        MUXING : process (sel, rst)
	    begin
		if (rst = '0') then
		    if    (sel = "000") then
			mux_out <= in1;
		    elsif (sel = "001") then
			mux_out <= in2;
		    elsif (sel = "010") then
			mux_out <= in3;
		    elsif (sel = "011") then
			mux_out <= in4;
		    elsif (sel = "100") then
			mux_out <= in5;
		    else
			mux_out <= "0000" & sw;
		    end if;
		else
		    mux_out <= "11111111";
		end if;
        end process;


end architecture;