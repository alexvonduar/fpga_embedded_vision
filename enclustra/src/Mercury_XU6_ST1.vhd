----------------------------------------------------------------------------------------------------
-- Copyright (c) 2024 by Enclustra GmbH, Switzerland.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this hardware, software, firmware, and associated documentation files (the
-- "Product"), to deal in the Product without restriction, including without
-- limitation the rights to use, copy, modify, merge, publish, distribute,
-- sublicense, and/or sell copies of the Product, and to permit persons to whom the
-- Product is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Product.
--
-- THE PRODUCT IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
-- PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
-- HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
-- OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- PRODUCT OR THE USE OR OTHER DEALINGS IN THE PRODUCT.
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- libraries
----------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;




----------------------------------------------------------------------------------------------------
-- entity declaration
----------------------------------------------------------------------------------------------------
entity Mercury_XU6_ST1 is
  generic (
    INPUT_PORT : string := "mipi0"
  );
  port (

    -- Anios 0
    IO0_D0_P                       : inout   std_logic;
    IO0_D1_N                       : inout   std_logic;
    IO0_D2_P                       : inout   std_logic;
    IO0_D3_N                       : inout   std_logic;
    IO0_D4_P                       : inout   std_logic;
    IO0_D5_N                       : inout   std_logic;
    IO0_D6_P                       : inout   std_logic;
    IO0_D7_N                       : inout   std_logic;
    IO0_D8_P                       : inout   std_logic;
    IO0_D9_N                       : inout   std_logic;
    IO0_D10_P                      : inout   std_logic;
    IO0_D11_N                      : inout   std_logic;
    IO0_D12_P                      : inout   std_logic;
    IO0_D13_N                      : inout   std_logic;
    IO0_D14_P                      : inout   std_logic;
    IO0_D15_N                      : inout   std_logic;
    IO0_D16_P                      : inout   std_logic;
    IO0_D17_N                      : inout   std_logic;
    IO0_D18_P                      : inout   std_logic;
    IO0_D19_N                      : inout   std_logic;
    IO0_D20_P                      : inout   std_logic;
    IO0_D21_N                      : inout   std_logic;
    IO0_D22_P                      : inout   std_logic;
    IO0_D23_N                      : inout   std_logic;
    IO0_CLK_N                      : inout   std_logic;
    IO0_CLK_P                      : inout   std_logic;

    -- Anios 1
    IO1_D0_P                       : inout   std_logic;
    IO1_D1_N                       : inout   std_logic;
    IO1_D2_P                       : inout   std_logic;
    IO1_D3_N                       : inout   std_logic;
    IO1_D4_P                       : inout   std_logic;
    IO1_D5_N                       : inout   std_logic;
    IO1_D6_P                       : inout   std_logic;
    IO1_D7_N                       : inout   std_logic;
    IO1_D8_P                       : inout   std_logic;
    IO1_D9_N                       : inout   std_logic;
    IO1_D10_P                      : inout   std_logic;
    IO1_D11_N                      : inout   std_logic;
    IO1_D12_P                      : inout   std_logic;
    IO1_D13_N                      : inout   std_logic;
    IO1_D14_P                      : inout   std_logic;
    IO1_D15_N                      : inout   std_logic;
    IO1_D16_P                      : inout   std_logic;
    IO1_D17_N                      : inout   std_logic;
    IO1_D18_P                      : inout   std_logic;
    IO1_D19_N                      : inout   std_logic;
    IO1_D20_P                      : inout   std_logic;
    IO1_D21_N                      : inout   std_logic;
    IO1_D22_P                      : inout   std_logic;
    IO1_D23_N                      : inout   std_logic;
    IO1_CLK_N                      : inout   std_logic;
    IO1_CLK_P                      : inout   std_logic;

    -- BUTTONS
    BTN1_N                         : in      std_logic;

    -- Optional reference oscillator
    CLK_REF_N                      : in      std_logic;
    CLK_REF_P                      : in      std_logic;

    -- Clock Generator CLK2
    CLK_REF1_N                     : in      std_logic;
    CLK_REF1_P                     : in      std_logic;

    -- Clock Generator CLK3
    CLK_REF2_N                     : in      std_logic;
    CLK_REF2_P                     : in      std_logic;

    -- Clock Generator CLK0
    CLK_USR_N                      : in      std_logic;
    CLK_USR_P                      : in      std_logic;

    -- Display Port
    DP_HPD                         : in      std_logic;
    DP_AUX_IN                      : in      std_logic;
    DP_AUX_OE                      : out     std_logic;
    DP_AUX_OUT                     : out     std_logic;

    -- FMC HPC Connector
    FMC_HA02_N                     : inout   std_logic;
    FMC_HA02_P                     : inout   std_logic;
    FMC_HA03_N                     : inout   std_logic;
    FMC_HA03_P                     : inout   std_logic;
    FMC_HA04_N                     : inout   std_logic;
    FMC_HA04_P                     : inout   std_logic;
    FMC_HA05_N                     : inout   std_logic;
    FMC_HA05_P                     : inout   std_logic;
    FMC_HA06_N                     : inout   std_logic;
    FMC_HA06_P                     : inout   std_logic;
    FMC_HA07_N                     : inout   std_logic;
    FMC_HA07_P                     : inout   std_logic;
    FMC_HA08_N                     : inout   std_logic;
    FMC_HA08_P                     : inout   std_logic;
    FMC_HA09_N                     : inout   std_logic;
    FMC_HA09_P                     : inout   std_logic;
    FMC_HA10_N                     : inout   std_logic;
    FMC_HA10_P                     : inout   std_logic;
    FMC_HA11_N                     : inout   std_logic;
    FMC_HA11_P                     : inout   std_logic;
    FMC_HA12_N                     : inout   std_logic;
    FMC_HA12_P                     : inout   std_logic;
    FMC_HA13_N                     : inout   std_logic;
    FMC_HA13_P                     : inout   std_logic;
    FMC_HA14_N                     : inout   std_logic;
    FMC_HA14_P                     : inout   std_logic;
    FMC_HA15_N                     : inout   std_logic;
    FMC_HA15_P                     : inout   std_logic;
    FMC_HA16_N                     : inout   std_logic;
    FMC_HA16_P                     : inout   std_logic;
    FMC_LA02_N                     : inout   std_logic;
    FMC_LA02_P                     : inout   std_logic;
    FMC_LA03_N                     : inout   std_logic;
    FMC_LA03_P                     : inout   std_logic;
    FMC_LA04_N                     : inout   std_logic;
    FMC_LA04_P                     : inout   std_logic;
    FMC_LA05_N                     : inout   std_logic;
    FMC_LA05_P                     : inout   std_logic;
    FMC_LA06_N                     : inout   std_logic;
    FMC_LA06_P                     : inout   std_logic;
    FMC_LA07_N                     : inout   std_logic;
    FMC_LA07_P                     : inout   std_logic;
    FMC_LA08_N                     : inout   std_logic;
    FMC_LA08_P                     : inout   std_logic;
    FMC_LA09_N                     : inout   std_logic;
    FMC_LA09_P                     : inout   std_logic;
    FMC_LA10_N                     : inout   std_logic;
    FMC_LA10_P                     : inout   std_logic;
    FMC_LA11_N                     : inout   std_logic;
    FMC_LA11_P                     : inout   std_logic;
    FMC_LA12_N                     : inout   std_logic;
    FMC_LA12_P                     : inout   std_logic;
    FMC_LA13_N                     : inout   std_logic;
    FMC_LA13_P                     : inout   std_logic;
    FMC_LA14_N                     : inout   std_logic;
    FMC_LA14_P                     : inout   std_logic;
    FMC_LA15_N                     : inout   std_logic;
    FMC_LA15_P                     : inout   std_logic;
    FMC_LA16_N                     : inout   std_logic;
    FMC_LA16_P                     : inout   std_logic;
    FMC_LA19_N                     : inout   std_logic;
    FMC_LA19_P                     : inout   std_logic;
    FMC_LA20_N                     : inout   std_logic;
    FMC_LA20_P                     : inout   std_logic;
    FMC_LA21_N                     : inout   std_logic;
    FMC_LA21_P                     : inout   std_logic;
    FMC_LA22_N                     : inout   std_logic;
    FMC_LA22_P                     : inout   std_logic;
    FMC_LA23_N                     : inout   std_logic;
    FMC_LA23_P                     : inout   std_logic;
    FMC_LA24_N                     : inout   std_logic;
    FMC_LA24_P                     : inout   std_logic;
    FMC_LA25_N                     : inout   std_logic;
    FMC_LA25_P                     : inout   std_logic;
    FMC_LA26_N                     : inout   std_logic;
    FMC_LA26_P                     : inout   std_logic;
    FMC_LA27_N                     : inout   std_logic;
    FMC_LA27_P                     : inout   std_logic;
    FMC_LA28_N                     : inout   std_logic;
    FMC_LA28_P                     : inout   std_logic;
    FMC_LA29_N                     : inout   std_logic;
    FMC_LA29_P                     : inout   std_logic;
    FMC_LA30_N                     : inout   std_logic;
    FMC_LA30_P                     : inout   std_logic;
    FMC_LA31_N                     : inout   std_logic;
    FMC_LA31_P                     : inout   std_logic;
    FMC_LA32_N                     : inout   std_logic;
    FMC_LA32_P                     : inout   std_logic;
    FMC_LA33_N                     : inout   std_logic;
    FMC_LA33_P                     : inout   std_logic;
    FMC_DP1_C2M_N                  : inout   std_logic;
    FMC_DP1_C2M_P                  : inout   std_logic;
    FMC_DP1_M2C_N                  : inout   std_logic;
    FMC_DP1_M2C_P                  : inout   std_logic;
    FMC_DP2_C2M_N                  : inout   std_logic;
    FMC_DP2_C2M_P                  : inout   std_logic;
    FMC_DP2_M2C_N                  : inout   std_logic;
    FMC_DP2_M2C_P                  : inout   std_logic;
    FMC_DP3_C2M_N                  : inout   std_logic;
    FMC_DP3_C2M_P                  : inout   std_logic;
    FMC_DP3_M2C_N                  : inout   std_logic;
    FMC_DP3_M2C_P                  : inout   std_logic;
    FMC_DP4_C2M_N                  : inout   std_logic;
    FMC_DP4_C2M_P                  : inout   std_logic;
    FMC_DP4_M2C_N                  : inout   std_logic;
    FMC_DP4_M2C_P                  : inout   std_logic;
    FMC_DP5_C2M_N                  : inout   std_logic;
    FMC_DP5_C2M_P                  : inout   std_logic;
    FMC_DP5_M2C_N                  : inout   std_logic;
    FMC_DP5_M2C_P                  : inout   std_logic;
    FMC_DP6_C2M_N                  : inout   std_logic;
    FMC_DP6_C2M_P                  : inout   std_logic;
    FMC_DP6_M2C_N                  : inout   std_logic;
    FMC_DP6_M2C_P                  : inout   std_logic;
    FMC_DP7_C2M_N                  : inout   std_logic;
    FMC_DP7_C2M_P                  : inout   std_logic;
    FMC_DP7_M2C_N                  : inout   std_logic;
    FMC_DP7_M2C_P                  : inout   std_logic;
    FMC_HA00_CC_N                  : inout   std_logic;
    FMC_HA00_CC_P                  : inout   std_logic;
    FMC_HA01_CC_N                  : inout   std_logic;
    FMC_HA01_CC_P                  : inout   std_logic;
    FMC_HA17_N                     : inout   std_logic;
    FMC_HA17_P                     : inout   std_logic;
    FMC_LA00_CC_N                  : inout   std_logic;
    FMC_LA00_CC_P                  : inout   std_logic;
    FMC_LA01_CC_N                  : inout   std_logic;
    FMC_LA01_CC_P                  : inout   std_logic;
    FMC_LA17_CC_N                  : inout   std_logic;
    FMC_LA17_CC_P                  : inout   std_logic;
    FMC_LA18_CC_N                  : inout   std_logic;
    FMC_LA18_CC_P                  : inout   std_logic;
    FMC_CLK0_M2C_N                 : inout   std_logic;
    FMC_CLK0_M2C_P                 : inout   std_logic;
    FMC_CLK1_M2C_N                 : inout   std_logic;
    FMC_CLK1_M2C_P                 : inout   std_logic;
    FMC_GCLK1_M2C_N                : inout   std_logic;
    FMC_GCLK1_M2C_P                : inout   std_logic;

    -- HDMI
    HDMI_HPD                       : in      std_logic;
    HDMI_D0_N                      : out     std_logic;
    HDMI_D0_P                      : out     std_logic;
    HDMI_D1_N                      : out     std_logic;
    HDMI_D1_P                      : out     std_logic;
    HDMI_D2_N                      : out     std_logic;
    HDMI_D2_P                      : out     std_logic;
    HDMI_CLK_N                     : out     std_logic;
    HDMI_CLK_P                     : out     std_logic;

    -- I2C FPGA
    I2C_SCL_FPGA                   : inout   std_logic;
    I2C_SDA_FPGA                   : inout   std_logic;

    -- I2C_MIPI_SEL
    I2C_MIPI_SEL                   : inout   std_logic;

    -- I2C PL
    I2C_SCL                        : inout   std_logic;
    I2C_SDA                        : inout   std_logic;

    -- IO3
    IO3_D0_P                       : inout   std_logic;
    IO3_D1_N                       : inout   std_logic;
    IO3_D2_P                       : inout   std_logic;
    IO3_D3_N                       : inout   std_logic;
    IO3_D4_P                       : inout   std_logic;
    IO3_D5_N                       : inout   std_logic;
    IO3_D6_P                       : inout   std_logic;
    IO3_D7_N                       : inout   std_logic;

    -- IO4
    IO4_D2_P                       : inout   std_logic;
    IO4_D3_N                       : inout   std_logic;
    IO4_D4_P                       : inout   std_logic;
    IO4_D5_N                       : inout   std_logic;
    IO4_D6_P                       : inout   std_logic;
    IO4_D7_N                       : inout   std_logic;

    -- LED
    LED0_PL_N                      : out     std_logic;
    LED1_PL_N                      : out     std_logic;
    LED2_PL_N                      : out     std_logic;
    LED3_PL_N                      : out     std_logic;

    -- MIPI0
    MIPI0_D0_N                     : in      std_logic;
    MIPI0_D0_P                     : in      std_logic;
    MIPI0_D1_N                     : in      std_logic;
    MIPI0_D1_P                     : in      std_logic;
    MIPI0_CLK_D0LP_N               : in      std_logic;
    MIPI0_CLK_D0LP_P               : in      std_logic;
    MIPI0_CLK_N                    : in      std_logic;
    MIPI0_CLK_P                    : in      std_logic;

    -- MIPI1
    MIPI1_D0_N                     : in      std_logic;
    MIPI1_D0_P                     : in      std_logic;
    MIPI1_D1_N                     : in      std_logic;
    MIPI1_D1_P                     : in      std_logic;
    MIPI1_CLK_D0LP_N               : in      std_logic;
    MIPI1_CLK_D0LP_P               : in      std_logic;
    MIPI1_CLK_N                    : in      std_logic;
    MIPI1_CLK_P                    : in      std_logic;

    -- Oscillator 100 MHz
    CLK_100_CAL                    : in      std_logic;

    -- SFP
    SFP_RX_N                       : inout   std_logic;
    SFP_RX_P                       : inout   std_logic;
    SFP_TX_N                       : inout   std_logic;
    SFP_TX_P                       : inout   std_logic;

    -- ST1 LED
    LED2                           : out     std_logic;
    LED3                           : out     std_logic
  );
