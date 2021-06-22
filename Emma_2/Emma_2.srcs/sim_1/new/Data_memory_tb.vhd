library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity DataMemory_tb is
--  Port ( );
end DataMemory_tb;

architecture Behavioral of DataMemory_tb is

component Data_memory is
    Port ( Clk : in STD_LOGIC;
           Mc: in STD_LOGIC_VECTOR(0 to 3);
           MAR_in : in STD_LOGIC_VECTOR(15 downto 0);
           MBR_in : in STD_LOGIC_VECTOR(15 downto 0);
           MBR_out : out STD_LOGIC_VECTOR(15 downto 0));
end component;

signal Clk : STD_LOGIC:='0';
signal Mc: STD_LOGIC_VECTOR(0 to 3):= (others =>'0');
signal MAR_in : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
signal MBR_in : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
signal MBR_out : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');

constant CLK_PERIOD : TIME := 10 ns;

begin

    DUT: Data_memory port map (Clk=>Clk, Mc => Mc, MAR_in => MAR_in,
                              MBR_in => MBR_in, MBR_out =>MBR_out);

    gen_clk: process
    begin
     Clk <= '0';
     wait for (CLK_PERIOD/2);
     Clk <= '1';
     wait for (CLK_PERIOD/2);
    end process gen_clk; 

    
    gen_vect_test: process 
    begin
        --scriere
        Mc <= "0111";
        for i in 0 to 15 loop
           MAR_in <= conv_std_logic_vector(i,16);
           MBR_in <= conv_std_logic_vector(i,16);
           wait for CLK_PERIOD;
        end loop;
        
        --citire
        Mc <= "1001";
        for i in 0 to 15 loop
            MAR_in <= conv_std_logic_vector(i,16);
            wait for CLK_PERIOD;
        end loop;
        
        wait;
    end process;

end Behavioral;