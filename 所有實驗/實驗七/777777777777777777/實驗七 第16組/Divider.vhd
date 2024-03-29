library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity Divider is
port( clear:in std_logic;
		Divisor,Dividend:in std_logic_vector(7 downto 0);
      Remainder:buffer std_logic_vector(15 downto 0);
		Quot:buffer std_logic_vector(7 downto 0));
end Divider;

architecture func of Divider is
signal x,y:std_logic_vector(15 downto 0);
begin
 process(clear)
 begin
  if clear='1'then
     Quot<="00000000";
	  for i in 0 to 7 loop
	      y(i+8)<=Divisor(i);
			y(i)<='0';
			Remainder(i)<=Dividend(i);
			Remainder(i+8)<='0';
			x(i)<=Divisor(i);
			x(i+8)<='0';
	  end loop;
  else
  for k in 0 to 9 loop
	  for i in 0 to 14 loop
	      y(i)<=y(i+1);
			y(15)<='0';
	  end loop;
	  if (Remainder>=y) and (y>=x)  then
	      Remainder <= Remainder-y;
			for i in 1 to 7 loop
			     Quot(i)<=Quot(i-1);
				  Quot(0)<='1';
			end loop;
	  elsif(Remainder<y) and (y>=x) then
	      for i in 1 to 7 loop
			     Quot(i)<=Quot(i-1);
				  Quot(0)<='0';
		   end loop;
	  end if;
  end loop;
  end if;  
 end process;
end func;