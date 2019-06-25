# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST   } {
  #source_ipfile "bd/bd.tcl"

  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Configuration"]
  #ipgui::add_param $IPINST -name "NO_OF_AXI_PORTS" -parent ${Page_0} -widget comboBox -layout horizontal
  ipgui::add_param $IPINST -name "REF_CLK" -parent ${Page_0} 
  set ddr4_config [ipgui::add_group $IPINST -parent $Page_0 -name "Controller_Configuration" -layout horizontal]  
     ipgui::add_param $IPINST -name "ENABLE_PORT0" -parent ${ddr4_config} -widget checkBox -layout horizontal
     ipgui::add_param $IPINST -name "PORT0_PRI" -parent ${ddr4_config} -widget comboBox -layout horizontal
     ipgui::add_row $IPINST -parent $ddr4_config
     ipgui::add_param $IPINST -name "ENABLE_PORT1" -parent ${ddr4_config} -widget checkBox -layout horizontal
     ipgui::add_param $IPINST -name "PORT1_PRI" -parent ${ddr4_config} -widget comboBox -layout horizontal
     ipgui::add_row $IPINST -parent ${ddr4_config}
     ipgui::add_param $IPINST -name "ENABLE_PORT2" -parent ${ddr4_config} -widget checkBox -layout horizontal
     ipgui::add_param $IPINST -name "PORT2_PRI" -parent ${ddr4_config} -widget comboBox -layout horizontal
     ipgui::add_row $IPINST -parent ${ddr4_config}
     ipgui::add_param $IPINST -name "ENABLE_PORT3" -parent ${ddr4_config} -widget checkBox -layout horizontal
     ipgui::add_param $IPINST -name "PORT3_PRI" -parent ${ddr4_config} -widget comboBox -layout horizontal
     ipgui::add_row $IPINST -parent ${ddr4_config}
     ipgui::add_param $IPINST -name "ENABLE_PORT4" -parent ${ddr4_config} -widget checkBox -layout horizontal
     ipgui::add_param $IPINST -name "PORT4_PRI" -parent ${ddr4_config} -widget comboBox -layout horizontal
     ipgui::add_row $IPINST -parent ${ddr4_config}
  set dram_config [ipgui::add_group $IPINST -parent $Page_0 -name "DRAM_Configuration"]  
     ipgui::add_param $IPINST -name "DRAM_WIDTH" -parent ${dram_config} -widget comboBox -layout horizontal
     ipgui::add_param $IPINST -name "DRAM_SPEED_BIN" -parent ${dram_config} -widget comboBox -layout horizontal
     ipgui::add_row $IPINST -parent $dram_config
  set dimm_config [ipgui::add_group $IPINST -parent $Page_0 -name "DIMM_Configuration"]  
     ipgui::add_param $IPINST -name "DIMM_TYPE" -parent ${dimm_config} -widget comboBox -layout horizontal
     ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${dimm_config} -widget comboBox -layout horizontal
     ipgui::add_row $IPINST -parent $dimm_config

}

proc init_params {IPINST PARAM_VALUE.ENABLE_PORT0 PARAM_VALUE.ENABLE_PORT1 PARAM_VALUE.ENABLE_PORT2 PARAM_VALUE.ENABLE_PORT3 PARAM_VALUE.ENABLE_PORT4 PARAM_VALUE.NO_OF_AXI_PORTS PARAM_VALUE.PORT0_PRI PARAM_VALUE.PORT1_PRI PARAM_VALUE.PORT2_PRI PARAM_VALUE.PORT3_PRI PARAM_VALUE.PORT4_PRI PARAM_VALUE.REF_CLK PARAM_VALUE.DRAM_SPEED_BIN PARAM_VALUE.DATA_WIDTH PARAM_VALUE.DIMM_TYPE } {
        set_property  enabled false  ${PARAM_VALUE.PORT0_PRI} 
        set_property  enabled false  ${PARAM_VALUE.PORT1_PRI} 
        set_property  enabled false  ${PARAM_VALUE.PORT2_PRI} 
        set_property  enabled false  ${PARAM_VALUE.PORT3_PRI} 
        set_property  enabled false  ${PARAM_VALUE.PORT4_PRI} 
        set_property  enabled false  ${PARAM_VALUE.ENABLE_PORT0} 
        set_property  enabled false  ${PARAM_VALUE.ENABLE_PORT1} 
        set_property  enabled false  ${PARAM_VALUE.ENABLE_PORT2} 
        set_property  enabled false  ${PARAM_VALUE.ENABLE_PORT3} 
        set_property  enabled false  ${PARAM_VALUE.ENABLE_PORT4} 
        #set_property  enabled false  ${PARAM_VALUE.DIMM_TYPE} 
     # all variables are enabled. else, we need to add the enable/disbale here
    #set_property  enabled false  ${PARAM_VALUE.DATA_WIDTH} 
}


