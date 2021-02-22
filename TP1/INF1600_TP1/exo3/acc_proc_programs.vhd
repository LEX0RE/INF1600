use work.acc_proc_def.all;

package acc_proc_programs is

   -- Le contenu de la memoire est uint16, 
   -- ce qui explique l'utilisation de fonctions
   -- de converssion
   constant program_0 : memtype := (
      to_uint16((ld,   7)),   --  0 
      to_uint16((br,   3)),   --  1
      to_uint16((ld,   8)),   --  2
      to_uint16((brz,  5)),   --  3
      to_uint16((add,  9)),   --  4
      to_uint16((brnz, 1)),   --  5
      to_uint16((stop, 0)),   --  6
      +2,                     --  7
      +1,                     --  8
      int16_to_uint16(-1),    --  9
      others => 0
   );

   -- Programme utilise pour Q2
   constant program_1 : memtype := (
      -- ajouter votre programme ici, une ligne par instruction
      to_uint16((lda,   11)),   --  0
      to_uint16((ldi, 00)),     --  1
      to_uint16((suba,  14)),   --  2
      to_uint16((addx, 00)),    --  3 
      to_uint16((add,  14)),    --  4 
      to_uint16((adda, 15)),    --  5 
      to_uint16((sti, 00)),     --  6 
      to_uint16((add,  10)),    --  7 
      to_uint16((brz,  13)),    --  8 
      to_uint16((br,  1)),      --  9 
      int16_to_uint16(-20),     -- 10 
      +15,                      -- 11
      int16_to_uint16(-20),     -- 12
      to_uint16((stop, 0)),     -- FIN -- 13
      +1,                       -- S(0) -- 14
      +2,                       -- S(1) -- 15
      others => 0
   );
   
end acc_proc_programs;

package body acc_proc_programs is  
end acc_proc_programs;
