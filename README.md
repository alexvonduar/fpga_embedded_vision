# FPGA Embedded Vision
## Boards
* Picozed 7030 som + fmc carrier v2
* Xilinx ZCU104 board
## Sensor Modules
* Onsemi PYTHON1300 FMC
* LI-IMX274-FMC
## Create HW & SW Projects
1. Onsemi PYTHON1300 FMC card + ZCU104
```shell
cd scripts
vivado -mode tcl -source zcu104_fmchc_python1300c.tcl -notrace
```
2. LI-IMX274-FMC + ZCU104
```shell
cd scripts
vivado -mode tcl -source zcu104_vcu_trd_proj.tcl -notrace
```
