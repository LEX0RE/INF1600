library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.simple_risc_def.all;

package simple_risc_programs is

   constant program_0 : inst_mem_type := (
      x"A000001", -- r0    <- +1           - addr x00
      x"A010002", -- r1    <- +2           - addr x01
      x"0040200", -- r4    <- r2 + r0      - addr x02
      x"0040400", -- r4    <- r4 + r0      - addr x03
      x"0040400", -- r4    <- r4 + r0      - addr x04
      x"1050301", -- r5    <- r3 - r1      - addr x05
      x"A060009", -- r6    <- +9           - addr x06
      x"9000106", -- M[r1] <- r6           - addr x07
      x"8070100", -- r7    <- M[r1]        - addr x08
      x"0010100", -- r1    <- r1 + r0      - addr x09
      x"0060600", -- r6    <- r6 + r0      - addr x0A
      x"1040400", -- r4    <- r4 - r0      - addr x0B
      x"C020007", -- jnz 0x07              - addr x0C
      others => (others => '1')
   );

   constant program_1 : inst_mem_type := (
      x"A000006", -- r0    <- +6           - addr x06    nb d'itérations (%ecx)
      x"A010001", -- r1    <- +1           - addr x00    constante 1
      x"A020000", -- r2    <- +0           - addr x00    %esp
      x"A030001", -- r3    <- +1           - addr x00    S(n)
      x"A040002", -- r4    <- +2           - addr x00    S(n+1)
      x"9000203", -- M[r2] <- r3           - addr x07
      x"1000001", -- r0    <- r0 - r1      - addr x05
      x"C020007", -- jnz 0x07              - addr x0C    modifier pour fin
      x"0020201", -- r2    <- r2 + r1      - addr x02

      x"9000204", -- M[r2] <- r4           - addr x07
      x"1000001", -- r0    <- r0 - r1      - addr x05
      x"C020007", -- jnz 0x07              - addr x0C    modifier pour fin

      x"7050300", -- r5    <- r3           - addr x05
      x"7030400", -- r3    <- r4           - addr x05
      x"7040500", -- r4    <- r5           - addr x05






      x"A010002", -- r1    <- +2           - addr x01
      x"9000106", -- M[..] <- r0           - addr x07
      x"9000106", -- M[..] <- r1           - addr x07
      x"0010100", -- r1    <- r1 + r0      - addr x09
      x"0010100", -- r1    <- r1 + r0      - addr x09
      x"9000106", -- M[..] <- r1           - addr x07
      x"C020007", -- jnz 0x07              - addr x0C

   



      others => (others => '1')
   );
   
end simple_risc_programs;

package body simple_risc_programs is  
end simple_risc_programs;
