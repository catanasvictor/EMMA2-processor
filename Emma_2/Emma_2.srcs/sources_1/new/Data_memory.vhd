library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Data_memory is
    Port ( Clk : in STD_LOGIC;
           Mc: in STD_LOGIC_VECTOR(0 to 3);
           MAR_in : in STD_LOGIC_VECTOR(15 downto 0);
           MBR_in : in STD_LOGIC_VECTOR(15 downto 0);
           MBR_out : out STD_LOGIC_VECTOR(15 downto 0));
end Data_memory;

architecture Behavioral of Data_memory is


signal MAR_input, MBR_input, MBR_output : STD_LOGIC:='0';
signal Read_Write : STD_LOGIC:='0';
signal MBR_int : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

type mem_type is array (0 to 31) of STD_LOGIC_VECTOR(15 downto 0);
signal MEM : mem_type := (

--     X"0000", X"0001", X"0002", X"0003", 
--     X"0004", X"0005", X"0006", X"0007", 
--     X"0008", X"0009", X"000A", X"000B", 
--     X"000C", X"000D", X"000E", X"000F",
--     X"0010", X"0011", X"0012", X"0013", 
--     X"0014", X"0015", X"0016", X"0017", 
--     X"0018", X"0019", X"001A", X"001B", 
--     X"001C", X"001D", X"001E", X"001F",
    others => X"0000");

begin

    MAR_input <= Mc(0);
    MBR_input <= Mc(1);
    Read_Write <= Mc(2);
    MBR_output <= Mc(3);
    
    MBR_out <= MEM(conv_integer(MAR_in(5 downto 0)));
    -- Data Memory --
     process(clk) 			
    begin
        if rising_edge(clk) then
        
            if (Read_Write = '1' and MAR_input = '1' and MBR_input='1') then --write
                MEM(conv_integer(MAR_in(5 downto 0))) <= MBR_in;
                
            elsif (Read_Write = '0' and MAR_input = '1') then --read phase 0
                MBR_int <= MEM(conv_integer(MAR_in(5 downto 0)));			
            end if;
            
        elsif falling_edge(clk) then --read phase 1
            if Read_Write = '0' and MBR_output='1' then
                MBR_out <= MBR_int;
            end if;
        end if;
    end process;


end Behavioral;
