library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.simple_risc_def.all;
use work.simple_risc_programs.all;

entity simple_risc is
   generic (
      my_inst_memory : inst_mem_type := program_inst; 
      my_data_memory : data_mem_type := program_data 
   );
   port(
      rst : in std_logic;
      clk : in std_logic
   );
end simple_risc;

architecture arch of simple_risc is

   -- signaux des mémoires
   signal inst_memory : inst_mem_type := my_inst_memory;
   signal data_memory : data_mem_type := my_data_memory;
   
   signal MWD  : signed(dm_dw - 1 downto 0);
   signal MD   : signed(dm_dw - 1 downto 0);
   signal MA   : integer range 0 to 2 ** dm_aw - 1;
   signal wmem : std_logic;
   signal rmem : std_logic;
   
   -- bloc des registres
   signal registers : reg_type;
   
   -- registres speciaux
   signal PC : integer range 0 to (2 ** im_aw - 1);  -- compteur de programme
   signal IR : std_logic_vector(im_dw - 1 downto 0); -- registre d'instruction
   
   signal A        : signed(dw - 1 downto 0);
   signal rsrc1    : integer range 0 to Nreg - 1;
   signal B        : signed(dw - 1 downto 0);
   signal rsrc2    : integer range 0 to Nreg - 1;
   signal donnee   : signed(dw - 1 downto 0);
   signal rdst     : integer range 0 to Nreg - 1;
   signal wreg     : std_logic;
   
   -- signaux du multiplexeur contrôlant la source du bloc des registres
   signal constante : signed(dw - 1 downto 0);
   signal choixSource : integer range 0 to 3;
   
   -- signaux de l'UAL
   signal F : signed(dw - 1 downto 0);
   signal Z : std_logic;
   signal N : std_logic;
   signal op : integer range 0 to 7;
   
   -- signaux de l'unité de contrôle
   signal state : state_type;

begin
   
   -- ***********************
   -- *
   -- * Registres
   -- *
   -- ***********************

   -- signaux de selection des registres
   rdst  <= to_integer(unsigned(IR(20 downto 16)));
   rsrc1 <= to_integer(unsigned(IR(12 downto 8)));
   rsrc2 <= to_integer(unsigned(IR( 4 downto 0)));
   
   -- signaux de sortie du bloc des registres
   A <= registers(rsrc1);
   B <= registers(rsrc2);
   
   -- bloc des registres
   process (clk, rst)
   begin
      if rst = '1' then
         registers <= (others => (others => '0'));
      elsif rising_edge(clk) then
         if wreg = '1' then
            registers(rdst) <= donnee;
         end if;
      end if;
   end process;
   

   -- Source du bloc des registres   
   constante <= signed(IR(dw-1 downto 0)); -- valeur immédiate, 16 bits
   
   process (F, constante, md, choixSource)
   begin
      case choixSource is 
         when 0 => donnee <= F; 
         when 1 => donnee <= md;
         when 2 => donnee <= constante;
         when others => donnee <= F;
      end case;
   end process;
   
   -- ***********************
   -- *
   -- * UAL
   -- *
   -- ***********************

   op <= to_integer(unsigned(IR(26 downto 24)));
   
   -- UAL
   process(A, B, op)
   begin
      case op is
         when 0 => F <= A + B;
         when 1 => F <= A - B;
         when 2 => F <= shift_right(A, 1);
         when 3 => F <= shift_left(A, 1);
         when 4 => F <= not(A);
         when 5 => F <= A and B;
         when 6 => F <= A or B;
         when 7 => F <= A;
         when others => F <= (others => 'X');
      end case;
   end process;
   
   -- registre d'état de l'UAL
   process(clk, rst)
   begin
      if rst = '1' then
         Z <= '0';
         N <= '0';
      elsif rising_edge(clk) then
         if ( state = op_alu ) then
            if F = 0 then 
               Z <= '1'; 
            else 
               Z <= '0'; 
            end if;
            N <= F(F'left);
         end if;
      end if;
   end process;
   
   -- ***********************
   -- *
   -- * mémoire des donnees
   -- *
   -- ***********************
   
   process (clk)
   begin
      if rising_edge(clk) then
         
         wmem <= '0';
         rmem <= '0';
         
         if( state = write_mem_1 or state = read_mem_1 ) then
            MA   <= to_integer(unsigned(A(7 downto 0)));
         end if;
         
         if state = write_mem_1 then
            wmem <= '1'; 
            MWD  <= B;
         end if;
        
         if state = read_mem_1 then
            rmem <= '1'; 
         end if;
        
         if wmem = '1' then
            data_memory(MA) <= MWD;
         end if;
         
         if state = read_mem_2 then
            MD <= data_memory(MA);
         end if;
         
      end if;
   end process;
   
   
   -- ***********************
   -- *
   -- * unité de contrôle
   -- *
   -- ***********************
   process (clk, rst)
   begin
      if rst = '1' then
         state <= start;
      elsif rising_edge(clk) then
         case state is
            when start =>
                PC <= 0;
                state <= fetch;
            when fetch =>
                IR <= inst_memory(PC); 
                PC <= PC + 1; 
                state <= decode;
            when decode =>
               if (IR(27) = '0') then
                  state <= op_alu;
               else
                  case IR(26 downto 24) is
                     when "000"  => state <= read_mem_1;  -- 8
                     when "001"  => state <= write_mem_1; -- 9
                     when "010"  => state <= ldi;         -- A
                     when "100"  => state <= jump;        -- C
                     when "111"  => state <= stop;        -- F
                     when others => state <= stop;
                  end case;
               end if;
            when read_mem_1 =>
               state <= read_mem_2;
            when read_mem_2 =>
               state <= read_mem_3;
            when write_mem_1 =>
               state <= write_mem_2;
            when op_alu | read_mem_3 | write_mem_2 | ldi =>
               state <= fetch;
            when jump =>
               if (IR(19 downto 16) = "0000") or -- branchement sans condition
                  (IR(19 downto 16) = "0001" and Z = '1') or -- si = 0
                  (IR(19 downto 16) = "0010" and Z = '0') or -- si /= 0
                  (IR(19 downto 16) = "0011" and N = '1') or -- si < 0
                  (IR(19 downto 16) = "0100" and N = '0') -- si >= 0
               then
                   PC <= to_integer(unsigned(IR(im_aw - 1 downto 0)));
               end if;
               state <= fetch;
            when stop =>
               state <= stop;
            when others =>
               state <= start;
         end case;
      end if;
   end process;

   -- signaux de sortie de l'unité de contrôle
   with state select choixSource <=
      0 when op_alu,
      1 when read_mem_3,
      2 when ldi,
      3 when others;
   
   with state select wreg <=
      '1' when op_alu | read_mem_3 | ldi,
      '0' when others;
   
end arch;