proc update_MODELPARAM_VALUE.DIMM_VALUE_HDL { MODELPARAM_VALUE.DIMM_VALUE_HDL  PARAM_VALUE.DIMM_TYPE  } {
   set DIMM_TYPE [get_property value ${PARAM_VALUE.DIMM_TYPE}]
   if {$DIMM_TYPE == 0 } {
      set_property value 0 ${MODELPARAM_VALUE.DIMM_VALUE_HDL}
   } else {
      set_property value 1 ${MODELPARAM_VALUE.DIMM_VALUE_HDL}
   }
}

proc update_MODELPARAM_VALUE.DRAM_WIDTH_HDL { MODELPARAM_VALUE.DRAM_WIDTH_HDL  PARAM_VALUE.DRAM_WIDTH  } {
   set DRAM_WIDTH [get_property value ${PARAM_VALUE.DRAM_WIDTH}]

   if {$DRAM_WIDTH == 0 } {
      set_property value 0 ${MODELPARAM_VALUE.DRAM_WIDTH_HDL}
      #send_msg INFO 306 "DRAM_WIDTH_HDL is set as 0"
   } else {
      set_property value 1 ${MODELPARAM_VALUE.DRAM_WIDTH_HDL}
      #send_msg INFO 306 "DRAM_WIDTH_HDL is set as 1"
   }
    #send_msg INFO 306 "DRAM_WIDTH_HDL $DRAM_WIDTH "
}

proc update_PARAM_VALUE.REF_CLK { PARAM_VALUE.DRAM_WIDTH PARAM_VALUE.REF_CLK } {
   set DRAM_WIDTH [get_property value ${PARAM_VALUE.DRAM_WIDTH}]
   if {$DRAM_WIDTH == 0 } {
      set_property  value 300  ${PARAM_VALUE.REF_CLK} 
   } else {
      set_property  value 125  ${PARAM_VALUE.REF_CLK} 
   }
}



proc update_PARAM_VALUE.DIMM_TYPE { PARAM_VALUE.DRAM_WIDTH PARAM_VALUE.DIMM_TYPE } {
   set DRAM_WIDTH [get_property value ${PARAM_VALUE.DRAM_WIDTH}]
   if {$DRAM_WIDTH == 0 } {
      #set_property  value 0  ${PARAM_VALUE.DIMM_TYPE} 
   } else {
      #set_property  value 1  ${PARAM_VALUE.DIMM_TYPE} 
   }
}
proc update_PARAM_VALUE.BG_WIDTH { PARAM_VALUE.DRAM_WIDTH PARAM_VALUE.BG_WIDTH } {
   set DRAM_WIDTH [get_property value ${PARAM_VALUE.DRAM_WIDTH}]
   if {$DRAM_WIDTH == 0 } {
      set_property  value 1  ${PARAM_VALUE.BG_WIDTH} 
   } else {
      set_property  value 0  ${PARAM_VALUE.BG_WIDTH} 
   }
}


proc update_MODELPARAM_VALUE.HDL_PORT0_EN { MODELPARAM_VALUE.HDL_PORT0_EN  PARAM_VALUE.ENABLE_PORT0  } {
   set ENABLE_PORT0 [get_property value ${PARAM_VALUE.ENABLE_PORT0}]
   if {$ENABLE_PORT0 == "false" || $ENABLE_PORT0 == "FALSE" } {
      set_property value 0 ${MODELPARAM_VALUE.HDL_PORT0_EN}
   } else {
      set_property value 1 ${MODELPARAM_VALUE.HDL_PORT0_EN}
   }
}


