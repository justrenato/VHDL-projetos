-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- UFPR, BCC, ci210 2013-2, autor: Roberto Hexsel, 03sep2016
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux2(a,b,s,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux2 is
  port(a,b : in  bit;                   -- entradas de dados
       s   : in  bit;                   -- entrada de selecao
       z   : out bit);                  -- saida
end mux2;

architecture estrut of mux2 is 

  -- declara componentes que sao instanciados
  component inv is
    port(A : in bit; S : out bit);
  end component inv;

  component nand2 is
    port(A,B : in bit; S : out bit);
  end component nand2;

  -- sinais internos
  signal r, p, q : bit;              
  
  -- compare ligacoes dos sinais com diagrama das portas logicas
  begin  

    Ui:  inv   port map(s, r);
    Ua0: nand2 port map(a, r, p);
    Ua1: nand2 port map(b, s, q);
    Uor: nand2 port map(p, q, z);
    
end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux4(a,b,c,d,s0,s1,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux4 is
  port(a,b,c,d : in  bit;               -- quatro entradas de dados
       s0,s1   : in  bit;               -- dois sinais de selecao
       z       : out bit);              -- saida
end mux4;

architecture estrut of mux4 is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  signal p,q,r : bit;                   -- sinais internos
begin
  
  Um1: mux2 port map (a, b, s0, p); 
  Um2: mux2 port map (c, d, s0, q);
  Um3: mux2 port map (p, q, s1, z);

    -- implemente usando tres mux2

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux8(a,b,c,d,e,f,g,h,s0,s1,s2,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux8 is
  port(a,b,c,d,e,f,g,h : in  bit;       -- oito entradas de dados
       s0,s1,s2        : in  bit;       -- tres sinais de controle
       z               : out bit);      -- saida
end mux8;

architecture estrut of mux8 is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  component mux4 is
    port(A,B,C,D : in  bit; S0,S1 : in  bit; Z : out bit);
  end component mux4;

  signal p,q,r : bit;                   -- sinais internos
  
begin
  
  Um1: mux4 port map (a, b, c, d, s0, s1, p); 
  Um2: mux4 port map (e, f, g, h, s0, s1, q);
  Um3: mux2 port map (p, q, s2, z);

  -- implemente usando dois mux4 e um mux2

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux8vet(entr(7downto0),sel(2downto1),z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux8vet is
  port(entr : in  reg8;
       sel  : in  reg3;
       z    : out bit);
end mux8vet;

architecture estrut of mux8vet is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  component mux4 is
    port(A,B,C,D : in  bit; S0,S1 : in  bit; Z : out bit);
  end component mux4;

  signal p,q,r : bit;
  
begin
  
  Um1: mux4 port map (entr(7),entr(6),entr(5),entr(4),sel(2),sel(1) , p); 
  Um2: mux4 port map (entr(3),entr(2),entr(1),entr(0),sel(2),sel(1) , q);
  Um3: mux2 port map (p, q, sel(0), z);

  -- implemente usando dois mux4 e um mux2

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux2(a,s,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux2 is
  port(a   : in  bit;
       s   : in  bit;
       z,w : out bit);
end demux2;

architecture estrut of demux2 is 

  component inv is
    port(A : in bit; S : out bit);
  end component inv;

  component and2 is
    port(A,B : in bit; S : out bit);
  end component and2;

signal r : bit;  

begin

    Ui:  inv port map(s, r);
    Ua0: and2 port map(a, r, z);
    Ua1: and2 port map(a, s, w);

  -- implemente com portas logicas

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux4(a,s0,s1,x,y,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux4 is
  port(a       : in  bit;
       s0,s1   : in  bit;
       x,y,z,w : out bit);
end demux4;

architecture estrut of demux4 is

  component inv is
    port(A : in bit; S : out bit);
  end component inv;

  component and2 is
    port(A,B : in bit; S : out bit);
  end component and2;

  component demux2 is
    port(A,S : in bit; Z,W : out bit);
  end component demux2;

signal p,q,r : bit;

begin
  
    Ui:  inv   port map(s1, r);
    Ud: demux2 port map (a, s0, p, q);
    Ua0: and2  port map(p, r, x);
    Ua1: and2  port map(p, s1, y);
    Ua2: and2  port map(q, r, z);
    Ua3: and2  port map(q, s1, w);
  -- implemente com um demux2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux8(a,s0,s1,s2,p,q,r,s,t,u,v,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux8 is
  port(a               : in  bit;
       s0,s1,s2        : in  bit;
       p,q,r,s,t,u,v,w : out bit);
end demux8;

architecture estrut of demux8 is

  component inv is
    port(A : in bit; S : out bit);
  end component inv;

  component and2 is
    port(A,B : in bit; S : out bit);
  end component and2;

  component demux2 is
    port(A,S : in bit; Z,W : out bit);
  end component demux2;

signal b,c,d,e,f,g,h,i : bit;

begin

    Ui1:  inv     port map(s1, d);
    Ui2:  inv     port map(s2, i);
    Ud:   demux2  port map(a, s0, b, c);
    Ua0:  and2    port map(b, s1, e);
    Ua1:  and2    port map(b, d, f);
    Ua2:  and2    port map(c, s1, g);
    Ua3:  and2    port map(c, d, h);
    Ua4:  and2    port map(s2, e, p);
    Ua5:  and2    port map( e, i, q);
    Ua6:  and2    port map( f, s2, r);
    Ua7:  and2    port map( f, i, s);
    Ua8:  and2    port map( g, s2, t);
    Ua9:  and2    port map( g, i, u);
    Ua10: and2    port map( h, s2, v);
    Ua11: and2    port map( h, i, w);
  -- implemente com um demux2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod2(s,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod2 is
  port(s   : in  bit;
       z,w : out bit);
end decod2;

architecture estrut of decod2 is 

  component inv is
    port(A : in bit; S : out bit);
  end component inv;

  component and2 is
    port(A,B : in bit; S : out bit);
  end component and2;

signal r : bit;

begin

    Ui:  inv  port map(r, z);
    Ua0: and2 port map(s, s, r);
    Ua1: and2 port map(s, s, w);

  -- implemente com portas logicas

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod4(s0,s1,x,y,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod4 is
  port(s0,s1   : in  bit;
       x,y,z,w : out bit);
end decod4;

architecture estrut of decod4 is

  component inv is
    port(A : in bit; S : out bit);
  end component inv;

  component and2 is
    port(A,B : in bit; S : out bit);
  end component and2;

  component decod2 is
    port(S : in bit; Z,W : out bit);
  end component decod2;  

signal a,b,c,d,e : bit;

begin

    Ui:  inv    port map(s1, a);
    Ud0: decod2 port map(s0, b, c);
    Ud1: decod2 port map(s0, d, e);
    Ua0: and2 port map(b, a, x);
    Ua1: and2 port map(c, a, y);
    Ua2: and2 port map(d, s1, z);
    Ua3: and2 port map(e, s1, w);

  -- implemente com decod2 e circuito(s) visto(s) nesta aula


end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod8(s0,s1,s2,p,q,r,s,t,u,v,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod8 is
  port(s0,s1,s2        : in  bit;
       p,q,r,s,t,u,v,w : out bit);
end decod8;

architecture estrut of decod8 is 
begin
  
  -- implemente com decod2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

