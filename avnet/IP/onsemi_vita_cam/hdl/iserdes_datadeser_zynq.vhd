-- *********************************************************************
-- Copyright 2011, ON Semiconductor Corporation.
--
-- This software is owned by ON Semiconductor Corporation (ON)
-- and is protected by United States copyright laws and international
-- treaty provisions.  Therefore, you must treat this software like any
-- other copyrighted material (e.g., book, or musical recording), with
-- the exception that one copy may be made for personal use or
-- evaluation.  Reproduction, modification, translation, compilation, or
-- representation of this software in any other form (e.g., paper,
-- magnetic, optical, silicon, etc.) is prohibited without the express
-- written permission of ON.
--
-- Disclaimer: ON makes no warranty of any kind, express or
-- implied, with regard to this material, including, but not limited to,
-- the implied warranties of merchantability and fitness for a particular
-- purpose. ON reserves the right to make changes without further
-- notice to the materials described herein. ON does not assume any
-- liability arising out of the application or use of any product or
-- circuit described herein. ON's products described herein are not
-- authorized for use as components in life-support devices.
--
-- This software is protected by and subject to worldwide patent
-- coverage, including U.S. and foreign patents. Use may be limited by
-- and subject to the ON Software License Agreement.
--
-- *********************************************************************
-- File           : $URL: http://whatever.euro.cypress.com/repos/ff_te/VHDL/LIB/modules/Iserdes/trunk/iserdes_datadeser.vhd $
-- Author         : $Author: bert.dewil $
-- Department     : CISP
-- Date           : $Date: 2011-04-18 15:53:21 +0200 (ma, 18 apr 2011) $
-- Revision       : $Revision: 906 $
-- *********************************************************************
-- Description
--
-- *********************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

library work;
use work.all;

--xilinx:
---------
-- synopsys translate_off
Library XilinxCoreLib;
library unisim;
use unisim.vcomponents.all;
-- synopsys translate_on
-----------------------
-- ENTITY DEFINITION --
-----------------------
entity iserdes_datadeser_zynq is
    generic
    (
        NROF_CONN : integer; --16 bits
        DATAWIDTH : integer; -- can be 4, 6, 8 or 10 for DDR, can be 2, 3, 4, 5, 6, 7, or 8 for SDR.
        RETRY_MAX : integer; --16 bits, global
        STABLE_COUNT : integer; -- x bits,
        TAP_COUNT_MAX : integer;
        DATA_RATE : string := "DDR"; -- DDR/SDR
        DIFF_TERM : boolean := TRUE;
        USE_FIFO : boolean := FALSE;
        USE_BLOCKRAMFIFO : boolean := TRUE;
        INVERT_OUTPUT : boolean := FALSE;
        INVERSE_BITORDER : boolean := FALSE;
        C_FAMILY : string := "virtex6"
    );
    port
    (
        CLOCK : in std_logic;
        RESET : in std_logic;

        --serdes clocks, from clocking module(s)
        CLK : in std_logic_vector(NROF_CONN - 1 downto 0);
        CLKb : in std_logic_vector(NROF_CONN - 1 downto 0);

        CLKDIV : in std_logic_vector(NROF_CONN - 1 downto 0); -- parallel clock, derived from CLK using DCM/PLL or BUFR

        --serdes data, directly connected to bondpads
        SDATAP : in std_logic_vector(NROF_CONN - 1 downto 0);
        SDATAN : in std_logic_vector(NROF_CONN - 1 downto 0);

        -- status info
        EDGE_DETECT : out std_logic_vector(NROF_CONN - 1 downto 0);
        TRAINING_DETECT : out std_logic_vector(NROF_CONN - 1 downto 0);
        STABLE_DETECT : out std_logic_vector(NROF_CONN - 1 downto 0);
        FIRST_EDGE_FOUND : out std_logic_vector(NROF_CONN - 1 downto 0);
        SECOND_EDGE_FOUND : out std_logic_vector(NROF_CONN - 1 downto 0);
        NROF_RETRIES : out std_logic_vector((16 * NROF_CONN) - 1 downto 0);
        TAP_SETTING : out std_logic_vector((10 * NROF_CONN) - 1 downto 0);
        WINDOW_WIDTH : out std_logic_vector((10 * NROF_CONN) - 1 downto 0);
        WORD_ALIGN : out std_logic_vector(NROF_CONN - 1 downto 0);
        TIMEOUTONACK : out std_logic_vector(NROF_CONN - 1 downto 0);

        CLK_DIV_RESET : in std_logic;

        -- control
        --sync to clock
        ALIGN_START : in std_logic;
        ALIGN_BUSY : out std_logic_vector(NROF_CONN - 1 downto 0);
        ALIGNED : out std_logic_vector(NROF_CONN - 1 downto 0);

        SAMPLEINFIRSTBIT : out std_logic_vector(NROF_CONN - 1 downto 0);
        SAMPLEINLASTBIT : out std_logic_vector(NROF_CONN - 1 downto 0);
        SAMPLEINOTHERBIT : out std_logic_vector(NROF_CONN - 1 downto 0);

        AUTOALIGN : in std_logic;

        TRAINING : in std_logic_vector(DATAWIDTH - 1 downto 0);
        MANUAL_TAP : in std_logic_vector(9 downto 0);

        --sync to clockdiv
        FIFO_WREN : in std_logic_vector(NROF_CONN - 1 downto 0);
        DELAY_WREN : in std_logic_vector(NROF_CONN - 1 downto 0);

        -- parallel data out
        FIFO_RDEN : in std_logic;
        FIFO_EMPTY : out std_logic_vector(NROF_CONN - 1 downto 0);
        FIFO_DATAOUT : out std_logic_vector((NROF_CONN * DATAWIDTH) - 1 downto 0)
    );

