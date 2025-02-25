
TOP ?= $(PWD)

ifeq ($(TOP),)
$(error TOP directory not set)
endif

#PROJECT ?= fmchc_python1300
#BOARD ?= myir
.PHONY: myir zynqdev

myir:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=MYIR7020 all

zynqdev:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=ZYNQ_DEV all