end Mercury_XU6_ST1;

architecture rtl of Mercury_XU6_ST1 is

  ----------------------------------------------------------------------------------------------------
  -- component declarations
  ----------------------------------------------------------------------------------------------------
  component Mercury_XU6 is
    port (
      DP_AUX_OUT          : out    std_logic;
      DP_AUX_OE           : out    std_logic;
      DP_AUX_IN           : in     std_logic;
      DP_HPD              : in     std_logic;
      CLK_100_CAL         : in     std_logic;
      Clk100              : out    std_logic;
      Clk50               : out    std_logic;
      Rst_N               : out    std_logic;
      IIC_FPGA_sda_i      : in     std_logic;
      IIC_FPGA_sda_o      : out    std_logic;
      IIC_FPGA_sda_t      : out    std_logic;
      IIC_FPGA_scl_i      : in     std_logic;
      IIC_FPGA_scl_o      : out    std_logic;
      IIC_FPGA_scl_t      : out    std_logic;
      LED_N               : out    std_logic_vector(2 downto 0);
      I2C_MIPI_SEL        : inout  std_logic;
      mipi_phy_if_0_clk_n : in     std_logic;
      mipi_phy_if_0_clk_p : in     std_logic;
      mipi_phy_if_0_data_n  : in     std_logic_vector(1 downto 0);
      mipi_phy_if_0_data_p  : in     std_logic_vector(1 downto 0)
    );

  end component Mercury_XU6;
  component IBUFDS is
      port (
        O : out STD_LOGIC;
        I : in STD_LOGIC;
        IB : in STD_LOGIC
      );
    end component IBUFDS;


  component OBUFDS is
    port (
      I : in STD_LOGIC;
      O : out STD_LOGIC;
      OB : out STD_LOGIC
    );
  end component OBUFDS;

  component IOBUF is
    port (
      I : in STD_LOGIC;
      O : out STD_LOGIC;
      T : in STD_LOGIC;
      IO : inout STD_LOGIC
    );
  end component IOBUF;

  ----------------------------------------------------------------------------------------------------
  -- signal declarations
  ----------------------------------------------------------------------------------------------------
  signal Clk100           : std_logic;
  signal Clk50            : std_logic;
  signal Rst_N            : std_logic;
  signal IIC_FPGA_sda_i   : std_logic;
  signal IIC_FPGA_sda_o   : std_logic;
  signal IIC_FPGA_sda_t   : std_logic;
  signal IIC_FPGA_scl_i   : std_logic;
  signal IIC_FPGA_scl_o   : std_logic;
  signal IIC_FPGA_scl_t   : std_logic;
  signal LED_N            : std_logic_vector(2 downto 0);
  signal dp_aux_data_oe_n : std_logic;
  signal LedCount         : unsigned(23 downto 0);
  signal mipi_phy_if_0_clk_n  : std_logic;
  signal mipi_phy_if_0_clk_p  : std_logic;
  signal mipi_phy_if_0_data_n : std_logic_vector(1 downto 0);
  signal mipi_phy_if_0_data_p : std_logic_vector(1 downto 0);

  ----------------------------------------------------------------------------------------------------
  -- attribute declarations
  ----------------------------------------------------------------------------------------------------