end iserdes_datadeser_zynq;

architecture structure of iserdes_datadeser_zynq is

    component iserdes_control
        generic
        (
            NROF_CONN : integer; --16 bits
            DATAWIDTH : integer;
            RETRY_MAX : integer; --16 bits, global
            STABLE_COUNT : integer; -- x bits,
            TAP_COUNT_MAX : integer;
            INVERSE_BITORDER : boolean := FALSE
        );
        port
        (
            CLOCK : in std_logic;
            RESET : in std_logic;

            ALIGN_START : in std_logic;
            ALIGN_BUSY : out std_logic;
            ALIGNED : out std_logic;

            AUTOALIGN : in std_logic; --when 0 use manual tap setting as an override for the bitalign/wordalign
            --when 1

            TRAINING : in std_logic_vector(DATAWIDTH - 1 downto 0);
            MANUAL_TAP : in std_logic_vector(9 downto 0);

            -- status info
            EDGE_DETECT : out std_logic_vector(NROF_CONN - 1 downto 0);
            TRAINING_DETECT : out std_logic_vector(NROF_CONN - 1 downto 0);
            STABLE_DETECT : out std_logic_vector(NROF_CONN - 1 downto 0);
            FIRST_EDGE_FOUND : out std_logic_vector(NROF_CONN - 1 downto 0);
            SECOND_EDGE_FOUND : out std_logic_vector(NROF_CONN - 1 downto 0);
            NROF_RETRIES : out std_logic_vector((16 * NROF_CONN) - 1 downto 0);
            TAP_SETTING : out std_logic_vector((10 * NROF_CONN) - 1 downto 0);
            WINDOW_WIDTH : out std_logic_vector((10 * NROF_CONN) - 1 downto 0);
            WORD_ALIGN : out std_logic_vector(NROF_CONN - 1 downto 0);
            TIMEOUTONACK : out std_logic_vector(NROF_CONN - 1 downto 0);

            -- to sync
            REQ : out std_logic;
            ACK : in std_logic;

            CTRL_SEL : out std_logic_vector(15 downto 0);

            CTRL_RESET : out std_logic;
            CTRL_INC : out std_logic;
            CTRL_CE : out std_logic;

            CTRL_BITSLIP : out std_logic;

            CTRL_SAMPLEINFIRSTBIT : out std_logic_vector(NROF_CONN - 1 downto 0);
            CTRL_SAMPLEINLASTBIT : out std_logic_vector(NROF_CONN - 1 downto 0);
            CTRL_SAMPLEINOTHERBIT : out std_logic_vector(NROF_CONN - 1 downto 0);

            CTRL_DATA : in std_logic_vector(DATAWIDTH - 1 downto 0);

            CTRL_FIFO_RESET : out std_logic
        );

    end component;

    component iserdes_sync
        generic
        (
            DATAWIDTH : integer;
            NROF_CONN : integer
        );
        port
        (
            CLOCK : in std_logic;
            RESET : in std_logic;

            CLK : in std_logic;
            CLKDIV : in std_logic;

            REQ : in std_logic;
            ACK : out std_logic;

            -- to ISERDES

            CLK_DIV_RESET : in std_logic;

            ISERDES_SEL : out std_logic_vector(15 downto 0);

            IODELAY_ISERDES_RESET : out std_logic;
            IODELAY_INC : out std_logic;
            IODELAY_CE : out std_logic;

            ISERDES_BITSLIP : out std_logic;

            ISERDES_DATA : in std_logic_vector(DATAWIDTH - 1 downto 0);

            FIFO_RESET : out std_logic;
            FIFO_WREN : out std_logic_vector(NROF_CONN - 1 downto 0);

            --from control
            CTRL_SEL : in std_logic_vector(15 downto 0);

            CTRL_RESET : in std_logic;
            CTRL_INC : in std_logic;
            CTRL_CE : in std_logic;

            CTRL_BITSLIP : in std_logic;

            CTRL_SAMPLEINFIRSTBIT : in std_logic_vector(NROF_CONN - 1 downto 0);
            CTRL_SAMPLEINLASTBIT : in std_logic_vector(NROF_CONN - 1 downto 0);
            CTRL_SAMPLEINOTHERBIT : in std_logic_vector(NROF_CONN - 1 downto 0);

            CTRL_DATA : out std_logic_vector(DATAWIDTH - 1 downto 0);

            CTRL_FIFO_RESET : in std_logic;

            --from compare
            CTRL_FIFO_WREN : in std_logic;
            CTRL_DELAY_WREN : in std_logic
        );

    end component;

    component iserdes_core_zynq
        generic
        (
            DATAWIDTH : integer := 10; -- can be 4, 6, 8 or 10 for DDR, can be 2, 3, 4, 5, 6, 7, or 8 for SDR.
            DATA_RATE : string := "DDR"; -- DDR/SDR
            DIFF_TERM : boolean := TRUE;
            USE_FIFO : boolean := FALSE;
            USE_BLOCKRAMFIFO : boolean := TRUE;
            INVERT_OUTPUT : boolean := FALSE;
            INVERSE_BITORDER : boolean := FALSE;
            C_FAMILY : string := "virtex6"
        );
        port
        (
            CLOCK : in std_logic; --system clock, sync to local clock
            RESET : in std_logic;

            -- Data IO
            -- clk src can be internal or external
            CLK : in std_logic; -- high speed serial clock, either internal/external source,
            CLKb : in std_logic; -- can come from DCM/PLL, IBUF, BUFIO

            CLKDIV : in std_logic; -- parallel clock, derived from CLK using DCM/PLL or BUFR
            -- can be same as clock/appclock in synchronous systems

            -- differential data input -> from outside, necesarry buffer is present in this file
            SDATAP : in std_logic;
            SDATAN : in std_logic;

            --Ctrl IO, all controls should run on CLKDIV/parallelclk
            IODELAY_ISERDES_RESET : in std_logic;

            -- iodelay control
            IODELAY_INC : in std_logic;
            IODELAY_CE : in std_logic;

            -- iserdes_nodelay control
            ISERDES_BITSLIP : in std_logic;
            ISERDES_DATAOUT : out std_logic_vector(DATAWIDTH - 1 downto 0); --iserdes data, sync to clkdiv. can be used when fifo is not used

            -- fifo control
            FIFO_RESET : in std_logic;
            --write side, sync to clkdiv
            FIFO_WREN : in std_logic;
            --readside
            FIFO_RDEN : in std_logic;
            FIFO_EMPTY : out std_logic;
            FIFO_DATAOUT : out std_logic_vector(DATAWIDTH - 1 downto 0)
        );

    end component;

    component iserdes_mux
        generic
        (
            DATAWIDTH : integer;
            NROF_CONN : integer
        );
        port
        (
            CLOCK : in std_logic;
            RESET : in std_logic;

            CLKDIV : in std_logic;

            -- select comes from the bitalign/wordalign statemachine and is aligned to CLOCK
            SEL : in std_logic_vector(15 downto 0);
            -- from/to ISERDES
            IODELAY_ISERDES_RESET : out std_logic_vector(NROF_CONN - 1 downto 0);
            IODELAY_INC : out std_logic_vector(NROF_CONN - 1 downto 0);
            IODELAY_CE : out std_logic_vector(NROF_CONN - 1 downto 0);

            ISERDES_BITSLIP : out std_logic_vector(NROF_CONN - 1 downto 0);

            ISERDES_DATA : in std_logic_vector((DATAWIDTH * NROF_CONN) - 1 downto 0);
            -- made as a one dimensional array, multidimensional arrays parameterisable with generics do not exist in VHDL
            --from/to sync

            SYNC_RESET : in std_logic;
            SYNC_INC : in std_logic;
            SYNC_CE : in std_logic;

            SYNC_BITSLIP : in std_logic;

            SYNC_DATA : out std_logic_vector(DATAWIDTH - 1 downto 0)

        );

    end component;

    --signals

    signal REQ : std_logic_vector(NROF_CONN - 1 downto 0);
    signal ACK : std_logic_vector(NROF_CONN - 1 downto 0);

    signal CTRL_SEL : std_logic_vector((16 * NROF_CONN)-1 downto 0);
    signal CTRL_RESET : std_logic_vector(NROF_CONN - 1 downto 0);
    signal CTRL_INC : std_logic_vector(NROF_CONN - 1 downto 0);
    signal CTRL_CE : std_logic_vector(NROF_CONN - 1 downto 0);

    signal CTRL_BITSLIP : std_logic_vector(NROF_CONN - 1 downto 0);

    signal CTRL_DATA : std_logic_vector((NROF_CONN * DATAWIDTH) - 1 downto 0);

    signal CTRL_FIFO_RESET : std_logic_vector(NROF_CONN - 1 downto 0);

    signal SEL : std_logic_vector((16 * NROF_CONN) - 1 downto 0);

    signal SYNC_RESET : std_logic_vector(NROF_CONN - 1 downto 0);
    signal SYNC_INC : std_logic_vector(NROF_CONN - 1 downto 0);
    signal SYNC_CE : std_logic_vector(NROF_CONN - 1 downto 0);

    signal SYNC_BITSLIP : std_logic_vector(NROF_CONN - 1 downto 0);

    signal SYNC_DATA : std_logic_vector((DATAWIDTH * NROF_CONN) - 1 downto 0);

    signal IODELAY_ISERDES_RESET : std_logic_vector(NROF_CONN - 1 downto 0);
    signal IODELAY_INC : std_logic_vector(NROF_CONN - 1 downto 0);
    signal IODELAY_CE : std_logic_vector(NROF_CONN - 1 downto 0);

    signal ISERDES_BITSLIP : std_logic_vector(NROF_CONN - 1 downto 0);

    signal ISERDES_DATA : std_logic_vector((DATAWIDTH * NROF_CONN) - 1 downto 0);

    --signal fifo_empty_i : std_logic_vector(NROF_CONN - 1 downto 0);

    signal FIFO_RESET : std_logic_vector(NROF_CONN - 1 downto 0);
    signal FIFO_WREN_SYNC : std_logic_vector(NROF_CONN - 1 downto 0);

    signal CTRL_SAMPLEINFIRSTBIT : std_logic_vector(NROF_CONN - 1 downto 0);
    signal CTRL_SAMPLEINLASTBIT : std_logic_vector(NROF_CONN - 1 downto 0);
    signal CTRL_SAMPLEINOTHERBIT : std_logic_vector(NROF_CONN - 1 downto 0);

