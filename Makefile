
TOP ?= ${PWD}

ifeq (${TOP},)
$(error TOP directory not set)
endif

#PROJECT ?= fmchc_python1300
#BOARD ?= myir
#.PHONY: fmchc_python1300c_myir7020 fmchc_python1300c_zynqdev rpi_mipi_dp_kv260 rpi_mipi_dp_me_st1_xu6
.PHONY: all

#get VIVADO version
VIVADO_VER = $(shell vivado -version | grep -oP 'vivado\s+v\K[0-9]+\.[0-9]+' | head -1)

ifeq (${VIVADO_VER},)
$(error Vivado not found in PATH)
endif

SUPPORTED_BOARDS ?= myir7020 zynqdev kv260 me_st1_xu6_2cg
SUPPORTED_FMC_BOARDS ?= fmchc_python1300c opsero fl1404 none
SUPPORTED_INPUT_PORTS ?= fmc_python1300c fmc_hdmi fmc_mipi0 fmc_mipi1 fmc_mipi2 fmc_mipi3 mipi0 mipi1 fmc_imx274 ias0 ias1
SUPPORTED_OUTPUT_PORTS ?= fmc_hdmi hdmi0 hdmi1 hdmi2 ps_dp
TARGETS ?=


BOARDS ?= ${SUPPORTED_BOARDS}
FMC_BOARDS ?= ${SUPPORTED_FMC_BOARDS}
INPUT_PORTS ?= ${SUPPORTED_INPUT_PORTS}
OUTPUT_PORTS ?= ${SUPPORTED_OUTPUT_PORTS}

$(foreach BOARD, ${BOARDS}, \
	$(if $(filter ${BOARD}, ${SUPPORTED_BOARDS}), , \
		$(error BOARD ${BOARD} is not supported. Supported BOARDS: ${SUPPORTED_BOARDS})) \
)

$(foreach FMC_BOARD, ${FMC_BOARDS}, \
	$(if $(filter ${FMC_BOARD}, ${SUPPORTED_FMC_BOARDS}), , \
		$(error FMC_BOARD ${FMC_BOARD} is not supported. Supported FMC_BOARDS: ${SUPPORTED_FMC_BOARDS})) \
)

$(foreach INPUT_PORT, ${INPUT_PORTS}, \
	$(if $(filter ${INPUT_PORT}, ${SUPPORTED_INPUT_PORTS}), , \
		$(error INPUT_PORT ${INPUT_PORT} is not supported. Supported INPUT_PORTS: ${SUPPORTED_INPUT_PORTS})) \
)

$(foreach OUTPUT_PORT, ${OUTPUT_PORTS}, \
	$(if $(filter ${OUTPUT_PORT}, ${SUPPORTED_OUTPUT_PORTS}), , \
		$(error OUTPUT_PORT ${OUTPUT_PORT} is not supported. Supported OUTPUT_PORTS: ${SUPPORTED_OUTPUT_PORTS})) \
)

SUPPORTED_TARGETS := \
BOARD=myir7020:FMC_BOARD=fmchc_python1300c:INPUT_PORT=fmc_python1300c:OUTPUT_PORT=fmc_hdmi \
BOARD=zynqdev:FMC_BOARD=fmchc_python1300c:INPUT_PORT=fmc_python1300c:OUTPUT_PORT=fmc_hdmi \
BOARD=zynqdev:FMC_BOARD=fmchc_python1300c:INPUT_PORT=fmc_python1300c:OUTPUT_PORT=hdmi1 \
BOARD=zynqdev:FMC_BOARD=fmchc_python1300c:INPUT_PORT=fmc_python1300c:OUTPUT_PORT=hdmi2 \
BOARD=zynqdev:FMC_BOARD=fmchc_python1300c:INPUT_PORT=mipi1:OUTPUT_PORT=fmc_hdmi \
BOARD=zynqdev:FMC_BOARD=none:INPUT_PORT=mipi1:OUTPUT_PORT=hdmi2 \
BOARD=zynqdev:FMC_BOARD=none:INPUT_PORT=mipi1:OUTPUT_PORT=hdmi1 \
BOARD=kv260:FMC_BOARD=none:INPUT_PORT=mipi0:OUTPUT_PORT=ps_dp \
BOARD=me_st1_xu6_2cg:FMC_BOARD=none:INPUT_PORT=mipi0:OUTPUT_PORT=ps_dp \
BOARD=me_st1_xu6_2cg:FMC_BOARD=none:INPUT_PORT=mipi1:OUTPUT_PORT=ps_dp \
BOARD=me_st1_xu6_2cg:FMC_BOARD=opsero:INPUT_PORT=fmc_mipi1:OUTPUT_PORT=ps_dp \
BOARD=me_st1_xu6_2cg:FMC_BOARD=opsero:INPUT_PORT=fmc_mipi2:OUTPUT_PORT=ps_dp


# select targets based on variables
TOP_DIR :=
$(foreach b,${BOARDS},\
	$(foreach f,${FMC_BOARDS},\
		$(foreach i,${INPUT_PORTS},\
			$(foreach o,${OUTPUT_PORTS},\
				$(if $(filter BOARD=${b}:FMC_BOARD=${f}:INPUT_PORT=${i}:OUTPUT_PORT=${o},${SUPPORTED_TARGETS}),\
					$(eval TOP_DIR := ${b}) \
					$(eval TOP_DIR := $(subst myir7020, myir, $(TOP_DIR))) \
					$(eval TOP_DIR := $(subst zynqdev, myir, $(TOP_DIR))) \
					$(eval TOP_DIR := $(subst me_st1_xu6_2cg, enclustra, $(TOP_DIR))) \
					$(eval TARGETS += ${TOP}/${TOP_DIR}:TOP=${TOP}:BOARD=${b}:FMC_BOARD=${f}:INPUT_PORT=${i}:OUTPUT_PORT=${o})\
				)\
			)\
		)\
	)\
)


# Main build target
# iterate over all selected targets and invoke make in each
all:
	@$(foreach t,${TARGETS},$(MAKE) -C $(subst :, , ${t}) all;)
