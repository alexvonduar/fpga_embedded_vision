
TOP ?= $(PWD)

ifeq ($(TOP),)
$(error TOP directory not set)
endif

#PROJECT ?= fmchc_python1300
#BOARD ?= myir
.PHONY: fmchc_python1300c_myir7020 fmchc_python1300c_zynqdev rpi_mipi_dp_kv260 rpi_mipi_dp_me_st1_xu6

fmchc_python1300c_myir7020:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=MYIR7020 all

fmchc_python1300c_zynqdev:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=ZYNQ_DEV all

rpi_mipi_dp_kv260:
	make -C ${TOP}/kv260 TOP=${TOP} INPUT=rpi_mipi OUTPUT=dp BOARD=kv260 all

rpi_mipi_dp_me_st1_xu6:
	make -C ${TOP}/enclustra TOP=${TOP} INPUT=rpi_mipi OUTPUT=dp all