begin

    SAMPLEINFIRSTBIT <= CTRL_SAMPLEINFIRSTBIT;
    SAMPLEINLASTBIT <= CTRL_SAMPLEINLASTBIT;
    SAMPLEINOTHERBIT <= CTRL_SAMPLEINOTHERBIT;

iogen : for i in 0 to (NROF_CONN - 1) generate
    io : iserdes_control
    generic map
    (
        NROF_CONN => 1,
        DATAWIDTH => DATAWIDTH,
        RETRY_MAX => RETRY_MAX,
        STABLE_COUNT => STABLE_COUNT,
        TAP_COUNT_MAX => TAP_COUNT_MAX,
        INVERSE_BITORDER => INVERSE_BITORDER
    )
    port map
    (
        CLOCK => CLOCK,
        RESET => RESET,

        ALIGN_START => ALIGN_START,
        ALIGN_BUSY => ALIGN_BUSY(i),
        ALIGNED => ALIGNED(i),

        AUTOALIGN => AUTOALIGN,

        TRAINING => TRAINING,
        MANUAL_TAP => MANUAL_TAP,

        -- status info
        EDGE_DETECT => EDGE_DETECT(i downto i),
        TRAINING_DETECT => TRAINING_DETECT(i downto i),
        STABLE_DETECT => STABLE_DETECT(i downto i),
        FIRST_EDGE_FOUND => FIRST_EDGE_FOUND(i downto i),
        SECOND_EDGE_FOUND => SECOND_EDGE_FOUND(i downto i),
        NROF_RETRIES => NROF_RETRIES((i + 1) * 16 - 1 downto i * 16),
        TAP_SETTING => TAP_SETTING((i + 1) * 10 - 1 downto i * 10),
        WINDOW_WIDTH => WINDOW_WIDTH((i + 1) * 10 - 1 downto i * 10),
        WORD_ALIGN => WORD_ALIGN(i downto i),
        TIMEOUTONACK => TIMEOUTONACK(i downto i),

        -- to sync
        REQ => REQ(i),
        ACK => ACK(i),

        CTRL_SEL => CTRL_SEL((i + 1) * 16 - 1 downto i * 16),

        CTRL_RESET => CTRL_RESET(i),
        CTRL_INC => CTRL_INC(i),
        CTRL_CE => CTRL_CE(i),

        CTRL_BITSLIP => CTRL_BITSLIP(i),

        CTRL_SAMPLEINFIRSTBIT => CTRL_SAMPLEINFIRSTBIT(i downto i),
        CTRL_SAMPLEINLASTBIT => CTRL_SAMPLEINLASTBIT(i downto i),
        CTRL_SAMPLEINOTHERBIT => CTRL_SAMPLEINOTHERBIT(i downto i),

        CTRL_DATA => CTRL_DATA((i + 1) * DATAWIDTH - 1 downto i * DATAWIDTH),

        CTRL_FIFO_RESET => CTRL_FIFO_RESET(i)
    );
