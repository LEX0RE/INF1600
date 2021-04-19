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

   -- memoir des instructins
   signal inst_memory : inst_mem_type := my_inst_memory;
      
   -- signaux de la mémoire des données
   signal MWD            : signed(dm_dw - 1 downto 0);
   signal MD             : signed(dm_dw - 1 downto 0);
   signal MA             : integer range 0 to 2 ** dm_aw - 1;
   signal wmem           : std_logic;
   signal rmem           : std_logic;
   
   signal wmem_confirmed : std_logic := '0';
   signal rmem_confirmed : std_logic := '0';
   
   -- bloc des registres
   signal registers : reg_type;
   
   -- registres speciaux
   signal PC : integer range 0 to (2 ** im_aw - 1) := 0;               -- compteur de programme
   signal IR : std_logic_vector(im_dw - 1 downto 0):= (others => '1'); -- registre d'instruction
   
   -- signaux de controle de PC et IR
   signal wPC      : std_logic := '0';
   signal wIR      : std_logic := '0';
   signal doBranch : std_logic := '0';
   
   -- signaux des registres
   signal A        : signed(dw - 1 downto 0);
   signal rsrc1    : integer range 0 to Nreg - 1;
   signal B        : signed(dw - 1 downto 0);
   signal rsrc2    : integer range 0 to Nreg - 1;
   signal donnee   : signed(dw - 1 downto 0);
   signal rdst     : integer range 0 to Nreg - 1;
   signal wreg     : std_logic;
   
   -- signaux du multiplexeur contrôlant la source du bloc des registres
   signal constante   : signed(dw - 1 downto 0);
   signal choixSource : integer range 0 to 3;
   
   -- signaux de l'UAL
   signal wFLAG : std_logic;
   signal F     : signed(dw - 1 downto 0);
   signal Z     : std_logic;
   signal N     : std_logic;
   signal op    : integer range 0 to 7;
   
   -- composants
   component simple_risc_mem_if is
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
   end component;
   
   component simple_risc_cu is
   port(
      rst            : in  std_logic;
      clk            : in  std_logic;
      IR             : in  std_logic_vector(im_dw - 1 downto 0);
      N              : in  std_logic;
      Z              : in  std_logic;
      wmem_confirmed : in  std_logic;
      rmem_confirmed : in  std_logic;
      wPC            : out std_logic;
      wIR            : out std_logic;
      wFLAG          : out std_logic;
      wmem           : out std_logic;
      rmem           : out std_logic;
      wreg           : out std_logic;
      doBranch       : out std_logic;
      choixSource    : out integer range 0 to 3
   );
   end component;

begin
   
   -- ***********************
   -- *
   -- * PC/IR
   -- *
   -- ***********************
   
   process (clk, rst)
   begin
      if rst = '1' then
      
         PC <= 0;
         IR <= (others => '1');
         
      elsif rising_edge(clk) then
      
         if( wPC = '1' ) then
            if( doBranch = '1' ) then
               PC <= to_integer(unsigned(IR(im_aw - 1 downto 0)));
            else
               PC <= PC + 1;
            end if;
         end if;
         
         if( wIR = '1' ) then
            IR <= inst_memory(PC); 
         end if;
         
      end if;
   end process;
   
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
         if( wFLAG = '1' ) then 
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
   mem : simple_risc_mem_if
   generic map( my_data_memory => program_data )
   port map(
      rst  => rst,
      clk  => clk,
      din  => MWD,
      addr => MA,
      we   => wmem,
      re   => rmem,
      dout => MD,
      wc   => wmem_confirmed,
      rc   => rmem_confirmed
   );
   
   process( clk )is
   begin
      if( rst = '1' ) then
         MA  <= 0;
         MWD <= (others => '0');
      elsif rising_edge(clk) then
         MA  <= to_integer(unsigned(A(7 downto 0)));
         MWD <= B;
      end if;
   end process;
   
   -- ***********************
   -- *
   -- * unité de contrôle
   -- *
   -- ***********************
   uc : simple_risc_cu
   port map(
      rst            => rst,
      clk            => clk,
      IR             => IR,
      N              => N,
      Z              => Z,
      wmem_confirmed => wmem_confirmed,
      rmem_confirmed => rmem_confirmed,
      wPC            => wPC,
      wIR            => wIR,
      wFLAG          => wFLAG,
      wmem           => wmem,
      rmem           => rmem,
      wreg           => wreg,
      doBranch       => doBranch,
      choixSource    => choixSource
   );
   
end arch;