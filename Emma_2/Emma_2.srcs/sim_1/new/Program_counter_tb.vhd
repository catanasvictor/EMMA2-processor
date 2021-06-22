library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Program_counter_tb is
--  Port ( );
end Program_counter_tb;

architecture Behavioral of Program_counter_tb is

component Program_counter is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           En : in STD_LOGIC;
           Mc: in STD_LOGIC_VECTOR(0 to 3);
           OutBus2: in STD_LOGIC_VECTOR(15 downto 0);
           NextAddress: out STD_LOGIC_VECTOR(15 downto 0));
end component;

signal Clk,Rst,En : STD_LOGIC:='0';
signal Mc: STD_LOGIC_VECTOR(0 to 3):= (others =>'0');
signal OutBus2 : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
signal NextAddress : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');

constant CLK_PERIOD : TIME := 10 ns;

begin

    DUT: Program_counter port map (Clk=>Clk, Rst=>Rst, En=>En, Mc => Mc, OutBus2 => OutBus2,
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
        
        Rst<='1'; En<='0';
        wait for CLK_PERIOD;
        Rst<='0'; En<='1';
        Mc<="1101"; 
        wait for CLK_PERIOD;
        Mc<="0011"; 
        OutBus2 <= conv_std_logic_vector(5,16);
        wait for CLK_PERIOD;
        Mc<="1011"; 
        OutBus2 <= conv_std_logic_vector(4,16);
        wait for CLK_PERIOD;
        Rst<='1'; En<='0';
        
        wait;
    end process;
end Behavioral;
