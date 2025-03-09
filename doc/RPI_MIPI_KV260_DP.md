#RaspberryPi 15pin MIPI camera module + KV260
Copied for Greg Taylor's project, and update to **2024.2**.
Tested Raspberry Pi Camera module V2(IMX219) & Raspberry Pi Camera HQ (IMX477)

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
