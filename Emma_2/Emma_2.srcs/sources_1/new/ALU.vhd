library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

entity ALU is
    Port ( Clk: in STD_LOGIC;
           A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(15 downto 0);
           Mc: in std_logic_vector(0 to 7);
           Accumulator : out STD_LOGIC_VECTOR(15 downto 0);
           CC0 : out STD_LOGIC;
           CC1 : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal func: STD_LOGIC_VECTOR(0 to 2);
signal ALUCtrl : STD_LOGIC_VECTOR(2 downto 0);
signal ALUResAux : STD_LOGIC_VECTOR(15 downto 0);

begin

    func <= Mc(5 to 7);
			  

    -- ALU
    process(Clk)
    begin
    if(rising_edge(Clk)) then
        case func is
            when "000" => -- ADD
                ALUResAux <= A + B;
                
            when "001" =>  -- SUB
                ALUResAux <= A - B;  
                
            when "010" => -- AND
                ALUResAux <= A and B;
                
            when "011" => -- OR
                ALUResAux <= A or B; 
       
            when "100" => -- XOR
                ALUResAux <= A xor B;
                		
            when "101" => -- SLL
                ALUResAux <= B(14 downto 0) & "0";
                 
            when "110" => -- SRL
                ALUResAux <= "0" & B(15 downto 1);
                  
            when "111" => -- SRA
                ALUResAux <= B(0) & B(15 downto 1);  
            when others => 
                ALUResAux <= (others=>'0');
        end case;

        -- rez = 0
        case ALUResAux is
            when X"0000" => CC0 <= '1';
            when others  => CC0  <= '0';
        end case;
        
         -- rez < 0
        case ALUResAux(15) is
            when '1' => CC1 <= '1';
            when others  => CC1  <= '0';
        end case;
        
    end if;
    end process;

    -- ALU rezultat
    Accumulator <= ALUResAux;

end Behavioral;