
TOP ?= $(PWD)

ifeq ($(TOP),)
$(error TOP directory not set)
endif

#PROJECT ?= fmchc_python1300
#BOARD ?= myir
.PHONY: fmchc_python1300c_myir7020 fmchc_python1300c_zynqdev rpi_mipi_dp_kv260 rpi_mipi_dp_me_st1_xu6

fmchc_python1300c_myir7020:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=MYIR7020 FMC_BOARD=fmchc_python1300c INPUT_PORT=FMC_PYTHON1300 OUTPUT_PORT=FMC_HDMI all

fmchc_python1300c_zynqdev:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=ZYNQ_DEV FMC_BOARD=fmchc_python1300c INPUT_PORT=FMC_PYTHON1300 OUTPUT_PORT=FMC_HDMI all

fmchc_python1300c_hdmi1_zynqdev:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=ZYNQ_DEV FMC_BOARD=fmchc_python1300c INPUT_PORT=FMC_PYTHON1300 OUTPUT_PORT=HDMI1 all

fmchc_python1300c_hdmi2_zynqdev:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=ZYNQ_DEV FMC_BOARD=fmchc_python1300c INPUT_PORT=FMC_PYTHON1300 OUTPUT_PORT=HDMI2 all

mipi_hdmi2_zynqdev:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=ZYNQ_DEV INPUT_PORT=MIPI OUTPUT_PORT=HDMI2 all

mipi_hdmi1_zynqdev:
	make -C ${TOP}/myir/ TOP=${TOP} BOARD=ZYNQ_DEV INPUT_PORT=MIPI OUTPUT_PORT=HDMI1 all

rpi_mipi_dp_kv260:
	make -C ${TOP}/kv260 TOP=${TOP} INPUT=rpi_mipi OUTPUT=dp BOARD=kv260 all

rpi_mipi_dp_me_st1_xu6:
	make -C ${TOP}/enclustra TOP=${TOP} INPUT=rpi_mipi OUTPUT=dp MIPI_PORT=0 all

rpi_mipi_opsero_dp_me_st1_xu6:
	make -C ${TOP}/enclustra TOP=${TOP} INPUT=rpi_mipi_opsero OUTPUT=dp FMC_BOARD=opsero MIPI_PORT=1 all