end generate;

ssgen : for i in 0 to (NROF_CONN - 1) generate
    ss : iserdes_sync
    generic map
    (
        DATAWIDTH => DATAWIDTH,
        NROF_CONN => 1
    )
    port map
    (
        CLOCK => CLOCK,
        RESET => RESET,

        CLK => CLK(i),
        CLKDIV => CLKDIV(i),

        REQ => REQ(i),
        ACK => ACK(i),

        CLK_DIV_RESET => CLK_DIV_RESET,

        -- to ISERDES mux
        ISERDES_SEL => SEL((i + 1) * 16 - 1 downto i * 16),

        IODELAY_ISERDES_RESET => SYNC_RESET(i),
        IODELAY_INC => SYNC_INC(i),
        IODELAY_CE => SYNC_CE(i),

        ISERDES_BITSLIP => SYNC_BITSLIP(i),

        ISERDES_DATA => SYNC_DATA((i + 1) * DATAWIDTH - 1 downto i * DATAWIDTH),

        FIFO_RESET => FIFO_RESET(i),
        FIFO_WREN => FIFO_WREN_SYNC(i downto i),

        --from control

        CTRL_SEL => CTRL_SEL((i + 1) * 16 - 1 downto i * 16),

        CTRL_RESET => CTRL_RESET(i),
        CTRL_INC => CTRL_INC(i),
        CTRL_CE => CTRL_CE(i),

        CTRL_SAMPLEINFIRSTBIT => CTRL_SAMPLEINFIRSTBIT(i downto i),
        CTRL_SAMPLEINLASTBIT => CTRL_SAMPLEINLASTBIT(i downto i),
        CTRL_SAMPLEINOTHERBIT => CTRL_SAMPLEINOTHERBIT(i downto i),

        CTRL_BITSLIP => CTRL_BITSLIP(i),

        CTRL_DATA => CTRL_DATA((i + 1) * DATAWIDTH - 1 downto i * DATAWIDTH),

        CTRL_FIFO_RESET => CTRL_FIFO_RESET(i),

        CTRL_DELAY_WREN => DELAY_WREN(i),
        CTRL_FIFO_WREN => FIFO_WREN(i)

    );
