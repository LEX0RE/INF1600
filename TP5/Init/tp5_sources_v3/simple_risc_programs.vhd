library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.simple_risc_def.all;

package simple_risc_programs is

   constant program_inst : inst_mem_type := (
      x"A000001", -- r0    <- 0x01         / addr x00
      x"0020000", -- r2    <- r0 + r0      / addr x01
      x"0030200", -- r3    <- r2 + r0      / addr x02
      x"0040300", -- r4    <- r3 + r0      / addr x03
      x"0010400", -- r1    <- r4 + r0      / addr x04
      x"8020200", -- r2    <- M[r2]        / addr x05
      x"8030300", -- r3    <- M[r3]        / addr x06
      x"8040400", -- r4    <- M[r4]        / addr x07
      x"8050100", -- r5    <- M[r1]        / addr x08
      x"3040400", -- r4    <- r4 << 1      / addr x09
      x"0040405", -- r4    <- r4 + r5      / addr x0A
      x"0010100", -- r1    <- r1 + r0      / addr x0B
      x"0030302", -- r3    <- r3 + r2      / addr x0C
      x"C020008", -- jnz 0x08              / addr x0D
      x"9000104", -- M[r1] <- r4           / addr x0E
      others => (others => '1')
   );

   constant program_data : data_mem_type := (
      x"FFFD", --     / addr x00
      x"FFFE", --     / addr x01
      x"FFFF", --     / addr x02
            Y, --     / addr x03
            X, --     / addr x04
            Z, --     / addr x05
            W, --     / addr x06
      x"0000", --     / addr x07
      x"0000", --     / addr x08
      x"0000", --     / addr x09
      x"0000", --     / addr x0A
      x"0000", --     / addr x0B
      x"0000", --     / addr x0C
      x"0000", --     / addr x0D
      x"0000", --     / addr x0E
      x"0000", --     / addr x0F
      others => (others => '0')
   );
   
end simple_risc_programs;

package body simple_risc_programs is  
end simple_risc_programs;
