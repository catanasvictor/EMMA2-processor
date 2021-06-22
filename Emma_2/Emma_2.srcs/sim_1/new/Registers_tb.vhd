library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registers_tb is
--  Port ( );
end Registers_tb;

architecture Behavioral of Registers_tb is

component Registers is
    Port ( Clk : in std_logic;
           Mc : in std_logic_vector (0 to 3);
           ReadAddress1 : in std_logic_vector (3 downto 0);
		   ReadAddress2 : in std_logic_vector (3 downto 0);
		   WriteAddress : in std_logic_vector (3 downto 0);
		   WriteData : in std_logic_vector (15 downto 0);
		   InBus1 : out std_logic_vector (15 downto 0);
		   InBus2 : out std_logic_vector (15 downto 0));
end component;

signal Clk : STD_LOGIC := '0';
signal Mc : STD_LOGIC_VECTOR (3 downto 0);
signal ReadAddress1 : STD_LOGIC_VECTOR (3 downto 0);
signal ReadAddress2 : STD_LOGIC_VECTOR (3 downto 0);
signal WriteAddress : STD_LOGIC_VECTOR (3 downto 0);
signal WriteData : STD_LOGIC_VECTOR (15 downto 0);
signal InBus1 : STD_LOGIC_VECTOR (15 downto 0);
signal InBus2: STD_LOGIC_VECTOR (15 downto 0);

constant CLK_PERIOD : TIME := 10 ns;

begin
    
    DUT: Registers port map (Clk => Clk, Mc => Mc, ReadAddress1 => ReadAddress1,
                             ReadAddress2 => ReadAddress2, WriteAddress => WriteAddress,
                             WriteData => WriteData, InBus1 => InBus1, InBus2 => InBus2);
    
    gen_clk: process
    begin
     Clk <= '0';
     wait for (CLK_PERIOD/2);
     Clk <= '1';
     wait for (CLK_PERIOD/2);
    end process gen_clk; 
    
    gen_vect_test: process 
    begin
       
        Mc <= "0100";

        for i in 0 to 15 loop
            WriteAddress <= STD_LOGIC_VECTOR(to_unsigned(i, WriteAddress'length));
            WriteData <= STD_LOGIC_VECTOR(to_unsigned(i, WriteData'length));
            wait for CLK_PERIOD;
        end loop;
        
        Mc <= "0011";
        
        for i in 0 to 7 loop
             ReadAddress1 <= std_logic_vector(to_unsigned(i, ReadAddress1'length)); 
             ReadAddress2 <= std_logic_vector(to_unsigned(i+8, ReadAddress2'length));
             wait for CLK_PERIOD;
        end loop;
       wait;     
    end process;

end Behavioral;