end generate;

imgen : for i in 0 to (NROF_CONN - 1) generate
    im : iserdes_mux
    generic map
    (
        DATAWIDTH => DATAWIDTH,
        NROF_CONN => 1
    )
    port map
    (
        CLOCK => CLOCK,
        RESET => RESET,

        CLKDIV => CLKDIV(i),

        -- select comes from the bitalign/wordalign statemachine and is aligned to CLOCK
        SEL => SEL((i + 1) * 16 - 1 downto i * 16),

        -- from/to ISERDES
        IODELAY_ISERDES_RESET => IODELAY_ISERDES_RESET(i downto i),
        IODELAY_INC => IODELAY_INC(i downto i),
        IODELAY_CE => IODELAY_CE(i downto i),

        ISERDES_BITSLIP => ISERDES_BITSLIP(i downto i),

        ISERDES_DATA => ISERDES_DATA((i + 1) * DATAWIDTH - 1 downto i * DATAWIDTH),

        --from/to sync
        SYNC_RESET => SYNC_RESET(i),
        SYNC_INC => SYNC_INC(i),
        SYNC_CE => SYNC_CE(i),

        SYNC_BITSLIP => SYNC_BITSLIP(i),

        SYNC_DATA => SYNC_DATA((i + 1) * DATAWIDTH - 1 downto i * DATAWIDTH)

    );
