----------------------------------------------------------------------------------
-- Company: DPU
-- Engineer: Necati Üstün 201813172017
-- Project Name: Otomat makinesi
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

----------------------------------------------------------------------------------

entity otomat is

port(

clk : in std_logic;
rst : in std_logic;
para_giris : in std_logic;
eklenen_para : in std_logic_vector(4 downto 0);
urun_verildi : out std_logic;
para_ustu_verildi : out std_logic

);

end otomat;
----------------------------------------------------------------------------------

 architecture Behavioral of otomat is

 type state_type is (IDLE, PARA_GIRISI, P_URUN_VERILDI, PARA_USTU);
 signal state : state_type;

 signal toplam_para : std_logic_vector(4 downto 0);
 signal fiyat : std_logic_vector(4 downto 0);
 signal eksik_para_verildi : std_logic;
 

 begin
 fiyat <= "01010";
 process(clk,rst)
 begin

 if(rst = '1') then
 toplam_para <= (others => '0');
 eksik_para_verildi <= '0';
 urun_verildi <= '0';
 para_ustu_verildi <= '0';
 state <= IDLE;

 elsif(rising_edge(clk)) then

 case state is
 when IDLE => 
 toplam_para <= (others => '0');
 urun_verildi <= '0';
 eksik_para_verildi <= '0';
 para_ustu_verildi <= '0';

 if (para_giris = '1') then
 state <= PARA_GIRISI;
 toplam_para <= toplam_para + eklenen_para;

 else

 state <= IDLE;
 end if; 

 when PARA_GIRISI =>

 if(para_giris = '1') then

 toplam_para <= toplam_para + eklenen_para;
 state <= PARA_GIRISI;
 else

 if(toplam_para >= fiyat) then
 
 state <= P_URUN_VERILDI;
 urun_verildi <= '1';
 else
 eksik_para_verildi <= '1';
 state <= PARA_USTU;

 end if;
 end if;

 when P_URUN_VERILDI =>
 state <= PARA_USTU;

 When PARA_USTU =>
 eksik_para_verildi <= '0';
 urun_verildi <= '0';
 if(toplam_para /="00000") then
 toplam_para <= toplam_para - "00001";
 state <= PARA_USTU; 
 para_ustu_verildi <= '1'; 
 else

 state <= IDLE;
 para_ustu_verildi <= '0';
 end if;

 when others =>
 toplam_para <= (others => '0');
 eksik_para_verildi <= '0';
 urun_verildi <= '0';
 para_ustu_verildi <= '0';
 state <= IDLE;

 end case;
 end if;

 end process; 

 end Behavioral;





