#IP Integrator’s bd/bd.tcl
#cellPath: path to the cell instance


proc post_config_ip {cellPath otherInfo } {
#bd::send_msg -of $cellPath -type INFO -msg_id 17 -text ": "
}


proc init { cellPath otherInfo } {
#bd::send_msg -of $cellPath -type INFO -msg_id 17 -text ": pruthvi from Init "
}

#changes for promote
#
proc propagate {cellPath otherInfo } {
  set ip [get_bd_cells $cellPath]
  set dimm_type     [get_property CONFIG.DIMM_TYPE $ip]
  set dram_width  [get_property CONFIG.DRAM_WIDTH $ip]
  set dram_speed_bin  [get_property CONFIG.DRAM_SPEED_BIN $ip]
 #bd::send_msg -of $cellPath -type INFO -msg_id 17 -text ": from Propagate  ."
 #2400, x8
  if {$dram_speed_bin == 0 && $dram_width == 0 } { 
     set inp_freq 300000000
     set outFreq [ expr ($inp_freq*5)/(6) ]
 #2133, x8
  } elseif {$dram_speed_bin == 2 && $dram_width == 0} {
     set inp_freq 300000000
     set outFreq [ expr ($inp_freq*16)/(3*6) ]
 #2400, x16
  } elseif {$dram_speed_bin == 0 && $dram_width == 1 } {
     set inp_freq 125000000
     set outFreq [ expr ($inp_freq*8)/(4) ]
 #2666, x16
  } elseif {$dram_speed_bin == 1 && $dram_width == 1} {
     set inp_freq 125000000
	 set outFreq [ expr ($inp_freq*8)/(4) ]
  } else {
     set inp_freq 120000000
     set outFreq [ expr ($inp_freq*5)/(6*4) ]
  }
  
  set_property CONFIG.FREQ_HZ $outFreq [get_bd_pins $ip/UsrClk]
}

proc pre_propagate { cellPath otherInfo } {
#bd::send_msg -of $cellPath -type INFO -msg_id 17 -text ": pruthviraj from Pre-Propagate  ."
}

proc post_propagate {cellPath otherInfo} {
#bd::send_msg -of $cellPath -type INFO -msg_id 17 -text ": pruthviraj from Post Propogate  ."
}
