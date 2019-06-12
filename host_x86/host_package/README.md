The files in this directory provide Xilinx PCIe DMA drivers, example software,
to be used to exercise file transfer over the Xilinx PCIe DMA IP and perform the 
transcode use case using Xilinx VCU IP on zcu106 board.

This software can be used directly or referenced to create drivers and software
for your Xilinx FPGA hardware design.

Directory and file description:
===============================
 - xdma/: This directory contains the Xilinx PCIe DMA kernel module
       driver files.

 - libxdma/: This directory contains support files for the kernel driver module,
	which interfaces directly with the XDMA IP.

 - include/: This directory contains all include files that are needed for
	compiling driver.

 - etc/: This directory contains rules for the Xilinx PCIe DMA kernel module
	and software. The files in this directory should be copied to the /etc/
	directory on your linux system.

 - tests/: This directory contains example application software to exercise the
	provided kernel module driver and Xilinx PCIe DMA IP. This directory
	also contains the following scripts and directories.

	 - load_driver.sh:
		This script loads the kernel module and creates the necissary
		kernel nodes used by the provided software.
		The kernel device nodes will be created under /dev/xdma*.
		Additional device nodes are created under /dev/xdma/card* to
		more easily differentiate between multiple PCIe DMA enabled
		cards. Root permissions will be required to run this script.

Usage:
  - Change directory to the driver directory.
        cd xdma
  - Compile, install and load the kernel module driver.
        ./run_make.sh
  - Change directory to the tools directory.
        cd tools
  - Compile the provided example test tools.
        make
  - Copy the provided driver rules from the etc directory to the /etc/ directory
    on your system.
        cp ../etc/udev/rules.d/* /etc/udev/rules.d/

Frequently asked questions:
  Q: How do I uninstall the kernel module driver?
  A: Use the following commands to uninstall the driver.
       - Uninstall the kernel module.
             rmmod -s xdma
       - Delete the dma rules that were added.
             rm -f /etc/udev/rules.d/60-xdma.rules
             rm -f /etc/udev/rules.d/xdma-udev-command.sh

  Q: How do I modify the PCIe Device IDs recognized by the kernel module driver?
  A: The xdma/xdma_mod.c file constains the pci_device_id struct that identifies
     the PCIe Device IDs that are recognized by the driver in the following
     format:
         { PCI_DEVICE(0x10ee, 0x8038), },
     Add, remove, or modify the PCIe Device IDs in this struct as desired. Then
     uninstall the existing xdma kernel module, compile the driver again, and
     re-install the driver using the load_driver.sh script.

  Q: By default the driver uses interupts to signal when DMA transfers are
     completed. How do I modify the driver to use polling rather than
     interrupts to determine when DMA transactions are completed?
  A: The driver can be changed from being interrupt driven (default) to being
     polling driven (poll mode) when the kernel module is inserted. To do this
     modify the load_driver.sh file as follows:
        Change: insmod xdma/xdma.ko
        To:     insmod xdma/xdma.ko poll_mode=1
     Note: Interrupt vs Poll mode will apply to all DMA channels. If desired the
     driver can be modified such that some channels are interrupt driven while
     others are polling driven. Refer to the poll mode section of PG195 for
     additional information on using the PCIe DMA IP in poll mode. 
