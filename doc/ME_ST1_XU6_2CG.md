# Mercury+ ST1 + XU6

## Board
[Mercury+ ST1 + XU6](Boards.md######Mercury+-ST1-+-XU6)

## Onboard RPi Camera MIPI0

```shell
source $(VITIS_PATH)/settings64.sh
make rpi_mipi_dp_me_st1_xu6
```

imx219 module tested, video out 1080p at 60fps.

<p align="center">
<img title="IMX219 RPi at MIPI0 on Mercury ST+" src="pictures/me_xu6_st1_imx219.jpg" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

## Opsero RPi Camera FMC

Opsero RPi Camera FMC adapter have 4 RPI 15 pin mipi camera ports, only port 1 with CLK_SEL=0 and port 2 could be used on Mercury+ ST1 with XU6 2CG.
|MIPI|Bank|FPGA PIN|Clock SEL|
|----|----|--------|---------|
|MIPI0|65|-|-|
|MIPI1|65|CLK(L7/L6) D0(L1/K1) D1(J1/H1)|CAM1_CLK_SEL=0|
|MIPI2|66|CLK(D7/D6) D0(C8/B8) D1(E5/D5)|-|
|MIPI3|66|-|-|

According to [opsero detail description](https://camerafmc.com/docs/rpi-camera-fmc/detailed-description/), use 2bit constans(0x3) set IO dir as output and 2bit constans(0x2) to set IO0 output enabled, IO1 Hi-Z.

|Net name|FMC Pin|Purpose|
|--------|-------|-------|
|CAM_IO0_DIR|LA13_P|IO0 direction (0=Cam-to-FPGA,1=FPGA-to-cam)|
CAM_IO1_DIR|LA13_N|IO1direction (0=Cam-to-FPGA,1=FPGA-to-cam)|
|CAM_IO0_OE_N|LA27_P|IO0 output enable (0=Enabled,1=Hi-Z output)|
|CAM_IO1_OE_N|LA27_N|IO1 output enable (0=Enabled,1=Hi-Z output)|

```shell
source $(VITIS_PATH)/settings64.sh
make rpi_mipi_opsero_dp_me_st1_xu6
```
default project using MIPI port 1, you can specify using MIPI2.
At top dir
```shell
make -C ${PWD}/enclustra TOP=${PWD} INPUT=rpi_mipi_opsero OUTPUT=dp FMC_BOARD=opsero MIPI_PORT=2 all
```
Default build is debug build, you can use BUILD=Release change to release build for Vitis bsp and apps.
imx219 module tested, video out 1080p at 60fps.

<p align="center">
<img title="IMX219 RPi at Opsero MIPI1 with Mercury ST+" src="pictures/rpi_mipi_opsero_dp_me_st1_xu6.jpg" alt="Resizable Image" class="resizable-image" width="640"/>
</p>
