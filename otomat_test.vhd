--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:14:28 05/26/2022
-- Design Name:   
-- Module Name:   C:/aaa/otomat_makinesi/otomat_test.vhd
-- Project Name:  otomat_makinesi
-- Target Device:  
-- Tool versions:  
-- Description:   
-- VHDL Test Bench Created by ISE for module: otomat

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY otomat_test IS
END otomat_test;
 
ARCHITECTURE behavior OF otomat_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT otomat
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         para_giris : IN  std_logic;
         eklenen_para : IN  std_logic_vector(4 downto 0);
         urun_verildi : OUT  std_logic;
			para_ustu_verildi : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal para_giris : std_logic := '0';
   signal eklenen_para : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal urun_verildi : std_logic;
	signal para_ustu_verildi : std_logic;
   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: otomat PORT MAP (
          clk => clk,
          rst => rst,
          para_giris => para_giris,
          eklenen_para => eklenen_para,
          urun_verildi => urun_verildi
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	rst <= '1';
	para_giris <= '0';
	eklenen_para <= "00000";	
      -- hold reset state for 100 ns.
      wait for 100 ns;	
	rst <= '0';
      wait for clk_period*2;
		
		-- 1. IHTIMAL
		
		para_giris <= '1';
		eklenen_para <= "00001";
		wait for clk_period;
		eklenen_para <= "00101";
		wait for clk_period;
		eklenen_para <= "01010";
		wait for clk_period;
		para_giris <= '0';
		wait for clk_period*15;
		
		
		

      -- 2. IHTIMAL 
				para_giris <= '1';
		eklenen_para <= "00001";
		wait for clk_period;
		eklenen_para <= "00001";
		wait for clk_period;
		eklenen_para <= "00101";
		wait for clk_period;
		para_giris <= '0';
		wait for clk_period*15;

      wait;
   end process;

END;
