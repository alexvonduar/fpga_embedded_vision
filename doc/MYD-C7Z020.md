#MYD-C7Z020

##Board
[MYD-C7Z020](Boards.md###MYD-C7Z020)

##PYTHON1300 FMC

###Camera

###Build and Run

This project is now updated to **2025.1**.
   * combined color space convert and chroma subsampling into single Video Processing Subsystem IP;
   * replace OSD with Video Mixer IP;
   * add one more test pattern generated base layer.

```shell
source $(VITIS_PATH)/settings64.sh
make fmchc_python1300c_myir7020
```

<p align="center">
<img title="Onsemi PYTHON1300 FMC + MYD-C7Z020" src="pictures/myir7020_fmchc_python1300c.jpeg" alt="Resizable Image" class="resizable-image" width="640"/>
</p>
