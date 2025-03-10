# FPGA Embedded Vision

## Software Environment

* Host PC: Ubuntu 25.04 dev branch
* Vivado 2024.2
* Vitis 2024.2

## Reference Designs

1. [Avnet Reference Design](https://github.com/Avnet/hdl) [Picozed Zynq  7030 SOM + Onsemi PYTHON1300 FMC + Picozed FMC carrier board v2]
2. [ZCU106 VCU TRD 2019.1](https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/112230447/Zynq+UltraScale+MPSoC+VCU+TRD+2019.1)
3. [Xilinx reVision](https://github.com/Xilinx/reVISION-Getting-Started-Guide)
4. [https://github.com/gtaylormb/ultra96v2_imx219_to_displayport](https://github.com/gtaylormb/ultra96v2_imx219_to_displayport)
5. more camera support from [https://github.com/zakinder/KV260_IMX477_CAMERA](https://github.com/zakinder/KV260_IMX477_CAMERA)

## Create HW & SW Projects

1. [PYTHON1300 FMC + ZCU104(under developing)](doc/PYTHON1300_FMC_ZCU104.md)

2. [LI-IMX274-FMC + ZCU104](doc/LI-IMX274-FMC%20_ZCU104.md)

3. [PYTHON1300 FMC + MYD-C7Z020](doc/PYTHON1300_FMC_MYD-C7Z020.md)

4. [PYTHON1300 FMC + ZYNQ_DEV](doc/PYTHON1300_FMC_ZYNQ_DEV.md)

5. [RPI MIPI + KV260 DisplayPort](doc/RPI_MIPI_KV260_DP.md)

6. [IMX219 RaspberryPi 15pin MIPI camera module + Mercury+ ST1 + XU6](doc/IMX219_RPI_MIPI0_ME_ST1_XU6_2CG_DP.md)

## Boards

<table>
    <tr>
        <th>Board</th>
        <th>Features</th>
    </tr>
    <tr>
        <td>
            <p align="center">
                <img src="doc/pictures/AES-PZ-EMBV-KIT-G-front_small.png" title="Embedded Vision Kit" alt="Resizable Image" class="resizable-image" width="640"/>
                <a herf="https://www.avnet.com/wps/portal/apac/products/products/xilinx-embedded-vision-development-kit-picozed-7030-som-based/">Picozed Zynq 7030 som + FMC carrier v2</a>
            </p>
        </td>
        <td>
        Zynq 7030,<br>FMC LPC
        </td>
    </tr>
    <tr>
        <td>
            <p align="center">
                <img title="MYD-C7Z020" src="doc/pictures/MYD-C7Z010_20_2.png" alt="Resizable Image" class="resizable-image" width="640"/>
                <a herf="http://www.myir-tech.com/product/myd_C7Z010_20.htm">MYD-C7Z020</a>
            </p>
        </td>
        <td>
        Zynq 7020,<br>FMC LPC,<br>HDMI out
        </td>
    </tr>
    <tr>
        <td>
            <p align="center">
                <img title="Zynq_DEV" src="doc/pictures/zynq_dev.png" alt="Resizable Image" class="resizable-image" width="640"/>
                <a herf="">ZYNQ_DEV</a>
            </p>
        </td>
        <td>
        Zynq 7020,<br>FMC LPC,<br>RaspberryPi 15Pin MIPI-CSI,<br>2x HDMI out
        </td>
    </tr>
    <tr>
        <td>
            <p align="center">
                <img title="ZCU104" src="doc/pictures/zcu104.png" alt="Resizable Image" class="resizable-image" width="640"/>
                <a herf="https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-boards/zcu104.html">AMD Zynq™ UltraScale+™ MPSoC ZCU104 Evaluation Kit</a>
            </p>
        </td>
        <td>
        Zynq MPSoC ZU7EV,<br>FMC LPC,<br>HDMI in,<br>HDMI out,<br>DisplayPort
        </td>
    </tr>
    <tr>
        <td>
            <p align="center">
                <img title="KV260" src="doc/pictures/kv260.png" alt="Resizable Image" class="resizable-image" width="640"/>
                <a herf="https://www.amd.com/en/products/system-on-modules/kria/k26/kv260-vision-starter-kit.html">Kria KV260 Vision AI Starter Kit</a>
            </p>
        </td>
        <td>
        Kria K26,<br>RaspberryPi 15Pin MIPI-CSI,<br>IASx2, one with AR1330 & AR1302,<br>PS DisplayPort(splited HDMI)
        </td>
    </tr>
    <tr>
        <td>
            <p align="center">
                <img title="Enclustra Mercury+ ST1" src="doc/pictures/mercury_st1_front_600.png" alt="Resizable Image" class="resizable-image" width="640"/>
                <a herf="https://www.enclustra.com/en/products/base-boards/mercury-st1/">Enclustra Mercury+ ST1</a>
                <img title="Enclustra Mercury+ XU6" src="doc/pictures/mercury_xu6_front_600.jpg" alt="Resizable Image" class="resizable-image" width="640"/>
                <a herf="https://www.enclustra.com/en/products/system-on-chip-modules/mercury-xu6/">Enclustra Mercury+ XU6</a>
            </p>
        </td>
        <td>
        Zynq MPSoC ZU2CG,<br>FMC HPC,<br>2x RaspberryPi 15Pin MIPI-CSI,<br>HDMI out(redriver),<br>PS DisplayPort
        </td>
    </tr>
</table>

## Camera Modules

<table>
    <th>
        Camera Module
    </th>
    <th>
        Features
    </th>
<tr>
    <td>
        <p align="center">
            <img src="doc/pictures/AES-FMC-HDMI-CAM-G-front-angle-onsmi-highres_web.png" title="PYTHON1300" alt="Resizable Image" class="resizable-image" width="320"/>
        </p>
        <p align="center">
            <a herf="https://www.avnet.com/shop/us/products/avnet-engineering-services/aes-cam-on-p1300c-g-3074457345635221618/">AES-CAM-ON-P1300C-G</a> + <a herf="https://www.avnet.com/shop/us/products/avnet-engineering-services/aes-fmc-hdmi-cam-g-3074457345635221625/">AES-FMC-HDMI-CAM-G</a>
        </p>
    </td>
    <td>
        <p align="left">Sensor: Onsemi PYTHON1300<br></p>
        <p align="left">Features:<br></p>
        <p align="left">1/2 CMOS, Bayer RAW10, Pipelined Global Shutter, 2/4 lane LVDS, 4.8um<br></p>
        <p align="left">Active: 1280(H)x1024s(V) 1.31M<br></p>
        <p align="left">Module:<br></p>
        <p align="left">FMC LPC<br></p>
        <p align="left">HDMI in(ADV7611)<br></p>
        <p align="left">HDMI out(ADV7511)<br></p>
    </td>
</tr>
<tr>
    <td>
        <p align="center">
            <img src="doc/pictures/li-imx274-fmc.png" title="LI-IMX274-FMC" alt="Resizable Image" class="resizable-image" width="320"/>
        <p align="center">
            <a herf="https://leopardimaging.com/product/csi-2-mipi-modules-i-pex/li-imx274mipi-fmc/">LI-IMX274-FMC</a>
        </p>
    </td>
    <td>
        <p align="left">Sensor: SONY IMX274<br></p>
        <p align="left">Features:<br></p>
        <p align="left">1/1.25 CMOS, Bayer RAW10/12, 4 lane MIPI-CSI, 1.62um<br></p>
        <p align="left">Total: 3864(H)×2218(V) 8.57M<br></p>
        <p align="left">Effective: 3864(H)x2202(V) 8.51M<br></p>
        <p align="left">Active: 3864(H)x2196(V) 8.49M<br></p>
        <p align="left">Recommanded: 3840(H)x2160(V) 8.29M<br></p>
        <p align="left">Module:<br></p>
        <p align="left">FMC LPC<br></p>
    </td>
</tr>
<tr>
    <td>
        <p align="center">
            <img src="doc/pictures/imx219.png" title="IMX219 module" alt="Resizable Image" class="resizable-image" width="320"/>
        </p>
        <p align="center">
            IMX219 Module Raspberry Pi 15 pin compatible
        </p>
    </td>
    <td>
        <p align="left">Sensor: SONY IMX219<br></p>
        <p align="left">Features:<br></p>
        <p align="left">1/4 CMOS, Bayer RAW10, 2/4 lane MIPI-CSI, 1.12um<br></p>
        <p align="left">Total: 3296(H)×2512(V) 8.28M<br></p>
        <p align="left">Effective: 3296(H)x2480(V) 8.17M<br></p>
        <p align="left">Active: 3280(H)x2464(V) 8.08M<br></p>
        <p align="left">Module:<br></p>
        <p align="left">RaspberryPi 15pin interface<br></p>
    </td>
</tr>
<tr>
    <td>
        <p align="center">
            <img src="doc/pictures/rpi_hq_cam.png" title="IMX447 module" alt="Resizable Image" class="resizable-image" width="320"/>
        </p>
        <p align="center">
            Raspberry Pi HQ Camera Module
        </p>
    </td>
    <td>
        <p align="left">Sensor: SONY IMX477<br></p>
        <p align="left">Features:<br></p>
        <p align="left">1/2.3 CMOS, Bayer RAW12/10/8, 2/4 lane MIPI-CSI, 1.55um<br></p>
        <p align="left">Total: 4072(H)×3176(V) 12.93<br></p>
        <p align="left">Effective: 4072(H)x3064(V) 12.47M<br></p>
        <p align="left">Active: 4056(H)x3040(V) 12.33M<br></p>
        <p align="left">Module:<br></p>
        <p align="left">RaspberryPi 15pin interface<br></p>
    </td>
</tr>
</table>
