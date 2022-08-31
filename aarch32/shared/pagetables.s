//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2013-2016 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          :  $
//
//      Revision            :  $
//
//      Release Information : CORTEXA53-r0p4-00rel1
//
//-------------------------------------------------------------------------------
// Description:
//
//   Set up translation tables for the execution_tb tests.  Short descriptor
//   format sections are used, each defining 1MB of the memory space.
//
//   The 1MB region containing the validation peripherals is marked as
//   strongly ordered.  The rest of the memory space is marked as normal
//   shareable memory.
//-------------------------------------------------------------------------------

                .section pagetables, "ax", %progbits
                .align 14       // Align on 16k boundary
                .global ttb0_base

ttb0_base:
                .set ADDR, 0x000  // Current page address

                // 0x0000_0000 - 0x12FF_FFFF : Normal
                .rept 0x130  // Address range
                .word 0x00001C0E + (ADDR << 20)
                .set ADDR, ADDR+1
                .endr

                // Validation peripheral memory is device + XN + PXN
                //   0x1300_0000 - 0x13FF_FFFF
                .rept 0x140-0x130  // Address range
                .word 0x00010C13 + (ADDR << 20)
                .set ADDR, ADDR+1
                .endr

                // 0x1400_0000 - 0xFFFF_FFFF : Normal
                .rept (0x1000-0x140)  // Address range
                .word 0x00001C0E + (ADDR << 20)
                .set ADDR, ADDR+1
                .endr

                .end

