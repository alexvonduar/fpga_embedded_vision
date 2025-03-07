
TOP ?= $(PWD)

ifeq ($(TOP),)
$(error TOP directory not set)
endif

#PROJECT ?= fmchc_python1300
#BOARD ?= myir
.PHONY: myir zynqdev_fmchc_python1300c kv260_mipi

myir:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=MYIR7020 all

zynqdev_fmchc_python1300c:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=ZYNQ_DEV all

kv260_mipi:
	make -C ${TOP}/kv260  all

me_xu6_st1_mipi:
	make -C ${TOP}/enclustra all
