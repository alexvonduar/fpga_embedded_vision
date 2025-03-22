-- *********************************************************************
-- Copyright 2008, Cypress Semiconductor Corporation.
--
-- This software is owned by Cypress Semiconductor Corporation (Cypress)
-- and is protected by United States copyright laws and international
-- treaty provisions.  Therefore, you must treat this software like any
-- other copyrighted material (e.g., book, or musical recording), with
-- the exception that one copy may be made for personal use or
-- evaluation.  Reproduction, modification, translation, compilation, or
-- representation of this software in any other form (e.g., paper,
-- magnetic, optical, silicon, etc.) is prohibited without the express
-- written permission of Cypress.
--
-- Disclaimer: Cypress makes no warranty of any kind, express or
-- implied, with regard to this material, including, but not limited to,
-- the implied warranties of merchantability and fitness for a particular
-- purpose. Cypress reserves the right to make changes without further
-- notice to the materials described herein. Cypress does not assume any
-- liability arising out of the application or use of any product or
-- circuit described herein. Cypress' products described herein are not
-- authorized for use as components in life-support devices.
--
-- This software is protected by and subject to worldwide patent
-- coverage, including U.S. and foreign patents. Use may be limited by
-- and subject to the Cypress Software License Agreement.
--
-- *********************************************************************
-- Author         : $Author: gert.rijckbosch $ @ cypress.com
-- Department     : MPD_BE
-- Date           : $Date: 2011-05-13 10:06:42 +0200 (vr, 13 mei 2011) $
-- Revision       : $Revision: 943 $
-- *********************************************************************
-- Description
--
-- *********************************************************************

-------------------
-- LIBRARY USAGE --
-------------------
--common:
---------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

--xilinx:
---------
--Library XilinxCoreLib;
library unisim;
use unisim.vcomponents.all;

-----------------------
-- ENTITY DEFINITION --
-----------------------
entity iserdes_clocks_zynq is
    generic
    (
        SIMULATION : integer := 0;
        DATAWIDTH : integer := 10; -- can be 4, 6, 8 or 10 for DDR, can be 2, 3, 4, 5, 6, 7, or 8 for SDR.
        DATA_RATE : string := "DDR"; -- DDR/SDR
        CLKSPEED : integer := 50; -- APPCLK speed in MHz. Everything is generated from Appclk to be as sync as possible
        --DATAWIDTH, DATARATE, and clockspeed are used to calculate high speed clk speed.
        --SIM_DEVICE   : string  := "VIRTEX5"; --VIRTEX4/VIRTEX5, for BUFR
        C_FAMILY : string := "virtex5";
        DIFF_TERM : boolean := TRUE;
        USE_INPLL : boolean := TRUE;
        USE_OUTPLL : boolean := TRUE --use output/multiplieng PLL instead of DCM
    );
    port
    (
        CLOCK : in std_logic; --appclock
        RESET : in std_logic; --active high reset

        CLK_RDY : out std_logic; --CLK status (locked)
        CLK_STATUS : out std_logic_vector(15 downto 0); -- extended status
        -- 8 LSBs: transmit clk (if any)
        -- 8 MSBs: receive clk (if any)
        --reset for synchronizer between clk_div and App_clk
        CLK_DIV_RESET : out std_logic;
        -- to iserdes
        CLK : out std_logic;
        CLKb : out std_logic;
        CLKDIV : out std_logic;

        -- from sensor (only used when USED_EXT_CLK = YES)

        HS_IN_CLK : in std_logic;
        HS_IN_CLKb : in std_logic
    );

end iserdes_clocks_zynq;

