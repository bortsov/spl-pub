.SILENT:

#
# Makefile for sunxi bootloader
# wangwei@allwinnertech.com
#

TOPDIR=$(CURDIR)
SRCTREE=$(TOPDIR)


#Q: quit for compile
Q = @
ifeq ("$(origin V)", "command line")
VERBOSE=$(V)
endif
ifndef VERBOSE
VERBOSE=0
endif

ifeq ($(VERBOSE),1)
Q=
CMD_ECHO_SILENT := true
else
CMD_ECHO_SILENT := echo
endif

#P: platform: sun50iw3p1/sun8iw15p1 etc.
PLATFORM=NULL
ifeq ("$(origin p)", "command line")
PLATFORM=$(p)
endif

#M: compile module: nand mmc nor etc.
MODULE=NULL
ifeq ("$(origin m)", "command line")
MODULE=$(m)
endif

#ddr: compile module: dd3/lpddr3/ddr4/lpddr4
MODULE=NULL
ifeq ("$(origin ddr)", "command line")
DRAM_TYPE=$(ddr)
DRAM_TYPE_NAME=_$(DRAM_TYPE)
endif

ifeq ("$(origin b)", "command line")
BOARD=$(b)
endif

#check input param
MK_FILE_CHANGE := $(shell if [ x$(b) != x ]; then echo yes; else echo no; fi;)
ifeq (x$(MK_FILE_CHANGE),xyes)
	FILE_EXIST=$(shell if [ -f $(TOPDIR)/board/$(b)/common.mk ]; then echo yes; else echo no; fi;)
ifeq (x$(FILE_EXIST),xno)
$(info ***);
$(info ***configure plat or module not exist, Please run some configurator);
$(error exit);
endif
$(shell cp -f $(TOPDIR)/board/$(b)/common.mk $(TOPDIR)/.module.common.mk)
$(shell sed -i '$$a\DRAM_TYPE_NAME=$(DRAM_TYPE_NAME)' $(TOPDIR)/.module.common.mk)
$(shell sed -i '$$a\CURRENT_BOARD=$(BOARD)' $(TOPDIR)/.module.common.mk)
endif

#include config file
include $(TOPDIR)/mk/config.mk
include $(TOPDIR)/mk/checkconf.mk
sinclude $(TOPDIR)/.module.common.mk

CPU ?= armv7
export Q SOC TOPDIR SRCTREE CMD_ECHO_SILENT MODULE PLATFORM DRAM_TYPE_NAME CPU BOARD

MAKEFLAGS +=  --no-print-directory

ifeq (x$(MK_FILE_CHANGE),xyes)
#makefile is called to config platform, do nothing
all:
	@echo "platform set to $(PLATFORM)"
	@-ln -s $(TOPDIR)/board/$(BOARD)/commit_info.h include/commit_info.h
else
all: mkdepend
	$(MAKE) -C $(SRCTREE)/fes fes
endif


fes: mkdepend
	$(MAKE) -C $(SRCTREE)/fes fes
boot0: mkdepend

clean:
	@find $(TOPDIR) -type f \
		\( -name 'core' -o -name '*.bak' -o -name '*~' \
		-o -name '*.o'	-o -name '*.exe' -o -name '*.axf' \
		-o -name '*.elf' \
		-o -name '*.depend' \
		-o -name '*.bin' \
		-o -name '*.log' \
		-o -name '*.map' \) -print \
		| xargs rm -f

	@rm -f $(TOPDIR)/fes/fes1.lds
	@rm -f $(TOPDIR)/autoconf.mk
	@rm -f $(TOPDIR)/.module.common.mk

distclean: clean
	@rm -f $(TOPDIR)/include/config.h
	@rm -f $(TOPDIR)/include/commit_info.h
	@rm -f $(TOPDIR)/.module.common.mk
	@rm -f $(cleanfiles)

mkdepend : 
	@if [ ! -f $(TOPDIR)/.module.common.mk ]; then  \
	rm -rf autoconf.mk; \
	echo "***"; \
	echo "*** Configuration file \".module.common.mk\" not found!"; \
	echo "***"; \
	echo "*** Please run some configurator (e.g. make p=sun8iw20p1)"; \
	echo "***"; \
	exit 1; \
	fi;
	$(call update-commit-info)
depend:

PHONY +=FORCE
FORCE:
.PHONY:$(PHONY)
