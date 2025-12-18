#ZYNQ_DEV

##Board
[ZYNQ_DEV](Boards.md###ZYNQ_DEV)

##PYTHON1300 FMC

###Camera

###Build and rund

This project is now updated to **2024.2**.
   * combined color space convert and chroma subsampling into single Video Processing Subsystem IP;
   * replace OSD with Video Mixer IP;
   * add one more test pattern generated base layer.

```shell
source $(VITIS_PATH)/settings64.sh
make BOARDS=zynqdev FMC_BOARDS=fmchc_python1300c INPUT_PORTS=fmc_python1300c OUTPUT_PORTS=fmc_hdmi
make BOARDS=zynqdev FMC_BOARDS=fmchc_python1300c INPUT_PORTS=fmc_python1300c OUTPUT_PORTS=hdmi1
make BOARDS=zynqdev FMC_BOARDS=fmchc_python1300c INPUT_PORTS=fmc_python1300c OUTPUT_PORTS=hdmi2
```

<p align="center">
<img title="Onsemi PYTHON1300 FMC + ZYNQ_DEV" src="pictures/zynq_dev_fmchc_python1300c.jpg" alt="Resizable Image" class="resizable-image" width="640"/>
</p>
