library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.acc_proc_def.all;
use work.acc_proc_programs.all;

entity acc_proc_tb is
end acc_proc_tb;

architecture test of acc_proc_tb is

   component acc_proc is
   generic(
      program : memtype := program_1
   );
   port(
      rst : in  std_logic;
      clk : in  std_logic
   );
   end component;

   signal rst    : std_logic := '1';
   signal clk    : std_logic := '0';
   
   constant period : time     := 10 ns;

begin

   UUT1 : acc_proc
   generic map( program => program_1 ) -- CHARGER VOTRE PROGRAMME ICI -> program_1
   port map( rst => rst, clk => clk);
   
   clk <= not clk after period / 2;
   rst <= '1' after 0 ns,
          '0' after 3*period / 2;

end test;
