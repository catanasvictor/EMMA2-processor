library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Microprogram_counter_tb is
--  Port ( );
end Microprogram_counter_tb;

architecture Behavioral of Microprogram_counter_tb is

component Microprogram_counter is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Mc: in STD_LOGIC_VECTOR(0 to 3);
           OutMU: in STD_LOGIC_VECTOR(7 downto 0);
           NextAddress: out STD_LOGIC_VECTOR(7 downto 0));
end component;

signal Clk,Rst : STD_LOGIC:='0';
signal Mc: STD_LOGIC_VECTOR(0 to 3):= (others =>'0');
signal OutMU : STD_LOGIC_VECTOR(7 downto 0):= (others =>'0');
signal NextAddress : STD_LOGIC_VECTOR(7 downto 0):= (others =>'0');

constant CLK_PERIOD : TIME := 10 ns;

begin

    DUT: Microprogram_counter port map (Clk=>Clk, Rst=>Rst, Mc => Mc, OutMU => OutMU,
                                   NextAddress => NextAddress);

    gen_clk: process
    begin
     Clk <= '0';
     wait for (CLK_PERIOD/2);
     Clk <= '1';
     wait for (CLK_PERIOD/2);
    end process gen_clk; 

    
    gen_vect_test: process 
    begin
        
        Rst<='1';
        wait for CLK_PERIOD;
        Rst<='0'; 
        Mc<="1101"; 
        wait for CLK_PERIOD;
        Mc<="0011"; 
        OutMU <= conv_std_logic_vector(5,8);
        wait for CLK_PERIOD;
        Mc<="1011"; 
        OutMU <= conv_std_logic_vector(4,8);
        wait for CLK_PERIOD;
        Rst<='1'; 
        
        wait;
    end process;
end Behavioral;