architecture rtl of iserdes_clocks_zynq is

    -- functions
    function calcoutplldivider (
        DATAWIDTH : integer;
        DATA_RATE : string;
        CLKSPEED : integer
    )
        return integer is
        variable output : integer := 1;
        variable a : integer := 1;
    begin
        a := 1000 / CLKSPEED;

        if (DATA_RATE = "SDR") then
            output := a / DATAWIDTH;
        else
            output := a / (DATAWIDTH/2);
        end if;
        return output;

    end function calcoutplldivider;

    function calcoutpllmultiplier (
        DATAWIDTH : integer;
        DATA_RATE : string;
        CLKSPEED : integer
    )
        return integer is
        variable output : integer := 1;
    begin
        output := 1000 / CLKSPEED;
        if (DATA_RATE = "SDR") then
            output := output / DATAWIDTH;
        else
            output := output / (DATAWIDTH/2);
        end if;

        if (DATA_RATE = "SDR") then
            output := output * DATAWIDTH;
        else
            output := output * (DATAWIDTH/2);
        end if;

        return output;

    end function calcoutpllmultiplier;

    function calcclockmultiplier (
        DATAWIDTH : integer;
        DATA_RATE : string;
        CLKSPEED : integer
    )
        return integer is
        variable output : integer := 0;
    begin
        if (DATA_RATE = "SDR") then
            output := DATAWIDTH;
        else
            output := DATAWIDTH/2;
        end if;

        return output;

    end function calcclockmultiplier;

    function checkBUFRdividable (
        clockmultiplier : integer
    )
        return boolean is
        variable output : boolean := FALSE;
    begin
        if (clockmultiplier = 2 or
            clockmultiplier = 3 or
            clockmultiplier = 4 or
            clockmultiplier = 5 or
            clockmultiplier = 6 or
            clockmultiplier = 7 or
            clockmultiplier = 8) then
            output := TRUE;
        else
            output := FALSE;
        end if;

        return output;
    end function checkBUFRdividable;

    function calcperiod (
        CLKSPEED : integer;
        MULTIPLIER : integer
    )
        return real is
        variable output : real := 0.0;
    begin

        output := 1000.0/real(CLKSPEED * MULTIPLIER);

        return output;

    end function calcperiod;

    function setlocktime (
        USECLKFX : boolean;
        USEPLL : boolean;
        SIMULATION : integer;
        CLKSPEED : integer
    )
        return std_logic_vector is
        variable output : std_logic_vector(23 downto 0) := X"000000";
    begin

        if (SIMULATION > 0) then
            output := X"000080";
        else
            if (USEPLL = TRUE) then --PLL lock time is always 100us
                output := std_logic_vector(to_unsigned((CLKSPEED * 100), 24));
            elsif (USECLKFX = TRUE) then --DFS locktime is always 10ms
                output := std_logic_vector(to_unsigned((CLKSPEED * 10000), 24));
            else --locktime is worst case for 30MHz; 5000us resulting in 150000 clocks
                output := std_logic_vector(to_unsigned(150000, 24));
            end if;
        end if;

        return output;

    end function setlocktime;

    function calcinpllmultiplier(
        CLKSPEED : integer
    )
        return integer is
        variable output : integer := 1;
    begin
        -- PLL frequency needs to be within 400MHz and 1000MHz

        if (CLKSPEED > 500) then
            output := 1;
        elsif (CLKSPEED > 250) then
            output := 2;
        elsif (CLKSPEED > 125) then
            output := 4;
        else
            output := 8;
        end if;

        return output;

    end function calcinpllmultiplier;

    --constants
    constant clockmultiplier : integer := calcclockmultiplier(DATAWIDTH, DATA_RATE, CLKSPEED);
    constant BUFR_dividable : boolean := checkBUFRdividable(clockmultiplier);
    constant inpllmultiplier : integer := calcinpllmultiplier(CLKSPEED * clockmultiplier);
    constant outpllmultiplier : integer := calcoutpllmultiplier(DATAWIDTH, DATA_RATE, CLKSPEED);
    constant outplldivider : integer := calcoutplldivider(DATAWIDTH, DATA_RATE, CLKSPEED);

    constant zero : std_logic := '0';
    constant one : std_logic := '1';
    constant zeros : std_logic_vector(31 downto 0) := X"00000000";
    constant ones : std_logic_vector(31 downto 0) := X"FFFFFFFF";
    constant LockTimeMULT : std_logic_vector(23 downto 0) := setlocktime(TRUE, USE_OUTPLL, SIMULATION, CLKSPEED);
    constant LockTimeDIV : std_logic_vector(23 downto 0) := setlocktime(FALSE, USE_INPLL, SIMULATION, CLKSPEED);
    constant ResetTime : std_logic_vector(23 downto 0) := X"000100";
    --signals
    type lockedmonitorstatetp is (
        Idle,
        AssertReset1,
        WaitLocked1,
        CheckLocked1,
        AssertReset2,
        WaitLocked2,
        CheckLocked2,
        AssertReset3,
        WaitLocked3,
        CheckLocked3
    );

    signal lockedmonitorstate : lockedmonitorstatetp;

    signal Cntr : std_logic_vector(23 downto 0);

    signal dcm_mult_gen : std_logic := '0';
    signal dcm_div_gen : std_logic := '0';

    signal lsoddroutclk : std_logic;

    signal hsinclk : std_logic;
    signal lsinclk : std_logic;

    signal hsoddroutclk : std_logic;

    --signal lsdcmdivclk       : std_logic;
    --signal hsdcmdivclk       : std_logic;

    signal clk_tmp : std_logic;

    signal MULT_CLK0 : std_logic;
    signal MULT_CLK180 : std_logic;
    signal MULT_CLK270 : std_logic;
    signal MULT_CLK2X : std_logic;
    signal MULT_CLK2X180 : std_logic;
    signal MULT_CLK90 : std_logic;
    signal MULT_CLKDV : std_logic;
    signal MULT_CLKFX : std_logic;
    signal MULT_CLKFX180 : std_logic;

    signal MULT_CLKFB : std_logic;
    signal MULT_CLKIN : std_logic;
    signal MULT_RST : std_logic;

    signal DIV_CLK0 : std_logic;
    signal DIV_CLK180 : std_logic;
    signal DIV_CLK270 : std_logic;
    signal DIV_CLK2X : std_logic;
    signal DIV_CLK2X180 : std_logic;
    signal DIV_CLK90 : std_logic;
    signal DIV_CLKDV : std_logic;
    signal DIV_CLKFX : std_logic;
    signal DIV_CLKFX180 : std_logic;
    signal DIV_LOCKED : std_logic;
    signal DIV_CLKFB : std_logic;
    signal DIV_CLKIN : std_logic;
    signal DIV_RST : std_logic;
    signal DIV_DO : std_logic_vector(15 downto 0);
    --only for PLL
    signal DIV_PLLFBI : std_logic;
    signal DIV_PLLFBO : std_logic;

    signal LOCKED : std_logic;

    signal dividable_s : boolean := BUFR_dividable;
    --signal clk_div

    -- lock signals AND'ed with DRP DO(1)
    signal multiplier_lock : std_logic;
    signal divider_lock : std_logic;

    signal divider_lock_r : std_logic;
    signal divider_lock_r2 : std_logic;

    -- output of reset sequencer
    signal multiplier_status : std_logic;
    signal divider_status : std_logic;

    attribute syn_preserve : boolean;
    attribute equivalent_register_removal : string;
    attribute shreg_extract : string;

    attribute equivalent_register_removal of divider_lock_r : signal is "no";
    attribute syn_preserve of divider_lock_r : signal is true;
    attribute shreg_extract of divider_lock_r : signal is "no";

    attribute equivalent_register_removal of divider_lock_r2 : signal is "no";
    attribute syn_preserve of divider_lock_r2 : signal is true;
    attribute shreg_extract of divider_lock_r2 : signal is "no";

