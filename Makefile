
TOP ?= $(PWD)

ifeq ($(TOP),)
$(error TOP directory not set)
endif

#PROJECT ?= fmchc_python1300
#BOARD ?= myir
.PHONY: myir

myir:
	#@echo "TOP ${TOP}"
	make -C ${TOP}/$@/ TOP=${TOP} all
