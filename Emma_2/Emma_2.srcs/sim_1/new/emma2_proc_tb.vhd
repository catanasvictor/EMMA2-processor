library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity emma2_proc_tb is
--  Port ( );
end emma2_proc_tb;

architecture Behavioral of emma2_proc_tb is

component emma2_proc is
    Port ( Clk      : in  STD_LOGIC;
           Btn : in STD_LOGIC_VECTOR (1 downto 0);
           AdrInstr : out STD_LOGIC_VECTOR (15 downto 0);
           Instruction    : out STD_LOGIC_VECTOR (31 downto 0);
           Data     : out STD_LOGIC_VECTOR (31 downto 0);
           ZF      : out  STD_LOGIC;
           NF      : out  STD_LOGIC);
end component;

signal Clk : STD_LOGIC:='0';
signal Btn : STD_LOGIC_VECTOR (1 downto 0):=(others=>'0');
signal AdrInstr : STD_LOGIC_VECTOR (15 downto 0):=(others=>'0');
signal Instruction :  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
signal Data : STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
signal ZF,NF : STD_LOGIC:='0';

constant CLK_PERIOD : TIME := 10 ns;

begin

    DUT: emma2_proc port map (Clk=>Clk, Btn => Btn, AdrInstr => AdrInstr,Instruction => Instruction, 
                              Data =>Data, ZF => ZF, NF => NF);

    gen_clk: process
    begin
     Clk <= '0';
     wait for (CLK_PERIOD/2);
     Clk <= '1';
     wait for (CLK_PERIOD/2);
    end process gen_clk; 

    
    gen_vect_test: process 
    begin
        
        Btn<="10";
        wait for 100 ns;
        Btn<="01";
        
        wait;
    end process;



end Behavioral;
