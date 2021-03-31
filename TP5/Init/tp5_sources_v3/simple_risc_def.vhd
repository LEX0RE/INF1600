library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package simple_risc_def is
   
   constant mon_matricule : natural := 1256142; -- modifier

   constant Nreg : integer  := 32; -- nombre de registres
   constant dw   : positive := 16; -- largeur du chemin des donnees en bits
   
   -- memoire d'instructions
   constant im_aw : positive := 12; -- nombre de bits d'adresse de la memoire d'instructions
   constant im_dw : positive := 28; -- largeur des instructions en bits
   constant inst_memory_depth : positive := 2 ** im_aw;
   type inst_mem_type is array( 0 to inst_memory_depth-1 ) of std_logic_vector(im_dw - 1 downto 0);
   
   -- memoire de donnees
   constant dm_aw : positive :=  8; -- nombre de bits d'adresse de la memoire des donnees
   constant dm_dw : positive := dw; -- largeur du chemin des donnees en bits
   constant data_memory_depth : positive := 2 ** dm_aw;
   type data_mem_type is array( 0 to data_memory_depth-1 ) of signed(dm_dw - 1 downto 0);
   
   -- registres
   type reg_type is array(0 to Nreg - 1) of signed(dw - 1 downto 0);
   
   type state_type is (start, fetch, decode, op_alu, jump, ldi, write_mem, read_mem, stop);
   
   type br_type    is (br, brz, brnz, brs, brns, nbr);
   type inst_type  is (inst_alu, inst_read_mem, inst_write_mem, inst_loadi, inst_branch, inst_stop);
   
   constant X : signed(dm_dw - 1 downto 0) := x"0001";
   constant Y : signed(dm_dw - 1 downto 0) := x"0003";
   constant Z : signed(dm_dw - 1 downto 0) := x"0002";
   constant W : signed(dm_dw - 1 downto 0) := x"0001";
   
end simple_risc_def;

package body simple_risc_def is
 
end simple_risc_def;