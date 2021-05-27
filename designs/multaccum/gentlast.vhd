----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- Create Date: 12/07/2020 02:16:23 PM
-- Module Name: gentlast - rtl
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gentlast is
    port (
        clk       : in STD_LOGIC;
        rstn      : in STD_LOGIC;
        i_ready   : in STD_LOGIC;
        i_valid   : in STD_LOGIC;
        i_size_m1 : in STD_LOGIC_VECTOR(15 downto 0);
        o_last    : out STD_LOGIC
    );
end gentlast;


architecture rtl of gentlast is

    signal count : unsigned(15 downto 0);

begin

    proc_count : process(clk, rstn)
    begin
        if rising_edge(clk) then
            if (rstn='0') then
                count <= (others => '0');
            else
                if ((i_ready = '1') and (i_valid = '1')) then
                    if (count < unsigned(i_size_m1)) then
                        count <= count + 1;
                    else
                        count <= (others => '0');
                    end if;
                end if;   
            end if;
        end if;
    end process;
    
    o_last <= '1' when (count = unsigned(i_size_m1)) else '0'; 
    
end rtl;
