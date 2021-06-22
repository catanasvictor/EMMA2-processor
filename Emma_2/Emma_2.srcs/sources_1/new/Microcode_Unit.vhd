library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity Microcode_Unit is
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
end Microcode_Unit;

architecture Behavioral of Microcode_Unit is

-- MICROCODE MEMORY --
type mem_type is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
signal Mc_memory : mem_type := (

    x"400B_0000", --0 JUMP
    x"0000_0000", --1 JREG
    x"0000_0000", --2 BEQZ
    x"1030_0000", --3 BNEG
    x"0000_0000", --4 LD
    x"0000_0000", --5 LDL
    x"0000_0000", --6 LDX
    x"0000_0000", --7 ST
    x"0000_0000", --8 STX
    x"000D_3000", --9 ADD
    x"0000_0000", --10 ADDL
    x"000D_3001", --11 SUB
    
    others => X"0000_0000");

type op is (JUMP, JREG, BEQZ, BNEG, LD, LDL, LDX, ST, STX , ADD, ADDL, 
 SUB, SUBL, ANDD, ANDL, ORR, ORL, XORR, XORL, SLLS, SLLL, SRLS, SRLL,
 SRAA, SRAL, MUL, MULL, DIV, DIVL, OP1, OP2, STOP);
 
signal stare : op := JUMP;
signal toBus1,toBus2,toMPC : STD_LOGIC :='0';
signal Immediate : STD_LOGIC_VECTOR(15 downto 0):= (others =>'0');
signal Address : STD_LOGIC_VECTOR(7 downto 0):= (others =>'0');

begin

    AdrD <= IR(23 downto 20);
    AdrSA <= IR(19 downto 16); 
    AdrSB <= IR(15 downto 12);
    Immediate <= IR(15 downto 0);

    toBus1 <= Mc(1);
    toBus2 <= Mc(2);
    toMPC <= Mc(3);

    InBus1 <= Immediate when toBus1='1' else (others=>'0');
    InBus2 <= Immediate when toBus2='1' else (others=>'0');
    InMPC <= Address when toMPC='1' else (others=>'0');
    
    Operation:process(IR)
    begin

    case IR(31 downto 24) is

        when "00000000" =>  stare <= JUMP;
        when "00000001" =>  stare <= JREG;
        when "00000010" =>  stare <= BEQZ;
        when "00000011" =>  stare <= BNEG;
        when "00000100" =>  stare <= LD;
        when "00000101" =>  stare <= LDL;
        when "00000110" =>  stare <= LDX;
        when "00000111" =>  stare <= ST;
        when "00001000" =>  stare <= STX;
        when "00001001" =>  stare <= ADD;
        when "00001010" =>  stare <= ADDL;
        when "00001011" =>  stare <= SUB;
        when "00001100" =>  stare <= SUBL;
        when "00001101" =>  stare <= ANDD;
        when "00001110" =>  stare <= ANDL;
        when "00001111" =>  stare <= ORR;
        when "00010000" =>  stare <= ORL;
        when "00010001" =>  stare <= XORR;
        when "00010010" =>  stare <= XORL;
        when "00010011" =>  stare <= SLLS;
        when "00010100" =>  stare <= SLLL;
        when "00010101" =>  stare <= SRLS;
        when "00010110" =>  stare <= SRLL;
        when "00010111" =>  stare <= SRAA;
        when "00011000" =>  stare <= SRAL;
        when "00011001" =>  stare <= MUL;
        when "00011010" =>  stare <= MULL;
        when "00011011" =>  stare <= DIV;
        when "00011100" =>  stare <= DIVL;
        when "00011101" =>  stare <= OP1;
        when "00011110" =>  stare <= OP2;
        when "00011111" =>  stare <= STOP;
        when others => stare <= ADD;
 end case;
 end process Operation;


process(stare)
begin
    case stare is 
    
        when JUMP => Micro <= Mc_memory(0);
        when JREG => Micro <= Mc_memory(1);
        when  BEQZ => Micro <= Mc_memory(2);
        when  BNEG => Micro <= Mc_memory(3);
        when  LD => Micro <= Mc_memory(4); Address<=x"38";
        when  LDL => Micro <= Mc_memory(5);
        when  LDX => Micro <= Mc_memory(6);
        when  ST => Micro <= Mc_memory(7);
        when  STX => Micro <= Mc_memory(8);
        when  ADD => Micro <= Mc_memory(9);
        when  ADDL => Micro <= Mc_memory(10);
        when  SUB => Micro <= Mc_memory(11);
        when  SUBL => Micro <= Mc_memory(12);
        when  ANDD => Micro <= Mc_memory(13);
        when  ANDL => Micro <= Mc_memory(14);
        when  ORR => Micro <= Mc_memory(15);
        when  ORL => Micro <= Mc_memory(16);
        when  XORR => Micro <= Mc_memory(17);
        when  XORL => Micro <= Mc_memory(18);
        when  SLLS => Micro <= Mc_memory(19);
        when  SLLL => Micro <= Mc_memory(20);
        when  SRLS => Micro <= Mc_memory(21);
        when  SRLL => Micro <= Mc_memory(22);
        when  SRAA => Micro <= Mc_memory(23);
        when  SRAL => Micro <= Mc_memory(24);
        when  MUL => Micro <= Mc_memory(25);
        when  MULL => Micro <= Mc_memory(26);
        when  DIV => Micro <= Mc_memory(27);
        when  DIVL => Micro <= Mc_memory(28);
        when  OP1 => Micro <= Mc_memory(29);
        when  OP2 => Micro <= Mc_memory(30);
        when  STOP => Micro <= Mc_memory(31);
		when others => Micro <= Mc_memory(to_integer(unsigned(AdrMc)));
	end case;
end process;

end Behavioral;