begin

    -- DO bit assignment (DCM only)
    -- DO[0]: Phase shift overflow
    -- DO[1]: Clkin stopped
    -- DO[2]: Clkfx stopped
    -- DO[3]: Clkfb stopped

    CLK_STATUS(7) <= '0';
    CLK_STATUS(6) <= multiplier_lock;
    CLK_STATUS(5) <= '1';
    CLK_STATUS(4 downto 1) <= (others => '0');
    CLK_STATUS(0) <= multiplier_status;

    CLK_STATUS(15) <= '0';
    CLK_STATUS(14) <= divider_lock;
    CLK_STATUS(13) <= DIV_LOCKED;
    CLK_STATUS(12 downto 9) <= DIV_DO(3 downto 0);
    CLK_STATUS(8) <= divider_status;

    -- in 'normal' cases only one clock entity will be needed per project

    -- DCM is needed:   1. when a high speed clock out is required, then HS clock is generated internally,
    --                  2. when no high speed clock in is available and it needs to be generated internally
    --                  3. when a high speed clock in needs to be divided
    -- or when a only a low speed clock in is available
    -- in the latter case a clock reconstruction algorithm is required that is applied on the data, which is not supported yet

        multiplier_lock <= '1';

    gen_iserdes_divider : if (BUFR_dividable = FALSE) generate

            mmcm_adv_inst : MMCM_ADV
            generic map
            (
                BANDWIDTH => "OPTIMIZED",
                CLKOUT4_CASCADE => FALSE,
                CLOCK_HOLD => FALSE,
                COMPENSATION => "ZHOLD",
                STARTUP_WAIT => FALSE,
                DIVCLK_DIVIDE => 5,
                CLKFBOUT_MULT_F => 5.0 * real(inpllmultiplier), --this could be wrong for other implementations
                CLKFBOUT_PHASE => 0.000,
                CLKFBOUT_USE_FINE_PS => FALSE,
                CLKOUT0_DIVIDE_F => real(clockmultiplier) * real(inpllmultiplier),
                CLKOUT0_PHASE => 0.000,
                CLKOUT0_DUTY_CYCLE => 0.500,
                CLKOUT0_USE_FINE_PS => FALSE,
                CLKOUT1_DIVIDE => inpllmultiplier,
                CLKOUT1_PHASE => 0.000,
                CLKOUT1_DUTY_CYCLE => 0.500,
                CLKOUT1_USE_FINE_PS => FALSE,
                CLKIN1_PERIOD => calcperiod(CLKSPEED, clockmultiplier),
                REF_JITTER1 => 0.005000,
                CLKIN2_PERIOD => calcperiod(CLKSPEED, clockmultiplier),
                REF_JITTER2 => 0.005000
            )
            port map
            (
                -- Output clocks
                CLKFBOUT => DIV_PLLFBI, -- naming not ideal, matches DCM naming
                CLKFBOUTB => open,
                CLKOUT0 => DIV_CLKDV, -- naming not ideal, matches DCM naming
                CLKOUT0B => open,
                CLKOUT1 => DIV_CLK0,
                CLKOUT1B => open,
                CLKOUT2 => open,
                CLKOUT2B => open,
                CLKOUT3 => open,
                CLKOUT3B => open,
                CLKOUT4 => open,
                CLKOUT5 => open,
                CLKOUT6 => open,
                -- Input clock control
                CLKFBIN => DIV_PLLFBO,
                CLKIN1 => DIV_CLKIN,
                --CLKIN2              => '0',
                CLKIN2 => DIV_CLKIN,
                -- Tied to always select the primary input clock
                CLKINSEL => '1',
                -- Ports for dynamic reconfiguration
                DADDR => (others => '0'),
                DCLK => CLOCK,
                DEN => '0',
                DI => (others => '0'),
                DO => DIV_DO,
                DRDY => open,
                DWE => '0',
                -- Ports for dynamic phase shift
                PSCLK => '0',
                PSEN => '0',
                PSINCDEC => '0',
                PSDONE => open,
                -- Other control and status signals
                LOCKED => DIV_LOCKED,
                CLKINSTOPPED => open,
                CLKFBSTOPPED => open,
                PWRDWN => '0',
                RST => DIV_RST
            );

            DIV_CLKIN <= hsinclk;
            divider_lock <= DIV_LOCKED;
            CLK_DIV_RESET <= not DIV_LOCKED;

            div_PLLfeedback_BUFG_inst : BUFG
            port map
            (
                O => DIV_PLLFBO, -- Clock buffer output
                I => DIV_PLLFBI -- Clock buffer input
            );

        div_feedback_BUFG_inst : BUFG
        port map
        (
            O => DIV_CLKFB, -- Clock buffer output
            I => DIV_CLK0 -- Clock buffer input
        );

        LS_Input_BUFG_inst : BUFG
        port map
        (
            O => lsinclk, -- Clock buffer output
            I => DIV_CLKDV -- Clock buffer input
        );

    end generate gen_iserdes_divider;

    -- connect DCM input to appclock when used as a multiplier
    -- connect DCM input to incoming hsclk when used as a divider

    gen_no_iserdes_divider_DCM : if (BUFR_dividable = TRUE) generate
        DIV_LOCKED <= '1';
        divider_lock <= '1';
        DIV_DO <= (others => '0');
        CLK_DIV_RESET <= RESET; --FIXME should be in reset until a clock is comming from the device find a way to detect this.
    end generate gen_no_iserdes_divider_DCM;

    -- clocks out

    -- clocks in
    -- high speed clock in

        --assume always differential

            IBUFDS_inst : IBUFDS
            generic map
            (
                CAPACITANCE => "DONT_CARE", -- "LOW", "NORMAL", "DONT_CARE" (Virtex-4 only)
                DIFF_TERM => DIFF_TERM, -- Differential Termination (Virtex-4/5, Spartan-3E/3A)
                IBUF_DELAY_VALUE => "0", -- Specify the amount of added input delay for buffer, "0"-"16" (Spartan-3E/3A only)
                IFD_DELAY_VALUE => "AUTO", -- Specify the amount of added delay for input register, "AUTO", "0"-"8" (Spartan-3E/3A only)
                IOSTANDARD => "DEFAULT"
            )
            port map
            (
                O => hsinclk, -- Clock buffer output
                I => HS_IN_CLK, -- Diff_p clock buffer input (connect directly to top-level port)
                IB => HS_IN_CLKb -- Diff_n clock buffer input (connect directly to top-level port)
            );

            -- uses BUFIO because the only clocked instances with this clock are in the IO column
            -- is limited to one clockregion
            BUFIO_regional_hs_clk_in : BUFIO
            port map
            (
                O => clk_tmp, -- Clock buffer output
                I => hsinclk -- Clock buffer input
            );

            CLK <= clk_tmp;
            CLKb <= clk_tmp;

    --low speed clock in

            -- use BUFR if it can divide
            -- multiplier can be 2 or bigger
            gen_multiplier_2 : if (clockmultiplier = 2) generate
                BUFR_regional_hs_clk_in : BUFR
                generic map
                (
                    BUFR_DIVIDE => "2", -- "BYPASS", "1", "2", "3", "4", "5", "6", "7", "8"
                    --SIM_DEVICE  => SIM_DEVICE
                    SIM_DEVICE => "7series"
                )
                port map
                (
                    O => CLKDIV, -- Clock buffer output
                    CE => one,
                    CLR => zero,
                    I => hsinclk -- Clock buffer input
                );
            end generate gen_multiplier_2;

            gen_multiplier_3 : if (clockmultiplier = 3) generate
                BUFR_regional_hs_clk_in : BUFR
                generic map
                (
                    BUFR_DIVIDE => "3", -- "BYPASS", "1", "2", "3", "4", "5", "6", "7", "8"
                    --SIM_DEVICE  => SIM_DEVICE
                    SIM_DEVICE => "7series"
                )
                port map
                (
                    O => CLKDIV, -- Clock buffer output
                    CE => one,
                    CLR => zero,
                    I => hsinclk -- Clock buffer input
                );
            end generate gen_multiplier_3;

            gen_multiplier_4 : if (clockmultiplier = 4) generate
                BUFR_regional_hs_clk_in : BUFR
                generic map
                (
                    BUFR_DIVIDE => "4", -- "BYPASS", "1", "2", "3", "4", "5", "6", "7", "8"
                    --SIM_DEVICE  => SIM_DEVICE
                    SIM_DEVICE => "7series"
                )
                port map
                (
                    O => CLKDIV, -- Clock buffer output
                    CE => one,
                    CLR => zero,
                    I => hsinclk -- Clock buffer input
                );
            end generate gen_multiplier_4;

            gen_multiplier_5 : if (clockmultiplier = 5) generate
                BUFR_regional_hs_clk_in : BUFR
                generic map
                (
                    BUFR_DIVIDE => "5", -- "BYPASS", "1", "2", "3", "4", "5", "6", "7", "8"
                    --SIM_DEVICE  => SIM_DEVICE
                    SIM_DEVICE => "7series"
                )
                port map
                (
                    O => CLKDIV, -- Clock buffer output
                    CE => one,
                    CLR => zero,
                    I => hsinclk -- Clock buffer input
                );
            end generate gen_multiplier_5;

            gen_multiplier_6 : if (clockmultiplier = 6) generate
                BUFR_regional_hs_clk_in : BUFR
                generic map
                (
                    BUFR_DIVIDE => "6", -- "BYPASS", "1", "2", "3", "4", "5", "6", "7", "8"
                    --SIM_DEVICE  => SIM_DEVICE
                    SIM_DEVICE => "7series"
                )
                port map
                (
                    O => CLKDIV, -- Clock buffer output
                    CE => one,
                    CLR => zero,
                    I => hsinclk -- Clock buffer input
                );
            end generate gen_multiplier_6;

            gen_multiplier_7 : if (clockmultiplier = 7) generate
                BUFR_regional_hs_clk_in : BUFR
                generic map
                (
                    BUFR_DIVIDE => "7", -- "BYPASS", "1", "2", "3", "4", "5", "6", "7", "8"
                    --SIM_DEVICE  => SIM_DEVICE
                    SIM_DEVICE => "7series"
                )
                port map
                (
                    O => CLKDIV, -- Clock buffer output
                    CE => one,
                    CLR => zero,
                    I => hsinclk -- Clock buffer input
                );
            end generate gen_multiplier_7;

            gen_multiplier_8 : if (clockmultiplier = 8) generate
                BUFR_regional_hs_clk_in : BUFR
                generic map
                (
                    BUFR_DIVIDE => "8", -- "BYPASS", "1", "2", "3", "4", "5", "6", "7", "8"
                    --SIM_DEVICE  => SIM_DEVICE
                    SIM_DEVICE => "7series"
                )
                port map
                (
                    O => CLKDIV, -- Clock buffer output
                    CE => one,
                    CLR => zero,
                    I => hsinclk -- Clock buffer input
                );
            end generate gen_multiplier_8;

            -- use DCM to divide when BUFR can't
            gen_other_multiplier : if (BUFR_dividable = FALSE) generate
                CLKDIV <= lsinclk;
            end generate gen_other_multiplier;

    -- only divider lock needs to be registered, multiplier lock is generated on same clock domain
    register_process : process (RESET, CLOCK)
    begin
        if (RESET = '1') then

            divider_lock_r <= '0';
            divider_lock_r2 <= '0';

        elsif (CLOCK = '1' and CLOCK'event) then

            divider_lock_r <= divider_lock;
            divider_lock_r2 <= divider_lock_r;

        end if;
    end process register_process;

    locked_monitor_process : process (RESET, CLOCK)
    begin
        if (RESET = '1') then
            MULT_RST <= '1';
            DIV_RST <= '1';

            LOCKED <= '0';

            multiplier_status <= '0';
            divider_status <= '0';

            CLK_RDY <= '0';

            Cntr <= (others => '1');

            lockedmonitorstate <= Idle;

        elsif (CLOCK = '1' and CLOCK'event) then

            LOCKED <= multiplier_status and divider_status;
            CLK_RDY <= LOCKED;

            case lockedmonitorstate is
                when Idle =>
                    Cntr <= ResetTime; --reset should be asserted minimum one CLKDIV cycle
                    if (multiplier_lock = '0') then
                        multiplier_status <= '0';
                        divider_status <= '0';
                        MULT_RST <= '1';
                        DIV_RST <= '1';
                        lockedmonitorstate <= AssertReset1;
                    elsif (divider_lock_r2 = '0') then
                        divider_status <= '0';
                        MULT_RST <= '0';
                        DIV_RST <= '1';
                        lockedmonitorstate <= AssertReset2;
                    else
                        multiplier_status <= '1';
                        divider_status <= '1';
                        MULT_RST <= '0';
                        DIV_RST <= '0';
                    end if;

                when AssertReset1 =>
                    if (Cntr(Cntr'high) = '1') then
                        MULT_RST <= '0';
                        DIV_RST <= '1';
                        Cntr <= LockTimeMULT; --Cntr should be as long as lock time
                        lockedmonitorstate <= WaitLocked1;
                    else
                        Cntr <= Cntr - '1';
                    end if;

                when WaitLocked1 =>
                    if (Cntr(Cntr'high) = '1') then
                        MULT_RST <= '0';
                        DIV_RST <= '1';
                        lockedmonitorstate <= CheckLocked1;
                    else
                        Cntr <= Cntr - '1';
                    end if;

                when CheckLocked1 =>
                    if (multiplier_lock = '1') then
                        multiplier_status <= '1';
                        MULT_RST <= '0';
                        DIV_RST <= '1';
                        Cntr <= ResetTime; --reset should be asserted minimum one CLKDIV cycle
                        lockedmonitorstate <= AssertReset2;
                    else
                        MULT_RST <= '1';
                        DIV_RST <= '1';
                        Cntr <= ResetTime;
                        lockedmonitorstate <= AssertReset1;
                    end if;

                when AssertReset2 =>
                    if (Cntr(Cntr'high) = '1') then
                        MULT_RST <= '0';
                        DIV_RST <= '0';
                        Cntr <= LockTimeDIV; --Cntr should be as long as lock time
                        lockedmonitorstate <= WaitLocked2;
                    else
                        Cntr <= Cntr - '1';
                    end if;

                when WaitLocked2 =>
                    if (Cntr(Cntr'high) = '1') then
                        MULT_RST <= '0';
                        DIV_RST <= '0';
                        lockedmonitorstate <= CheckLocked2;
                    else
                        Cntr <= Cntr - '1';
                    end if;

                when CheckLocked2 =>
                    if (divider_lock_r2 = '1') then
                        --divider_status      <= '1';
                        --lockedmonitorstate  <= Idle;
                        DIV_RST <= '1';
                        Cntr <= ResetTime; --reset should be asserted minimum one CLKDIV cycle
                        lockedmonitorstate <= AssertReset3;
                    else
                        --check whether multiplier DCM did not get out of lock for some reason
                        if (multiplier_lock = '0') then
                            multiplier_status <= '0';
                            MULT_RST <= '1';
                            DIV_RST <= '1';
                            Cntr <= ResetTime;
                            lockedmonitorstate <= AssertReset1;
                        else
                            -- only reset divider DCM again in this state. Otherwise highspeedclock will not be available when no sensor is inserted (debug)
                            MULT_RST <= '0';
                            DIV_RST <= '1';
                            Cntr <= ResetTime;
                            lockedmonitorstate <= AssertReset2;
                        end if;
                    end if;

                    -- code needs to lock twice to avoid power up problems.
                when AssertReset3 =>
                    if (Cntr(Cntr'high) = '1') then
                        MULT_RST <= '0';
                        DIV_RST <= '0';
                        Cntr <= LockTimeDIV; --Cntr should be as long as lock time
                        lockedmonitorstate <= WaitLocked3;
                    else
                        Cntr <= Cntr - '1';
                    end if;

                when WaitLocked3 =>
                    if (Cntr(Cntr'high) = '1') then
                        MULT_RST <= '0';
                        DIV_RST <= '0';
                        lockedmonitorstate <= CheckLocked3;
                    else
                        Cntr <= Cntr - '1';
                    end if;

                when CheckLocked3 =>
                    if (divider_lock_r2 = '1') then
                        divider_status <= '1';
                        lockedmonitorstate <= Idle;
                    else
                        --check whether multiplier DCM did not get out of lock for some reason
                        if (multiplier_lock = '0') then
                            multiplier_status <= '0';
                            MULT_RST <= '1';
                            DIV_RST <= '1';
                            Cntr <= ResetTime;
                            lockedmonitorstate <= AssertReset1;
                        else
                            -- only reset divider DCM again in this state. Otherwise highspeedclock will not be available when no sensor is inserted (debug)
                            MULT_RST <= '0';
                            DIV_RST <= '1';
                            Cntr <= ResetTime;
                            lockedmonitorstate <= AssertReset2;
                        end if;
                    end if;
                when others =>
                    lockedmonitorstate <= Idle;

            end case;

        end if;
    end process locked_monitor_process;

end rtl;
