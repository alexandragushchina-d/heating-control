library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity heizung is
	port (
          TEMP        : in signed(15 downto 0);  -- signed temperature value
          CLK, NOTAUS : in std_logic;
          P1, P2      : out std_logic
       );
 end entity;

architecture heizung_arch of heizung is
signal s_p1 : std_logic := '0';  -- signal saves the previous state of p1
signal s_p2 : std_logic := '0';
signal s_t  : std_logic := '0';  -- signal defines the counter of seconds quantity
signal tmp : signed(7 downto 0) := "00000000";

begin
  P1 <= s_p1;
  P2 <= s_p2;
  tmp <= TEMP srl 8;  -- 8-bit-shift to the right

  process(CLK, NOTAUS)
  begin
    if NOTAUS = '1' then
      s_p1 <= '0';
      s_p2 <= '0';
      s_t <= '0';

    elsif rising_edge(CLK) then
      if s_p1 = '0' and s_p2 = '0' and s_t = '0' then
        if tmp < 18 then
          s_p1 <= '1';
          s_p2 <= '1';
        elsif tmp < 20 then
          s_p1 <= '1';
        end if;

      elsif s_p1 = '1' and s_p2 = '0' and s_t = '0' then
        if tmp < 18 then
          s_p2 <= '1';
        else
          s_t <= '1';
        end if;

      elsif s_p1 = '1' and s_p2 = '0' and s_t = '1' then
        if tmp < 18 then
          s_p2 <= '1';
          s_t <= '0';
        elsif tmp >= 20 then
          s_p1 <= '0';
          s_t <= '0';
        end if;

      elsif s_p1 = '1' and s_p2 = '1' and s_t = '0' then
        s_t <= '1';

      elsif s_p1 = '1' and s_p2 = '1' and s_t = '1' then
        if tmp >= 20 then
          s_p1 <= '0';
          s_p2 <= '0';
          s_t <= '0';
        end if;
      end if;
    end if;
  end process;
end heizung_arch;

