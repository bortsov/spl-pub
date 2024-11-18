# Load generated board configuration
sinclude $(TOPDIR)/include/autoconf.mk
ifneq ($(SKIP_AUTO_CONF),yes)
sinclude $(TOPDIR)/autoconf.mk
endif

boot0_toolchain_check=$(strip $(shell if [ -x $(CROSS_COMPILE)gcc ];  then  echo yes;  fi))
ifneq ("$(boot0_toolchain_check)", "yes")
#different architectures
CROSS_COMPILE := $(TOPDIR)/../tools/toolchain/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi/bin/arm-linux-gnueabi-
$(info Define CROSS_COMPILE=$(CROSS_COMPILE));
endif

AS		= $(CROSS_COMPILE)as
LD		= $(CROSS_COMPILE)ld
CC		= $(CROSS_COMPILE)gcc
CPP		= $(CC) -E
AR		= $(CROSS_COMPILE)ar
NM		= $(CROSS_COMPILE)nm
LDR		= $(CROSS_COMPILE)ldr
STRIP		= $(CROSS_COMPILE)strip
OBJCOPY		= $(CROSS_COMPILE)objcopy
OBJDUMP		= $(CROSS_COMPILE)objdump

FLOAT_FLAGS := -mfloat-abi=softfp

COMPILEINC :=  -isystem $(shell dirname `$(CC)  -print-libgcc-file-name`)/include
SPLINCLUDE    := \
		-I$(SRCTREE)/include \
		-I$(SRCTREE)/include/arch/arm/ \
		-I$(SRCTREE)/include/configs/ \
		-I$(SRCTREE)/include/arch/$(PLATFORM)/ \
		-I$(SRCTREE)/include/openssl/

 COMM_FLAGS := -nostdinc  $(COMPILEINC) \
	-g -O0 -fno-common  $(FLOAT_FLAGS) \
	-ffunction-sections \
	-fno-builtin -ffreestanding \
	-fno-stack-protector \
	-Wall \
	-Werror \
	-Wstrict-prototypes \
	-Wno-format-security \
	-Wno-format-nonliteral \
	-Wno-unused-variable \
	-fno-delete-null-pointer-checks \
	-pipe \
	-D__KERNEL__  \
	-mthumb -mthumb-interwork \
#	-D__ARM__ \
#	-mabi=aapcs-linux \
#	-DCONFIG_ARM \
#	-D__NEON_SIMD__  \
#	-mfpu=neon \

 COMM_FLAGS += -mno-unaligned-access

C_FLAGS += $(SPLINCLUDE)   $(COMM_FLAGS)
S_FLAGS += $(SPLINCLUDE)   -D__ASSEMBLY__  $(COMM_FLAGS)
LDFLAGS_GC += --gc-sections
#LDFLAGS += --gap-fill=0xff
export LDFLAGS_GC
###########################################################

###########################################################
PLATFORM_LIBGCC = -L $(shell dirname `$(CC) $(C_FLAGS) -print-libgcc-file-name`) -lgcc
export PLATFORM_LIBGCC
###########################################################

# Allow boards to use custom optimize flags on a per dir/file basis
ALL_AFLAGS = $(AFLAGS)  $(PLATFORM_RELFLAGS) $(S_FLAGS)
ALL_CFLAGS = $(CFLAGS)  $(PLATFORM_RELFLAGS) $(C_FLAGS)
export ALL_CFLAGS ALL_AFLAGS


$(obj)%.o:	%.S
	$(CC)  $(ALL_AFLAGS) -o $@ $< -c
	echo " CC      "$< ...
$(obj)%.o:	%.c
	$(CC)  $(ALL_CFLAGS) -o $@ $< -c
	echo " CC      "$< ...

#########################################################################

# If the list of objects to link is empty, just create an empty built-in.o
cmd_link_o_target = $(if $(strip $1),\
			  $(LD) $(LDFLAGS) -r -o $@ $1,\
		      rm -f $@; $(AR) rcs $@ )

#########################################################################

