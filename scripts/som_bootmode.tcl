
proc boot_jtag { } {
############################
# Switch to JTAG boot mode #
############################
targets -set -nocase -filter {name =~ "PSU"}
stop
# update multiboot to ZERO
mwr 0xffca0010 0x0
# change boot mode to JTAG
mwr 0xff5e0200 0x0100
# reset
rst -system

}

connect
ta
boot_jtag
exit

