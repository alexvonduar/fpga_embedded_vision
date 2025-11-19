# IMX219 RaspberryPi 15pin MIPI camera module + Mercury+ ST1 + XU6

## Board
[Mercury+ ST1 + XU6](Boards.md######Mercury+-ST1-+-XU6)

## Onboard RPi Camera MIPI0

```shell
source $(VITIS_PATH)/settings64.sh
make rpi_mipi_dp_me_st1_xu6
```

<p align="center">
<img title="IMX219 RPi + ZYNQ_DEV" src="pictures/me_xu6_st1_imx219.jpg" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

## Opsero RPi Camera FMC

Supported MIPI ports
|MIPI|Bank|FPGA PIN|Clock SEL|
|----|----|--------|---------|
|MIPI0|65|-|-|
|MIPI1|65|CLK(L7/L6) D0(L1/K1) D1(J1/H1)|CAM1_CLK_SEL=0|
|MIPI2|66|CLK(D7/D6) D0(C8/B8) D1(E5/D5)|-|
|MIPI3|66|-|-|

