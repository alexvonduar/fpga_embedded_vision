# FPGA Embedded Vision
## Boards
* [AMD Zynq™ UltraScale+™ MPSoC ZCU104 Evaluation Kit](https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-boards/zcu104.html)

<p align="center">
<img title="ZCU104" src="pictures/zcu104.png" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

* [Kria KV260 Vision AI Starter Kit](https://www.amd.com/en/products/system-on-modules/kria/k26/kv260-vision-starter-kit.html)

<p align="center">
<img title="ZCU104" src="pictures/kv260.png" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

* [Picozed Zynq 7030 som + FMC carrier v2](https://www.avnet.com/wps/portal/apac/products/products/xilinx-embedded-vision-development-kit-picozed-7030-som-based/)

<p align="center">
<img src="pictures/AES-PZ-EMBV-KIT-G-front_small.png" title="Ebedded Vision Kit" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

* [MYD-C7Z020](http://www.myir-tech.com/product/myd_C7Z010_20.htm)

<p align="center">
<img title="MYD-C7Z020" src="pictures/MYD-C7Z010_20_2.png" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

* ZYNQ_DEV

<p align="center">
<img title="ZCU104" src="pictures/zynq_dev.png" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

* Enclustra [Mercury+ ST1](https://www.enclustra.com/en/products/base-boards/mercury-st1/) + [Mercury+ XU6](https://www.enclustra.com/en/products/system-on-chip-modules/mercury-xu6/)

<p align="center">
<img title="ZCU104" src="pictures/mercury_st1_front_600.png" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

<p align="center">
<img title="ZCU104" src="pictures/mercury_xu6_front_600.jpg" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

## Camera Modules
* [AES-CAM-ON-P1300C-G](https://www.avnet.com/shop/us/products/avnet-engineering-services/aes-cam-on-p1300c-g-3074457345635221618/) + [AES-FMC-HDMI-CAM-G](https://www.avnet.com/shop/us/products/avnet-engineering-services/aes-fmc-hdmi-cam-g-3074457345635221625/)

<p align="center">
<img src="pictures/AES-FMC-HDMI-CAM-G-front-angle-onsmi-highres_web.png" title="PYTHON1300" alt="Resizable Image" class="resizable-image" width="320"/>
</p>

* [LI-IMX274-FMC](https://leopardimaging.com/product/csi-2-mipi-modules-i-pex/li-imx274mipi-fmc/)

<p align="center">
<img src="pictures/li-imx274-fmc.png" title="LI-IMX274-FMC" alt="Resizable Image" class="resizable-image" width="320"/>
</p>

* IMX219 Module Raspberry Pi 15 pin compatible

<p align="center">
<img src="pictures/imx219.png" title="IMX219 module" alt="Resizable Image" class="resizable-image" width="320"/>
</p>

## Software Environment
* Host PC: Ubuntu 25.04 dev branch
* Vivado 2024.2
* Vitis 2024.2

## Reference Designs
1. [Avnet Reference Design](https://github.com/Avnet/hdl) [Picozed Zynq  7030 SOM + Onsemi PYTHON1300 FMC + Picozed FMC carrier board v2]
2. [ZCU106 VCU TRD 2019.1](https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/112230447/Zynq+UltraScale+MPSoC+VCU+TRD+2019.1)
3. [Xilinx reVision](https://github.com/Xilinx/reVISION-Getting-Started-Guide)
4. [Greg Taylor's Ultra96v2 IMX219 to Displayport project](https://github.com/gtaylormb/ultra96v2_imx219_to_displayport)
## Create HW & SW Projects
1. Onsemi PYTHON1300 FMC + ZCU104(under developing)

   This project is porting from Avnet Hdl project, from Picozed Zynq7030 to ZCU104.
```shell
cd scripts
vivado -mode tcl -source zcu104_fmchc_python1300c.tcl -notrace
```
2. LI-IMX274-FMC + ZCU104

    This project is porting from ZCU106 VCU TRD reference design.
    updated to 2024.2
```shell
cd scripts
vivado -mode tcl -source zcu104_vcu_trd_proj.tcl -notrace
```
3. Onsemi PYTHON1300 FMC + MYD-C7Z020

   This project is now updated to **2024.2**.
   - combined color space convert and chroma subsampling into single Video Processing Subsystem IP;
   - replace OSD with Video Mixer IP;
   - add one more test pattern generated base layer.

```shell
source $(VITIS_PATH)/settings64.sh
make myir
```

<p align="center">
<img title="Onsemi PYTHON1300 FMC + MYD-C7Z020" src="pictures/myir7020_fmchc_python1300c.jpeg" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

4. Onsemi PYTHON1300 FMC + ZYNQ_DEV

   This project is now updated to **2024.2**.
   - combined color space convert and chroma subsampling into single Video Processing Subsystem IP;
   - replace OSD with Video Mixer IP;
   - add one more test pattern generated base layer.

```shell
source $(VITIS_PATH)/settings64.sh
make zynqdev_fmchc_python1300c
```

<p align="center">
<img title="Onsemi PYTHON1300 FMC + ZYNQ_DEV" src="pictures/zynq_dev_fmchc_python1300c.jpg" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

5. IMX219 RaspberryPi 15pin MIPI camera module + KV260
   Copied for Greg Taylor's project, and update to **2024.2**.

```shell
source $(VITIS_PATH)/settings64.sh
make kv260_rpi_mipi
```

Since KV260 fw bootloader is not compatible with standalone BOOT.BIN. So we need a Jtag to run the demo. Need to set KV260 to jtag boot mode:
```shell
source $(VITIS_PATH)/settings64.sh
xsct scripts/som_bootmode.tcl
```
after that use Vitis to open the sw workspace and run the demo.

<p align="center">
<img title="IMX219 RPi + ZYNQ_DEV" src="pictures/kv260_rpi_mipi.jpg" alt="Resizable Image" class="resizable-image" width="640"/>
</p>

6. IMX219 RaspberryPi 15pin MIPI camera module + Mercury+ ST1 + XU6
```shell
source $(VITIS_PATH)/settings64.sh
make me_xu6_st1_mipi
```
<p align="center">
<img title="IMX219 RPi + ZYNQ_DEV" src="pictures/me_xu6_st1_imx219.jpg" alt="Resizable Image" class="resizable-image" width="640"/>
</p>