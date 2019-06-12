*************************************************************************
   ____  ____
  /   /\/   /
 /___/  \  /
 \   \   \/    © Copyright 2019 Xilinx, Inc. All rights reserved.
  \   \        This file contains confidential and proprietary
  /   /        information of Xilinx, Inc. and is protected under U.S.
 /___/   /\    and international copyright and other intellectual
 \   \  /  \   property laws.
  \___\/\___\
	
*************************************************************************

Vendor                     : Xilinx
Current README.txt Version : 4.0
Date Last Modified         : 28MAY2019
Date Created               : 28MAY2019

Associated Filename        : rdf0428-zcu106-vcu-trd-2019-1.zip
Associated Document        : UG1250 , Zynq UltraScale+ MPSoC ZCU106 Video Codec Unit 
                             Targeted Reference Design, v2019.1
Supported Device(s)        : XCZU7EV
Supported Board(s)         : ZCU106 rev-c and above 

*************************************************************************

Disclaimer:

      This disclaimer is not a license and does not grant any rights to
      the materials distributed herewith. Except as otherwise provided in
      a valid license issued to you by Xilinx, and to the maximum extent
      permitted by applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE
      "AS IS" AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL
      WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY,
      INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY,
      NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
      (2) Xilinx shall not be liable (whether in contract or tort,
      including negligence, or under any other theory of liability) for
      any loss or damage of any kind or nature related to, arising under
      or in connection with these materials, including for any direct, or
      any indirect, special, incidental, or consequential loss or damage
      (including loss of data, profits, goodwill, or any type of loss or
      damage suffered as a result of any action brought by a third party)
      even if such damage or loss was reasonably foreseeable or Xilinx
      had been advised of the possibility of the same.

Critical Applications:

      Xilinx products are not designed or intended to be fail-safe, or
      for use in any application requiring fail-safe performance, such as
      life-support or safety devices or systems, Class III medical
      devices, nuclear facilities, applications related to the deployment
      of airbags, or any other applications that could lead to death,
      personal injury, or severe property or environmental damage
      (individually and collectively, "Critical Applications"). Customer
      assumes the sole risk and liability of any use of Xilinx products
      in Critical Applications, subject only to applicable laws and
      regulations governing limitations on product liability.

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS
FILE AT ALL TIMES.

*************************************************************************

This readme file contains these sections:

1. REVISION HISTORY
2. OVERVIEW
3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS
4. DESIGN FILE HIERARCHY
5. INSTALLATION AND OPERATING INSTRUCTIONS
6. OTHER INFORMATION (OPTIONAL)
7. SUPPORT


1. REVISION HISTORY 

            Readme  
Date        Version      Revision Description
=================================================================================================
29JUN2018    1.0          Initial Xilinx release.
27JUL2018    2.0          v2018.2 updated Xilinx release.
10DEC2018    3.0          v2018.3 updated Xilinx release.
28MAY2019    4.0          v2019.1 updated Xilinx release.
=================================================================================================


2. OVERVIEW

This readme describes how to use the files that come with the TRD zip file 
and UG1250.

The VCU TRD is an embedded video encoding/decoding application partitioned between the SoC 
processing system (PS),VCU, and programmable logic (PL) for optimal performance. The design 
demonstrates the capabilities and performance throughput of the VCU embedded macro block 
available in Zynq UltraScale+ MPSoC devices.

3. SOFTWARE TOOLS AND SYSTEM REQUIREMENTS

 a. Hardware
 
    Required:
      ZCU106 evaluation board (rev C or newer) with power cable
      Monitor with DisplayPort/HDMI input supporting 3840x2160 resolution
      Display Port cable (DP certified)
      HDMI cable
      Class-10 SD card
      GooBang Doo ABOX 2017 player
      NVIDIA SHIELD Pro
      USB mouse
      Ethernet cable
      SDI Receiver - Black Magic Teranex Mini HDMI to 12G converter
      SDI Transmitter - Black Magic Teranex Mini 12G to HDMI converter
      SFP+ for 10G module
      SFP-to-RJ45 adapter module
	  X86 UBUNTU HOST machine with PCIe slot

    Optional:
      USB pen drive formatted with FAT32 file system and hub
      SATA drive formatted with FAT32 file system, external power supply, and data cable
      LI-IMX274MIPI-FMC image sensor daughter card

 b. Software
    i. Xilinx SDK 2019.1
   ii. PetaLinux 2019.1
  iii. Xilinx SDx 2019.1

4. DESIGN FILE HIERARCHY

The directory structure underneath the top-level folder is described 
below:
+rdf0428-zcu106-vcu-trd-2019-1
 +-- apu
 ¦   +-- apps
 ¦   +-- vcu_petalinux_bsp
 ¦   +-- vcu_sdx
 ¦   +-- ws_bypass
 +-- host_x86
 ¦   +-- host_package
 +-- images
 ¦   +-- vcu_10g
 ¦   +-- vcu_audio
 ¦   +-- vcu_hdmirx
 ¦   +-- vcu_hdmitx
 ¦   +-- vcu_pcie
 ¦   +-- vcu_plddr
 ¦   +-- vcu_sdirx
 ¦   +-- vcu_sdirxtx
 ¦   +-- vcu_sditx
 ¦   +-- vcu_sdx
 ¦   +-- vcu_trd
 +-- pl
 ¦   +-- constrs
 ¦   +-- pre-built
 ¦   +-- scripts
 ¦   +-- srcs
 +-- README.txt

5. INSTALLATION AND OPERATING INSTRUCTIONS 

   Install the Xilinx SDK 2019.1 and Petalinux on the control/development computer and setup both environments.
   Instructions on building the hardware and software are captured in wiki page. Link to the wiki page is:
   https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/25329832/Zynq+UltraScale+MPSoC+VCU+TRD+2019.1
   
6. OTHER INFORMATION  

1) Warnings - NONE

2) Design Notes - NONE

3) Fixes - NONE

4) Known Issues and Limitations
	For known issues and limitation refer to the wiki link.
	https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/25329832/Zynq+UltraScale+MPSoC+VCU+TRD+2019.1

7. SUPPORT

To obtain technical support for this reference design, go to 
www.xilinx.com/support to locate answers to known issues in the Xilinx
Answers Database.  
