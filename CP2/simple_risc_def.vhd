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
   
   type state_type is (start, fetch, decode, op_alu, jump, ldi, 
                       write_mem_1, write_mem_2, 
                       read_mem_1, read_mem_2, read_mem_3, 
                       stop);
   
   function getX(A : in natural) return signed;   
   function getY(B : in natural) return signed;   
   function getZ(C : in natural) return signed;   
   function getW(D : in natural) return signed;
   
   constant A : natural := mon_matricule mod 2;
   constant B : natural := mon_matricule mod 3;
   constant C : natural := mon_matricule mod 5;
   constant D : natural := mon_matricule mod 7;
   
   constant X : signed(dm_dw - 1 downto 0) := getX(A);
   constant Y : signed(dm_dw - 1 downto 0) := getY(B);
   constant Z : signed(dm_dw - 1 downto 0) := getZ(C);
   constant W : signed(dm_dw - 1 downto 0) := getW(D);
   
end simple_risc_def;

package body simple_risc_def is
  
   function getX(A : in natural)
      return signed is
      variable value : signed(15 downto 0);
   begin
      if( A = 0 ) then
         value := x"0001";
      else -- 1
         value := x"0004";
      end if;
      return value;
   end getX;
   
   function getY(B : in natural)
      return signed is
      variable value : signed(15 downto 0);
   begin
      if( B = 0 ) then
         return x"0002";
      elsif( B = 1 ) then
         return x"0003";
      else -- 2
         return x"0004";
      end if;
      return value;
   end getY;
   
   function getZ(C : in natural)
      return signed is
      variable value : signed(15 downto 0);
   begin
      if( C = 0 ) then
         return x"0002";
      elsif( C = 1 ) then
         return x"FFFD";
      elsif( C = 2 ) then
         return x"0003";
      elsif( C = 3 ) then
         return x"FFFC";
      else -- 4
         return x"0004";
      end if;
      return value;
   end getZ;
   
   function getW(D : in natural)
      return signed is
      variable value : signed(15 downto 0);
   begin
      if( D = 0 ) then
         return x"0001";
      elsif( D = 1 ) then
         return x"FFFE";
      elsif( D = 2 ) then
         return x"0002";
      elsif( D = 3 ) then
         return x"FFFD";
      elsif( D = 4 ) then
         return x"0003";
      elsif( D = 5 ) then
         return x"FFFC";
      else -- 6
         return x"0004";
      end if;
      return value;
   end getW; 
 
end simple_risc_def;