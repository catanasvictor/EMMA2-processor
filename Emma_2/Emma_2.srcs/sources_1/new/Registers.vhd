library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Registers is
    Port ( Clk : in std_logic;
           Mc : in std_logic_vector (0 to 3);
           ReadAddress1 : in std_logic_vector (3 downto 0);
		   ReadAddress2 : in std_logic_vector (3 downto 0);
		   WriteAddress : in std_logic_vector (3 downto 0);
		   WriteData : in std_logic_vector (15 downto 0);
		   InBus1 : out std_logic_vector (15 downto 0);
		   InBus2 : out std_logic_vector (15 downto 0));
end Registers;

architecture Behavioral of Registers is

type reg_array is array(0 to 15) of std_logic_vector(15 downto 0);

signal reg_file : reg_array:=(
  --X"0000", 
  X"0001", X"0002",
--X"0003",
--X"0004",X"0005",X"0006",X"0007",
--X"0008",X"0009",X"000A",X"000B",
--X"000C",X"000D",X"000E",X"000F",
others => X"0000");

signal RegWrite: STD_LOGIC_VECTOR(0 to 1):="00";
signal Output1, Output2: STD_LOGIC:='0';

begin

    RegWrite <= Mc(0 to 1);
    Output1 <= Mc(2);
    Output2 <= Mc(3);
    

--read from reg
InBus1 <= reg_file(conv_integer(ReadAddress1)) when Output1='1' else (others => '0'); --rs
InBus2 <= reg_file(conv_integer(ReadAddress2)) when Output2='1' else (others => '0'); --rt

--write in reg
process(Clk)			
begin
	if rising_edge(Clk) and RegWrite="01" then
		reg_file(conv_integer(WriteAddress)) <= WriteData;		
	end if;
end process;		

end Behavioral;
