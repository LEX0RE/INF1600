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

   signal PC    : uint16;
   signal IR    : instruction;
   signal ACC   : int16;
   signal MA    : uint16;
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
               
               -- ***********************************************
               -- arithmetic instructions
               --
               if ( IR.op = add ) then
                  ACC <= ACC + uint16_to_int16( mem(IR.disp) );
               elsif ( IR.op = sub ) then
                  ACC <= ACC - uint16_to_int16( mem(IR.disp) );
                  
               elsif ( IR.op = mul ) then
                  ACC <= ACC * uint16_to_int16( mem(IR.disp) );
                  
               elsif ( IR.op = adda ) then
                  MA  <= MA + mem(IR.disp);
               elsif ( IR.op = suba ) then
                  MA <= MA - mem(IR.disp);
                  
               elsif ( IR.op = addx ) then
                  ACC <= ACC + uint16_to_int16( mem(MA) );
               elsif ( IR.op = subx ) then
                  ACC <= ACC - uint16_to_int16( mem(MA) );
               
               -- ***********************************************
               -- load/strore instructions
               --
               elsif ( IR.op =  ld ) then
                  ACC <= uint16_to_int16( mem(IR.disp) );
               elsif ( IR.op = st ) then
                  mem(IR.disp) <= int16_to_uint16( ACC );
                  
               elsif ( IR.op =  lda ) then
                  MA <= uint16_to_int16( mem(IR.disp) );
               elsif ( IR.op = sta ) then
                  mem(IR.disp) <= MA;
                  
               elsif ( IR.op =  ldi ) then
                  ACC <= uint16_to_int16( mem(MA) );
               elsif ( IR.op = sti ) then
                  mem(MA) <= int16_to_uint16( ACC );
               end if;
               
            elsif( ( state = execute ) ) then
               
               if( IR.op /= stop ) then
                  state <= fetch;
                  PC <= PC + 1;
                  if( IR.op = br ) then
                     PC <= IR.disp;
                  elsif(IR.op = brz and ACC = 0 ) then
                     PC <= IR.disp;
                  elsif(IR.op = brnz and ACC /= 0 ) then
                     PC <= IR.disp;
                  end if;
               end if;
               
            end if;  -- end if( state = fetch )
            
         end if; -- end if( rst = '1' )
      end if; -- end if( rising_edge(clk) )
      
   end process;

end arch;