package acc_proc_def is

   constant data_width   : positive := 16;
   constant memory_depth : positive := 256;

   subtype uint8  is natural range 0 to 2**8-1;
   subtype uint16 is natural range 0 to 2**16-1;
   subtype int16  is integer range -2**15 to 2**15-1;
   
   type memtype is array( 0 to memory_depth-1 ) of uint16;
   
   type operation is (add, sub, mul, 
                      adda, suba, 
                      addx, subx, 
                      ld, st,
                      lda, sta, 
                      ldi, sti, 
                      br, brz, brnz, 
                      stop, nop);
   type state_type is (fetch, decode, execute);
      
   type instruction is record
      op   : operation;
      disp : uint8;
   end record;
   
   function to_instruction(val : uint16)
      return instruction;
   
   function to_uint16(inst : instruction)
      return uint16;
   
   function uint16_to_int16(val : uint16) 
      return int16;
   
   function int16_to_uint16(val : int16)
      return uint16;
   
end acc_proc_def;

package body acc_proc_def is

   function to_instruction(val : uint16)
      return instruction is
      variable inst : instruction;
      variable op : natural;
   begin
   
      inst.disp := val mod 2**8;
      op        := (val - inst.disp)/( 2**8 );
      
      case op is
         when 0 =>
           inst.op := add;
         when 1 =>
           inst.op := sub;
         when 2 =>
           inst.op := mul;
         when 3 =>
           inst.op := adda;
         when 4 =>
           inst.op := suba;
         when 5 =>
           inst.op := addx;
         when 6 =>
           inst.op := subx;
         when 7 =>
           inst.op := ld;
         when 8 =>
           inst.op := st;
         when 9 =>
           inst.op := lda;
         when 10 =>
           inst.op := sta;
         when 11 =>
           inst.op := ldi;
         when 12 =>
           inst.op := sti;
         when 13 =>
           inst.op := br;
         when 14 =>
           inst.op := brz;
         when 15 =>
           inst.op := brnz;
         when 16 =>
           inst.op := stop;
         when others =>
           inst.op := nop;
      end case;
   
      return inst;
   
   end to_instruction;
   
   function to_uint16(inst : instruction)
      return uint16 is
      variable val : uint16;
   begin
      
      case inst.op is
         when add =>
           val := 0;
         when sub =>
           val := 1;
         when mul =>
           val := 2;
         when adda =>
           val := 3;
         when suba =>
           val := 4;
         when addx =>
           val := 5;
         when subx =>
           val := 6;
         when ld =>
           val := 7;
         when st =>
           val := 8;
         when lda =>
           val := 9;
         when sta =>
           val := 10;
         when ldi =>
           val := 11;
         when sti =>
           val := 12;
         when br =>
           val := 13;
         when brz =>
           val := 14;
         when brnz =>
           val := 15;
         when stop =>
           val := 16;
         when others =>
           val := 11;
      end case;
      
      val := ( (2**8) * (val) ) + inst.disp;
   
      return val;
   
   end to_uint16;
   
   function uint16_to_int16(val : uint16) 
    return int16 is
   begin
      
      if( val < 2 ** 15 ) then
         return val;
      else
         return (val - 2 ** 15) - (2 ** 15);
      end if;
   
   end uint16_to_int16;
   
   function int16_to_uint16(val : int16)
    return uint16 is
   begin
      
      if( val >= 0 ) then
         return val;
      else
         return (2 ** 15 + val) + (2 ** 15);
      end if;
   
   end int16_to_uint16;
  
end acc_proc_def;