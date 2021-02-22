library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.acc_proc_def.all;
use work.acc_proc_programs.all;

entity acc_proc is
generic(
   program : memtype := program_0
);
port(
   rst : in  std_logic;
   clk : in  std_logic
);
end acc_proc;

architecture arch of acc_proc is

   signal   PC  : uint16;
   signal   IR  : instruction;
   signal   ACC : int16;
   signal state : state_type; 
   
   signal mem : memtype := program;

begin

   process( clk ) is
   begin
      
      if( rising_edge(clk) ) then
         if( rst = '1' ) then
         
            PC    <= 0;
            state <= fetch;
            IR    <= (nop, 0);
            ACC   <= 0;
            
         else
         
            if( state = fetch ) then
            
               state <= decode;
               IR <= to_instruction( mem(PC) );
               
            elsif( state = decode ) then
            
               state <= execute;
               
               if ( IR.op = add ) then
                  ACC <= ACC + uint16_to_int16( mem(IR.addr) );
               elsif ( IR.op = mul ) then
                  ACC <= ACC * uint16_to_int16( mem(IR.addr) );
               elsif ( IR.op =  ld ) then
                  ACC <= uint16_to_int16( mem(IR.addr) );
               elsif ( IR.op = st ) then
                  mem(IR.addr) <= int16_to_uint16( ACC );
               end if;
               
            elsif( ( state = execute ) and ( IR.op /= stop ) ) then
            
               state <= fetch;
               PC    <= PC + 1;
               
            end if;  -- end if( state = fetch )
            
         end if; -- end if( rst = '1' )
      end if; -- end if( rising_edge(clk) )
      
   end process;

end arch;