begin

  ----------------------------------------------------------------------------------------------------
  -- processor system instance
  ----------------------------------------------------------------------------------------------------
  Mercury_XU6_i: component Mercury_XU6
    port map (
      DP_AUX_OUT           => DP_AUX_OUT,
      DP_AUX_OE            => dp_aux_data_oe_n,
      DP_AUX_IN            => DP_AUX_IN,
      DP_HPD               => DP_HPD,
      CLK_100_CAL          => CLK_100_CAL,
      Clk100               => Clk100,
      Clk50                => Clk50,
      Rst_N                => Rst_N,
      IIC_FPGA_sda_i       => IIC_FPGA_sda_i,
      IIC_FPGA_sda_o       => IIC_FPGA_sda_o,
      IIC_FPGA_sda_t       => IIC_FPGA_sda_t,
      IIC_FPGA_scl_i       => IIC_FPGA_scl_i,
      IIC_FPGA_scl_o       => IIC_FPGA_scl_o,
      IIC_FPGA_scl_t       => IIC_FPGA_scl_t,
      LED_N                => LED_N,
      I2C_MIPI_SEL         => I2C_MIPI_SEL,
      mipi_phy_if_0_clk_n  => mipi_phy_if_0_clk_n,
      mipi_phy_if_0_clk_p  => mipi_phy_if_0_clk_p,
      mipi_phy_if_0_data_n => mipi_phy_if_0_data_n,
      mipi_phy_if_0_data_p => mipi_phy_if_0_data_p
    );

  CLK_REF_buf: component IBUFDS
  port map (
    O => open,
    I => CLK_REF_P,
    IB => CLK_REF_N
  );

  CLK_REF1_buf: component IBUFDS
  port map (
    O => open,
    I => CLK_REF1_P,
    IB => CLK_REF1_N
  );

  CLK_REF2_buf: component IBUFDS
  port map (
    O => open,
    I => CLK_REF2_P,
    IB => CLK_REF2_N
  );

  CLK_USR_buf: component IBUFDS
  port map (
    O => open,
    I => CLK_USR_P,
    IB => CLK_USR_N
  );

  DP_AUX_OE <= not dp_aux_data_oe_n;

  hdmi_clock_buf: component OBUFDS
    port map (
      I => '0',
      O => HDMI_CLK_P,
      OB => HDMI_CLK_N
    );
  IIC_FPGA_scl_iobuf: component IOBUF
    port map (
      I => IIC_FPGA_scl_o,
      IO => I2C_SCL_FPGA,
      O => IIC_FPGA_scl_i,
      T => IIC_FPGA_scl_t
    );

  IIC_FPGA_sda_iobuf: component IOBUF
    port map (
      I => IIC_FPGA_sda_o,
      IO => I2C_SDA_FPGA,
      O => IIC_FPGA_sda_i,
      T => IIC_FPGA_sda_t
    );
  process (Clk50)
  begin
    if rising_edge (Clk50) then
      if Rst_N = '0' then
        LedCount    <= (others => '0');
      else
        LedCount    <= LedCount + 1;
      end if;
    end if;
  end process;
  Led0_PL_N <= '0' when LedCount(LedCount'high) = '0' else 'Z';
  Led1_PL_N <= '0' when LED_N(0) = '0' else 'Z';
  Led2_PL_N <= '0' when LED_N(1) = '0' else 'Z';
  Led3_PL_N <= '0' when LED_N(2) = '0' else 'Z';

  LED2 <= 'Z';
  LED3 <= 'Z';

  mipi0_gen: if INPUT_PORT = "mipi0" generate
  mipi_phy_if_0_clk_n     <= MIPI0_CLK_D0LP_N;
  mipi_phy_if_0_clk_p     <= MIPI0_CLK_D0LP_P;
  mipi_phy_if_0_data_n(0) <= MIPI0_D0_N;
  mipi_phy_if_0_data_n(1) <= MIPI0_D1_N;
  mipi_phy_if_0_data_p(0) <= MIPI0_D0_P;
  mipi_phy_if_0_data_p(1) <= MIPI0_D1_P;
  end generate;

  mipi1_gen: if INPUT_PORT = "mipi1" generate
  mipi_phy_if_0_clk_n     <= MIPI1_CLK_D0LP_N;
  mipi_phy_if_0_clk_p     <= MIPI1_CLK_D0LP_P;
  mipi_phy_if_0_data_n(0) <= MIPI1_D0_N;
  mipi_phy_if_0_data_n(1) <= MIPI1_D1_N;
  mipi_phy_if_0_data_p(0) <= MIPI1_D0_P;
  mipi_phy_if_0_data_p(1) <= MIPI1_D1_P;
  end generate;

end rtl;
