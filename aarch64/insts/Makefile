#=======================================================================
# Makefile for aarch64 isa basic test
#-----------------------------------------------------------------------

src_dir := .
dstdir := .
CPU = cortex-a76
ARCH = armv8.5-a

srcs :=
include $(src_dir)/amo/Makefile.inc

default: all

GCC_TOOLCHAIN_AARCH64 := aarch64-none-elf
AS64      := $(GCC_TOOLCHAIN_AARCH64)-as
GCC64     := $(GCC_TOOLCHAIN_AARCH64)-gcc
LD64      := $(GCC_TOOLCHAIN_AARCH64)-ld
OBJCOPY64 := $(GCC_TOOLCHAIN_AARCH64)-objcopy
OBJDUMP   := $(GCC_TOOLCHAIN_AARCH64)-objdump

ASM_OPTS_AARCH64 = -march=$(ARCH)
LINK_OPTS_NOBOOT_AARCH64 = $(LINK_OPTS_64) -T ../../link_noboot.ld

objs   := $(patsubst %.s,%.o,$(srcs))
target := $(addprefix $(dstdir)/, $(patsubst %.s,%.elf,$(srcs)))
dump   := $(addprefix $(dstdir)/, $(patsubst %.s,%.dump,$(srcs)))

$(objs): %.o: %.s
	@echo " [ASM ] $<"
	@$(AS64) $(ASM_OPTS_AARCH64) $< -o $@

$(target): $(objs)
	@echo " [LINK] $<"
	@$(LD64) $(LINK_OPTS_NOBOOT_AARCH64) $^ -o $@

$(dump): $(target)
	@echo " [OBJDUMP] $<"
	@$(OBJDUMP) --disassemble-all $< > $@

all: $(dump)

clean:
	@rm -rf $(dump) $(target) $(objs)