library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Instr_memory is
    Port ( Address: in STD_LOGIC_VECTOR(15 downto 0);
           Instruction: out STD_LOGIC_VECTOR(31 downto 0));
end Instr_memory;

architecture Behavioral of Instr_memory is

-- Memorie ROM
type tROM is array (0 to 255) of STD_LOGIC_VECTOR (31 downto 0);
signal ROM : tROM := (

-- PROGRAM DE TEST
    b"00001001_0011_0001_0010_0000_0000_0000", --add $3,$1,$2
    b"00001001_0011_0000_0001_0000_0000_0000", --add $4,$1,$0
    --b"00000000_0000_0000_0001_0000_0000_0101", --jump 4

   -- X"0000_000A",
   -- X"0000_0064",
    --X"0000_03E8",
    --X"0000_2710",

others => X"0000_0000");

begin

 Instruction <= ROM(conv_integer(Address));

end Behavioral;
