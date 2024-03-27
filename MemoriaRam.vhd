library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity RamRam is
  generic(--variables genericas I U
    I:integer:=8;--buz de datos de 8 bits
    U:integer:=32--buz de direcciones de 32 bits
  );
  port(
    clk: in STD_LOGIC;
    en: in STD_LOGIC;
    rst:in STD_LOGIC;
    wr:in std_logic;
    rd:in std_logic;
    din:in STD_LOGIC_VECTOR(I-1 downto 0);
    addr:in STD_LOGIC_VECTOR(U-1 downto 0);
    dout:out STD_LOGIC_VECTOR(I-1 downto 0)
  );
end RamRam; 

architecture arch of RamRam is

    type RAM is array(2**U-1 downto 0) of STD_LOGIC_VECTOR(I-1 downto 0);
    signal EstadoRam: RAM;

begin
     my:process(clk,rst)
         begin
            if(rst='0') then
                dout <=(others =>'0');
            elsif(rising_edge(clk)) then
                if(en='1' and wr='1' and rd='0') then
                    EstadoRam(to_integer(unsigned(addr))) <= din;
                elsif(en='1' and wr='0' and rd='1') then
                    dout <= EstadoRam(to_integer(unsigned(addr)));
                else
                    dout <=(others => 'Z');
                end if;
            end if;
    end process my;
end architecture arch ;