end generate;

    --process (fifo_empty_i)
    --    variable TMP : std_logic;
    --begin
    --    TMP := '0';
    --    for I in fifo_empty_i'low to fifo_empty_i'high loop
    --        TMP := TMP or fifo_empty_i(0);
    --    end loop;
    --    FIFO_EMPTY <= TMP;
    --end process;

    icgen : for i in 0 to (NROF_CONN - 1) generate
        ic : iserdes_core_zynq
        generic map
        (
            DATAWIDTH => DATAWIDTH,
            DATA_RATE => DATA_RATE,
            DIFF_TERM => DIFF_TERM,
            USE_FIFO => USE_FIFO,
            USE_BLOCKRAMFIFO => USE_BLOCKRAMFIFO,
            INVERT_OUTPUT => INVERT_OUTPUT,
            INVERSE_BITORDER => INVERSE_BITORDER,
            C_FAMILY => C_FAMILY
        )
        port map
        (
            CLOCK => CLOCK,
            RESET => RESET,

            -- Data IO
            -- clk src can be internal or external
            CLK => CLK(i),
            CLKb => CLKb(i),

            CLKDIV => CLKDIV(i),
            -- differential data input -> from outside, necesarry buffer is present in this file
            SDATAP => SDATAP(i),
            SDATAN => SDATAN(i),

            --Ctrl IO, all controls should run on CLKDIV/parallelclk
            IODELAY_ISERDES_RESET => IODELAY_ISERDES_RESET(i),

            -- iodelay control
            IODELAY_INC => IODELAY_INC(i),
            IODELAY_CE => IODELAY_CE(i),

            -- iserdes_nodelay control
            ISERDES_BITSLIP => ISERDES_BITSLIP(i),
            ISERDES_DATAOUT => ISERDES_DATA(((i + 1) * DATAWIDTH) - 1 downto i * DATAWIDTH),

            -- fifo control
            FIFO_RESET => FIFO_RESET(i),
            --write side, sync to clkdiv
            FIFO_WREN => FIFO_WREN_SYNC(i),
            --readside
            FIFO_RDEN => FIFO_RDEN,
            FIFO_EMPTY => FIFO_EMPTY(i), --temporary
            FIFO_DATAOUT => FIFO_DATAOUT(((i + 1) * DATAWIDTH) - 1 downto i * DATAWIDTH)
        );

    end generate;

end structure;
