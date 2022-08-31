//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2011-2014 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : $Date: 2014-07-25 09:52:11 +0100 (Fri, 25 Jul 2014) $
//
//      Revision            : $Revision: 285788 $
//
//      Release Information : CORTEXA53-r0p4-00rel1
//
//------------------------------------------------------------------------------

        .section testcode, "ax", %progbits
        .code 32
        .global saxpy_asm

// Saxpy loop definition
//  Argument from C:
//      r0: int N
//      r1: float a[]
//      r2: float b[]
//      r3: float constant
        .align 3
saxpy_asm:
        vld1.32  {d16}, [r1]!
        mov      r12, r2
        vld1.32  {d24}, [r2]!
        vdup.32  d0, r3
        vld1.32  {d17}, [r1]!
        subs     r0, r0, #32
        vld1.32  {d25}, [r2]!
        blt      2f
        vld1.32  {d18}, [r1]!
        vfma.f32 d24, d16, d0
        vld1.32  {d26}, [r2]!
        vld1.32  {d19}, [r1]!
        vfma.f32 d25, d17, d0
1:
        vld1.32  {d27}, [r2]!
        vld1.32  {d20}, [r1]!
        vfma.f32 d26, d18, d0
        vld1.32  {d28}, [r2]!
        vld1.32  {d21}, [r1]!
        vfma.f32 d27, d19, d0
        vld1.32  {d29}, [r2]!
        vld1.32  {d22}, [r1]!
        vfma.f32 d28, d20, d0
        vst1.32  {d24, d25}, [r12]!
        vld1.32  {d30}, [r2]!
        vfma.f32 d29, d21, d0
        vld1.32  {d23}, [r1]!
        vld1.32  {d31}, [r2]!
        vst1.32  {d26, d27}, [r12]!
        vfma.f32 d30, d22, d0
        vld1.32  {d16}, [r1]!
        vld1.32  {d24}, [r2]!
        vfma.f32 d31, d23, d0
        vld1.32  {d17}, [r1]!
        vst1.32  {d28, d29}, [r12]!
        vld1.32  {d25}, [r2]!
        vfma.f32 d24, d16, d0
        vld1.32  {d18}, [r1]!
        vld1.32  {d26}, [r2]!
        subs     r0, r0, #32
        vld1.32  {d19}, [r1]!
        vfma.f32 d25, d17, d0
        vst1.32  {d30, d31}, [r12]!
        bge      1b
       
        adds     r0, r0, #32
        bxeq     lr
        sub      r1, r1, #32
        sub      r2, r2, #24

3:
        vldm     r1!, {s1}
        vldr     s2, [r2]
        vfma.f32 s2, s1, s0
        vstm     r2!, {s2}
        subs     r0, r0, #1
        bgt      3b

        bx       lr


2:
        adds     r0, r0, #32
        bxeq     lr
        sub      r1, r1, #16
        sub      r2, r2, #16
        b        3b

        .end
