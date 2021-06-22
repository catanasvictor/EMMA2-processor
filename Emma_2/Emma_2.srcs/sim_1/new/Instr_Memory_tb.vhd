library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Instr_Memory_tb is
--  Port ( );
end Instr_Memory_tb;

architecture Behavioral of Instr_Memory_tb is

component Instr_memory is
    Port ( Address: in STD_LOGIC_VECTOR(15 downto 0);
           Instruction: out STD_LOGIC_VECTOR(31 downto 0));
end component;

signal val_100 : STD_LOGIC:= '0';
signal Address : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
signal Instruction : STD_LOGIC_VECTOR(31 downto 0):= (others =>'0');

begin

    DUT: Instr_Memory port map (Address => Address, Instruction => Instruction);

    gen_vect_test: process 
    begin
    
        Address <= conv_std_logic_vector(1,16);
        wait for 5 ns;
        if (Instruction = x"0000_0064") then
            val_100<='1';
        end if;
           
        Address <= conv_std_logic_vector(2,16);
        wait for 5 ns;
        if (Instruction = x"0000_0064") then
            val_100<='1';
        end if;
       
        wait;
    end process;


end Behavioral;