proc validate_PARAM_VALUE.DIMM_TYPE { PARAM_VALUE.DIMM_TYPE PARAM_VALUE.DRAM_WIDTH PARAM_VALUE.DRAM_SPEED_BIN } {

	 set DIMM_TYPE [get_property value ${PARAM_VALUE.DIMM_TYPE}]
	 set DRAM_WIDTH [get_property value ${PARAM_VALUE.DRAM_WIDTH}]
	 set DRAM_SPEED_BIN [get_property value ${PARAM_VALUE.DRAM_SPEED_BIN}]

	  #x8..
	  if {$DRAM_WIDTH== 0} { 
	       if {(($DIMM_TYPE == 0 && $DRAM_SPEED_BIN == 2 ) || ($DIMM_TYPE == 1 && $DRAM_SPEED_BIN == 0)) } {
	           return true
		   } else {
               set_property errmsg "This configuration is not allowed"
	           return false
	       }
	  }  else {
	  #x16
	       if { (($DIMM_TYPE == 1 && $DRAM_SPEED_BIN == 0) || ($DIMM_TYPE == 1 && $DRAM_SPEED_BIN == 1)) } {
	           return true
		   } else {
               set_property errmsg "This configuration is not allowed"
	           return false
	       }
      }

}


proc validate_PARAM_VALUE.DRAM_SPEED_BIN { PARAM_VALUE.DRAM_SPEED_BIN PARAM_VALUE.DRAM_WIDTH } {

	 set SPEED_BIN [get_property value ${PARAM_VALUE.DRAM_SPEED_BIN}]
	 set CONF_MODE [get_property value ${PARAM_VALUE.DRAM_WIDTH}]

	  #x16.
	  if {$CONF_MODE== 1} { 
	       if {$SPEED_BIN == 0 || $SPEED_BIN == 1 } {
	           return true
		   } else {
               set_property errmsg "This configuration is not allowed"
	           return false
	       }
	  }  else {
	    #x8.
	       if { $SPEED_BIN == 2 || $SPEED_BIN == 0 } {
	           return true
		   } else {
               set_property errmsg "This configuration is not allowed"
	           return false
	       }
      }

}

#proc update_PARAM_VALUE.PORT0_PRI { PARAM_VALUE.PORT0_PRI PARAM_VALUE.ENABLE_PORT0} {
#     set ENABLE_PORT0 [get_property value ${PARAM_VALUE.ENABLE_PORT0}]
#     if {$ENABLE_PORT0 == "false" || $ENABLE_PORT0 == "FALSE" } {
#        set_property  enabled false  ${PARAM_VALUE.PORT0_PRI} 
#        #set_property visible false [ipgui::get_guiparamspec PORT0_PRI -of $IPINST]
#	 } else {
#        set_property  enabled true  ${PARAM_VALUE.PORT0_PRI} 
#        #set_property visible true [ipgui::get_guiparamspec PORT0_PRI -of $IPINST]
#	 }
#}

proc update_MODELPARAM_VALUE.HDL_PORT1_EN { MODELPARAM_VALUE.HDL_PORT1_EN  PARAM_VALUE.ENABLE_PORT1  } {
   set ENABLE_PORT1 [get_property value ${PARAM_VALUE.ENABLE_PORT1}]
   if {$ENABLE_PORT1 == "false" || $ENABLE_PORT1 == "FALSE" } {
      set_property value 0 ${MODELPARAM_VALUE.HDL_PORT1_EN}
   } else {
      set_property value 1 ${MODELPARAM_VALUE.HDL_PORT1_EN}
   }
}

#proc update_PARAM_VALUE.PORT1_PRI { PARAM_VALUE.PORT1_PRI PARAM_VALUE.ENABLE_PORT1} {
#     set ENABLE_PORT1 [get_property value ${PARAM_VALUE.ENABLE_PORT1}]
#     if {$ENABLE_PORT1 == "false" || $ENABLE_PORT1 == "FALSE" } {
#        set_property  enabled false  ${PARAM_VALUE.PORT1_PRI} 
#        #set_property visible false [ipgui::get_guiparamspec PORT1_PRI -of $IPINST]
#	 } else {
#        set_property  enabled true  ${PARAM_VALUE.PORT1_PRI} 
#        #set_property visible true [ipgui::get_guiparamspec PORT1_PRI -of $IPINST]
#	 }
#}


