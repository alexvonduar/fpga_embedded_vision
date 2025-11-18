#PYTHON1300 FMC + ZCU104(under developing)

##Board
<p align="center">
    <img title="ZCU104" src="pictures/zcu104.png" alt="Resizable Image" class="resizable-image" width="640"/>
    <a herf="https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-boards/zcu104.html">AMD Zynq™ UltraScale+™ MPSoC ZCU104 Evaluation Kit</a>
</p>

##Camera

##Project

This project is porting from Avnet Hdl project, from Picozed Zynq7030 to ZCU104.

```shell
cd scripts
vivado -mode tcl -source zcu104_fmchc_python1300c.tcl -notrace
```
