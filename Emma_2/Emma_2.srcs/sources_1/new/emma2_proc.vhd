library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity emma2_proc is
    Port ( Clk      : in  STD_LOGIC;
           Btn : in STD_LOGIC_VECTOR (1 downto 0);
           AdrInstr : out STD_LOGIC_VECTOR (15 downto 0);
           Instruction    : out STD_LOGIC_VECTOR (31 downto 0);
           Data     : out STD_LOGIC_VECTOR (31 downto 0);
           ZF      : out  STD_LOGIC;
           NF      : out  STD_LOGIC);
end emma2_proc;

architecture Behavioral of emma2_proc is

component MPG is
    Port ( en : out STD_LOGIC;
           input : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

component ALU is
    Port ( Clk: in STD_LOGIC;
           A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(15 downto 0);
           Mc: in std_logic_vector(0 to 7);
           Accumulator : out STD_LOGIC_VECTOR(15 downto 0);
           CC0 : out STD_LOGIC;
           CC1 : out STD_LOGIC);
end component;

component Data_memory is
    Port ( Clk : in STD_LOGIC;
           Mc: in STD_LOGIC_VECTOR(0 to 3);
           MAR_in : in STD_LOGIC_VECTOR(15 downto 0);
           MBR_in : in STD_LOGIC_VECTOR(15 downto 0);
           MBR_out : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Instr_memory is
    Port ( Address: in STD_LOGIC_VECTOR(15 downto 0);
           Instruction: out STD_LOGIC_VECTOR(31 downto 0));
end component;

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

component Program_counter is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           En : in STD_LOGIC;
           Mc: in STD_LOGIC_VECTOR(0 to 3);
           OutBus2: in STD_LOGIC_VECTOR(15 downto 0);
           NextAddress: out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Microprogram_counter is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Mc: in STD_LOGIC_VECTOR(0 to 3);
           OutMU: in STD_LOGIC_VECTOR(7 downto 0);
           NextAddress: out STD_LOGIC_VECTOR(7 downto 0));
end component;

component Microcode_Unit is
    Port ( IR : in STD_LOGIC_VECTOR (31 downto 0);
           Mc : in STD_LOGIC_VECTOR (0 to 7);
           AdrMC : in STD_LOGIC_VECTOR (7 downto 0);
           AdrD : out STD_LOGIC_VECTOR (3 downto 0);
           AdrSA : out STD_LOGIC_VECTOR (3 downto 0);
           AdrSB : out STD_LOGIC_VECTOR (3 downto 0);
           InBus1 : out STD_LOGIC_VECTOR (15 downto 0);
           InBus2 : out STD_LOGIC_VECTOR (15 downto 0);
           InMPC : out STD_LOGIC_VECTOR (7 downto 0);
           Micro: out STD_LOGIC_VECTOR (31 downto 0));
end component;

--MPG
signal en,rst: STD_LOGIC:='0';

--ALU
signal ACC: STD_LOGIC_VECTOR (15 downto 0):= (others=>'0');
signal CC0,CC1: STD_LOGIC:='0';

--MU
signal InMPC: STD_LOGIC_VECTOR (7 downto 0):= (others=>'0');
signal InBus1_1,InBus2_1: STD_LOGIC_VECTOR (15 downto 0):= (others=>'0');
signal Mc_out: STD_LOGIC_VECTOR (0 to 31):= (others=>'0');

--REG
signal RA1,RA2,WA: STD_LOGIC_VECTOR (3 downto 0):= (others=>'0');
signal InBus1_2,InBus2_2: STD_LOGIC_VECTOR (15 downto 0):= (others=>'0');

--MPC
signal AdrMc: STD_LOGIC_VECTOR (7 downto 0):= (others=>'0');

--IM
signal Address: STD_LOGIC_VECTOR (15 downto 0):= (others=>'0');
signal Instr: STD_LOGIC_VECTOR (31 downto 0):= (others=>'0');

--DATA
signal InBus1_3: STD_LOGIC_VECTOR (15 downto 0):= (others=>'0');

--BUS
signal Bus1,Bus2: STD_LOGIC_VECTOR (15 downto 0):= (others=>'0');


begin

    MPG1: MPG port map(en=>en, input=>btn(0), clock=>Clk);
    MPG2: MPG port map(en=>rst, input=>btn(1), clock=>Clk);
     

    MU: Microcode_Unit port map( IR => Instr, AdrMc => AdrMc, Mc => Mc_out(0 to 7), AdrD => WA, AdrSA =>RA1,
                                 AdrSB => RA2, InBus1 => InBus1_1, InBus2 => InBus2_1, InMPC => InMPC, Micro => Mc_out);   
                                 
    MPC: Microprogram_counter port map( Clk => Clk, Rst => rst, Mc => Mc_out(8 to 11),
                                        OutMU => inMPC, NextAddress => AdrMc);
    
    PC: Program_counter port map( Clk => Clk, Rst => rst, En => en, Mc => Mc_out(12 to 15),
                                  OutBus2 => Bus2, NextAddress => Address);
                     
    REG: Registers port map ( Clk => Clk, Mc => Mc_out(16 to 19), ReadAddress1 => RA1, ReadAddress2 => RA2,
		                      WriteAddress => WA, WriteData => ACC, InBus1 => InBus1_2, InBus2 => InBus2_2);
		                      
    DM: Data_memory port map ( Clk => Clk, Mc => Mc_out(20 to 23),
                               MAR_in => Bus2, MBR_in => Bus1, MBR_out => InBus1_3);

    IM: Instr_memory port map( Address => Address, Instruction => Instr);

    ALU1: ALU port map( Clk => Clk, A => Bus1, B => Bus2, Mc => Mc_out(24 to 31),
                        Accumulator => ACC, CC0 => CC0, CC1 => CC1);
                        
    -- BUS1 --
    B1: process(InBus1_1,InBus1_2,InBus1_3)
    begin
         if(Mc_out(1)='1') then
           Bus1 <= InBus1_1;
         elsif(Mc_out(18)='1') then
           Bus1 <= InBus1_2;  
         elsif(Mc_out(23)='1') then
           Bus1 <= InBus1_3;  
         end if;
    end process;
    
    -- BUS2 --
    B2: process(InBus2_1,InBus2_2,ACC)
    begin
         if(Mc_out(2)='1') then
           Bus2 <= InBus2_1;
         elsif(Mc_out(19)='1') then
           Bus2 <= InBus2_2;  
         elsif(Mc_out(27)='1') then
           Bus2 <= ACC;  
         end if;
    end process;
    
    --Output
    AdrInstr <= Address;
    Instruction <= Instr;
    Data <= x"0000" & ACC ;
    ZF <= CC0;
    NF <= CC1;

end Behavioral;