proc update_MODELPARAM_VALUE.HDL_PORT2_EN { MODELPARAM_VALUE.HDL_PORT2_EN  PARAM_VALUE.ENABLE_PORT2  } {
   set ENABLE_PORT2 [get_property value ${PARAM_VALUE.ENABLE_PORT2}]
   if {$ENABLE_PORT2 == "false" || $ENABLE_PORT2 == "FALSE" } {
      set_property value 0 ${MODELPARAM_VALUE.HDL_PORT2_EN}
   } else {
      set_property value 1 ${MODELPARAM_VALUE.HDL_PORT2_EN}
   }
}

#proc update_PARAM_VALUE.PORT2_PRI { PARAM_VALUE.PORT2_PRI PARAM_VALUE.ENABLE_PORT2} {
#     set ENABLE_PORT2 [get_property value ${PARAM_VALUE.ENABLE_PORT2}]
#     if {$ENABLE_PORT2 == "false" || $ENABLE_PORT2 == "FALSE" } {
#        set_property  enabled false  ${PARAM_VALUE.PORT2_PRI} 
#        #set_property visible false [ipgui::get_guiparamspec PORT2_PRI -of $IPINST]
#	 } else {
#        set_property  enabled true  ${PARAM_VALUE.PORT2_PRI} 
#        #set_property visible true [ipgui::get_guiparamspec PORT2_PRI -of $IPINST]
#	 }
#}


proc update_MODELPARAM_VALUE.HDL_PORT3_EN { MODELPARAM_VALUE.HDL_PORT3_EN  PARAM_VALUE.ENABLE_PORT3  } {
   set ENABLE_PORT3 [get_property value ${PARAM_VALUE.ENABLE_PORT3}]
   if {$ENABLE_PORT3 == "false" || $ENABLE_PORT3 == "FALSE" } {
      set_property value 0 ${MODELPARAM_VALUE.HDL_PORT3_EN}
   } else {
      set_property value 1 ${MODELPARAM_VALUE.HDL_PORT3_EN}
   }
}

#proc update_PARAM_VALUE.PORT3_PRI { PARAM_VALUE.PORT3_PRI PARAM_VALUE.ENABLE_PORT3} {
#     set ENABLE_PORT3 [get_property value ${PARAM_VALUE.ENABLE_PORT3}]
#     if {$ENABLE_PORT3 == "false" || $ENABLE_PORT3 == "FALSE" } {
#        set_property  enabled false  ${PARAM_VALUE.PORT3_PRI} 
#        #set_property visible false [ipgui::get_guiparamspec PORT3_PRI -of $IPINST]
#	 } else {
#        set_property  enabled true  ${PARAM_VALUE.PORT3_PRI} 
#        #set_property visible true [ipgui::get_guiparamspec PORT3_PRI -of $IPINST]
#	 }
#}
proc update_MODELPARAM_VALUE.HDL_PORT4_EN { MODELPARAM_VALUE.HDL_PORT4_EN  PARAM_VALUE.ENABLE_PORT4  } {
   set ENABLE_PORT4 [get_property value ${PARAM_VALUE.ENABLE_PORT4}]
   if {$ENABLE_PORT4 == "false" || $ENABLE_PORT4 == "FALSE" } {
      set_property value 0 ${MODELPARAM_VALUE.HDL_PORT4_EN}
   } else {
      set_property value 1 ${MODELPARAM_VALUE.HDL_PORT4_EN}
   }
}

#proc update_PARAM_VALUE.PORT4_PRI { PARAM_VALUE.PORT4_PRI PARAM_VALUE.ENABLE_PORT4} {
#     set ENABLE_PORT4 [get_property value ${PARAM_VALUE.ENABLE_PORT4}]
#     if {$ENABLE_PORT4 == "false" || $ENABLE_PORT4 == "FALSE" } {
#        set_property  enabled false  ${PARAM_VALUE.PORT4_PRI} 
#        #set_property visible false [ipgui::get_guiparamspec PORT4_PRI -of $IPINST]
#	 } else {
#        set_property  enabled true  ${PARAM_VALUE.PORT4_PRI} 
#        #set_property visible true [ipgui::get_guiparamspec PORT4_PRI -of $IPINST]
#	 }
#}
