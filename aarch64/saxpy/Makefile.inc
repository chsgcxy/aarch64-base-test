#-----------------------------------------------------------------------------
# The confidential and proprietary information contained in this file may
# only be used by a person authorised under and to the extent permitted
# by a subsisting licensing agreement from ARM Limited.
#
#            (C) COPYRIGHT 2013-2014 ARM Limited.
#                ALL RIGHTS RESERVED
#
# This entire notice must be reproduced on all copies of this file
# and copies of this file may only be made by a person if such person is
# permitted to do so under the terms of a subsisting license agreement
# from ARM Limited.
#
#      SVN Information
#
#      Checked In          : $Date: 2013-02-07 13:41:55 +0000 (Thu, 07 Feb 2013) $
#
#      Revision            : $Revision: 236479 $
#
#      Release Information : CORTEXA53-r0p4-00rel1
#
#-----------------------------------------------------------------------------
# Makefile include file for AArch64 saxpy. This must be included from the
# top-level Makefile; it is not a standalone Makefile.
#-----------------------------------------------------------------------------

# Note these variables must only be used in places where Make reads their
# immediate values rather than their deferred values.  This is because all
# the include files use the same variables and the deferred evaluation will
# yeild the last values set by the last include file.  They can be used in the
# target and prerequisite sections of rule definitions, which are evaluated
# immediately, but not in the recipe, where evaluation is deferred.
srcdir        := aarch64/saxpy
common_srcdir := common/saxpy
libdir        := common/shared
dstdir        := aarch64/saxpy
target        := $(dstdir)/saxpy.elf
asmsrcs       := $(wildcard $(srcdir)/*.s)
csrcs         := $(wildcard $(common_srcdir)/*.c)
libsrcs       := $(wildcard $(libdir)/*.c)
asmobjs       := $(patsubst %.s,%.o,$(asmsrcs))
cobjs         := $(patsubst $(common_srcdir)/%.c,$(dstdir)/%.o,$(csrcs)) \
                 $(patsubst $(libdir)/%.c,$(dstdir)/%.o,$(libsrcs))

# Find common C files (the source files are not in the build target directory)
vpath %.c $(common_srcdir) $(libdir)

$(asmobjs): %.o: %.s
	@echo " [ASM ] $<"
	@$(ASM64) $(ASM_OPTS_AARCH64) $< -o $@

$(cobjs): $(dstdir)/%.o: %.c
	@echo " [CC  ] $<"
	@$(CC64) $(CC_OPTS_AARCH64) -I$(common_shared) $< -o $@

$(target): $(asmobjs) $(cobjs) $(aarch64_bootobj)
	@echo " [LINK] $<"
	@$(CC64) $(LINK_OPTS_CSRC_AARCH64) $^ -o $@

