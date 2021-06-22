library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Microprogram_counter is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Mc: in STD_LOGIC_VECTOR(0 to 3);
           OutMU: in STD_LOGIC_VECTOR(7 downto 0);
           NextAddress: out STD_LOGIC_VECTOR(7 downto 0));
end Microprogram_counter;

architecture Behavioral of Microprogram_counter is

signal MPC : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal NextAddr: STD_LOGIC_VECTOR(7 downto 0);

begin

--Output2
  NextAddress <= NextAddr when Mc(3)='1';

-- Program Counter
    process(Clk)
    begin
        if rising_edge(Clk) then
            if Rst = '1' then
                MPC <= (others => '0');
            else
                MPC <= NextAddr;
            end if;
        end if;
    end process;

-- Adder    
    process(Mc)
    begin
        case Mc(0 to 2) is
            when "110" => NextAddr <= MPC + 1; -- next instruction
            when "101" => NextAddr <= MPC + OutMU; -- branch
            when "001" => NextAddr <= OutMU; --jump
            when others => NextAddr <= MPC + 1;
        end case;
    end process;

end Behavioral;
