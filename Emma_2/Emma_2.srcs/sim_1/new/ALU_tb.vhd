library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is

component ALU is
    Port ( Clk : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(15 downto 0);
           Mc: in std_logic_vector(0 to 7);
           Accumulator : out STD_LOGIC_VECTOR(15 downto 0);
           CC0 : out STD_LOGIC;
           CC1 : out STD_LOGIC);
end component;

signal Clk : STD_LOGIC:='0';
signal A,B: STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
signal Mc : STD_LOGIC_VECTOR(0 to 7):= (others =>'0');
signal Accumulator : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
signal CC0,CC1 : STD_LOGIC:='0';

constant CLK_PERIOD : TIME := 10 ns;

begin

    DUT: ALU port map (Clk=>Clk, A => A, B => B, Mc => Mc, Accumulator => Accumulator, CC0=>CC0, CC1 => CC1);

    gen_clk: process
    begin
     Clk <= '0';
     wait for (CLK_PERIOD/2);
     Clk <= '1';
     wait for (CLK_PERIOD/2);
    end process gen_clk; 

    
    gen_vect_test: process 
    begin
        
        A <= conv_std_logic_vector(5,16);
        B <= conv_std_logic_vector(2,16);
        
        for i in 0 to 7 loop
         Mc <= conv_std_logic_vector(i,8);
         wait for CLK_PERIOD;
        end loop;
        
        wait;
    end process;

end Behavioral;