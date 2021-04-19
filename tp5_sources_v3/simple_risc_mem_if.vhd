library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.simple_risc_def.all;
use work.simple_risc_programs.all;

entity simple_risc_mem_if is
   generic (
      my_data_memory : data_mem_type := program_data 
   );
   port(
      rst  : in  std_logic;
      clk  : in  std_logic;
      din  : in  signed(dm_dw - 1 downto 0);
      addr : in  integer range 0 to 2 ** dm_aw - 1;
      we   : in  std_logic;
      re   : in  std_logic;
      dout : out signed(dm_dw - 1 downto 0);
      wc   : out std_logic;
      rc   : out std_logic
   );
end simple_risc_mem_if;

architecture arch of simple_risc_mem_if is
   signal data_memory : data_mem_type := my_data_memory;
begin

   process (clk, rst)
   begin
      if( rst = '1' ) then
      
         rc   <= '0';
         wc   <= '0';
         dout <= (others => '0');
         
      elsif rising_edge(clk) then
      
         rc <= re;
         wc <= we;
         
         if re = '1' then
            dout <= data_memory(addr);
         end if;
         
         if we = '1' then
            data_memory(addr) <= din;
         end if;
         
      end if;
   end process;

end arch;