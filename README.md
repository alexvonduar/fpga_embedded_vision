# FPGA Embedded Vision
## Boards
* Picozed Zynq 7030 som + FMC carrier v2
* Xilinx ZCU104 board
## Sensor Modules
* Onsemi PYTHON1300 FMC
* LI-IMX274-FMC
## Software Environment
* Vivado/SDx 2019.1
## Reference Designs
1. [Avnet Reference Design](https://github.com/Avnet/hdl) [Picozed Zynq  7030 SOM + Onsemi PYTHON1300 FMC + Picozed FMC carrier board v2]
2. [ZCU106 VCU TRD 2019.1](https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/112230447/Zynq+UltraScale+MPSoC+VCU+TRD+2019.1)
3. [Xilinx reVision](https://github.com/Xilinx/reVISION-Getting-Started-Guide)
## Create HW & SW Projects
1. Onsemi PYTHON1300 FMC card + ZCU104

   This project is porting from Avnet Hdl project, from Picozed Zynq7030 to ZCU104.
```shell
cd scripts
vivado -mode tcl -source zcu104_fmchc_python1300c.tcl -notrace
```
2. LI-IMX274-FMC + ZCU104

   This project is porting from ZCU106 VCU TRD reference design.
```shell
cd scripts
vivado -mode tcl -source zcu104_vcu_trd_proj.tcl -notrace
```
