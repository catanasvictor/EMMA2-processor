library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Program_counter is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           En : in STD_LOGIC;
           Mc: in STD_LOGIC_VECTOR(0 to 3);
           OutBus2: in STD_LOGIC_VECTOR(15 downto 0);
           NextAddress: out STD_LOGIC_VECTOR(15 downto 0));
end Program_counter;

architecture Behavioral of Program_counter is

signal PC : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal NextAddr: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

begin

-- Output2
  NextAddress <= NextAddr when Mc(3)='1';

-- Program Counter
    process(Clk)
    begin
        if rising_edge(Clk) then
            if Rst = '1' then
                PC <= (others => '0');
            elsif En = '1' then
                PC <= NextAddr;
            end if;
        end if;
    end process;

-- Adder    
    process(Mc)
    begin
        case Mc(0 to 2) is
            when "110" => NextAddr <= PC + 1; -- next instruction
            when "101" => NextAddr <= PC + OutBus2; -- branch
            when "001" => NextAddr <= OutBus2; --jump
            when others => NextAddr <= PC + 1;
        end case;
    end process;

end Behavioral;
