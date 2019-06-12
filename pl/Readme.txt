
Hardware project creation and bit file generation 

	=> For creating VCU TRD Hardware design
	- Set vivado tool version to 2019.1.
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/vcu_trd_proj.tcl
	
	=> For creating VCU Audio Hardware design
	- Set vivado tool version to 2019.1
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/vcu_audio_proj.tcl	
		 
	=> For creating VCU Ethernet 10G Hardware design
	- Set vivado tool version to 2019.1
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/vcu0g_proj.tcl

	=> For creating VCU SDIRXTX Hardware design
	- Set vivado tool version to 2019.1.
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/vcu_sdirxtx_proj.tcl
	
	=> For creating VCU SDIRX Hardware design
	- Set vivado tool version to 2019.1
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/vcu_sdirx_proj.tcl	
		 
	=> For creating VCU SDITX Hardware design
	- Set vivado tool version to 2019.1
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/vcu_sditx_proj.tcl
	
	=> For creating VCU HDMIRX Hardware design
	- Set vivado tool version to 2019.1
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/vcu_hdmirx_proj.tcl	
		 
	=> For creating VCU HDMITX Hardware design
	- Set vivado tool version to 2019.1
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/vcu_hdmitx_proj.tcl	
		 
	=> For creating VCU HDMI PLDDR Hardware design
	- Set vivado tool version to 2019.1.
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/hdmi_plddr_proj.tcl

	=> For creating VCU PCIe Hardware design
	- Set vivado tool version to 2019.1.
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/vcu_pcie_proj.tcl	 
		 
	=> For creating VCU SDx Hardware design
	- Set vivado tool version to 2019.1.
	- Enter following command in Vivado shell.
		 /> vivado -source scripts/vcu_sdx_proj.tcl
	
	- Entering any of the above command will launch Vivado® tool, loads the block diagram, and adds the required top file and XDC file to the project
	- In the Flow Navigator pane on the left-hand side under Program and Debug, click Generate Bitstream.
	

For SDx design, after generating bitstream, run the following commands on Vivado Tcl Console to generate and validate dsa
	
	/>set_param dsa.writeHDFData 1
	/>set_property dsa.name vcu_sdx [current_project]
	/>write_dsa -unified -force ./vcu_sdx.dsa
	/>validate_dsa ./vcu_sdx.dsa
