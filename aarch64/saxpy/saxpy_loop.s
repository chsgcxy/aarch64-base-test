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
        .global saxpy_asm

// Saxpy loop definition
//  Argument from C:
//      w0: int N
//      x1: float a[]
//      x2: float b[]
//      s0: float constant
        .align 3
saxpy_asm:
        ld1      {v16.2S}, [x1], #8
        mov      x3, x2
        ld1      {v24.2S}, [x2], #8
        dup      v0.2S, v0.S[0]
        ld1      {v17.2S}, [x1], #8
        subs     w0, w0, #32
        ld1      {v25.2S}, [x2], #8
        blt      2f
        ld1      {v18.2S}, [x1], #8
        fmla     v24.2S, v16.2S, v0.2S
        ld1      {v26.2S}, [x2], #8
        ld1      {v19.2S}, [x1], #8
        fmla     v25.2S, v17.2S, v0.2S
1:
        ld1      {v27.2S}, [x2], #8
        ld1      {v20.2S}, [x1], #8
        fmla     v26.2S, v18.2S, v0.2S
        ld1      {v28.2S}, [x2], #8
        ld1      {v21.2S}, [x1], #8
        fmla     v27.2S, v19.2S, v0.2S
        ld1      {v29.2S}, [x2], #8
        ld1      {v22.2S}, [x1], #8
        fmla     v28.2S, v20.2S, v0.2S
        st1      {v24.2S, v25.2S}, [x3], #16
        ld1      {v30.2S}, [x2], #8
        fmla     v29.2S, v21.2S, v0.2S
        ld1      {v23.2S}, [x1], #8
        ld1      {v31.2S}, [x2], #8
        st1      {v26.2S, v27.2S}, [x3], #16
        fmla     v30.2S, v22.2S, v0.2S
        ld1      {v16.2S}, [x1], #8
        ld1      {v24.2S}, [x2], #8
        fmla     v31.2S, v23.2S, v0.2S
        ld1      {v17.2S}, [x1], #8
        st1      {v28.2S, v29.2S}, [x3], #16
        ld1      {v25.2S}, [x2], #8
        fmla     v24.2S, v16.2S, v0.2S
        ld1      {v18.2S}, [x1], #8
        ld1      {v26.2S}, [x2], #8
        subs     w0, w0, #32
        ld1      {v19.2S}, [x1], #8
        fmla     v25.2S, v17.2S, v0.2S
        st1      {v30.2S, v31.2S}, [x3], #16
        b.ge     1b
       
        adds     w0, w0, #32
        b.eq     4f
        sub      x1, x1, #32
        sub      x2, x2, #24

3:
        ldr      s1, [x1], #4
        ldr      s2, [x2]
        fmadd    s2, s1, s0, s2
        str      s2, [x2], #4
        subs     w0, w0, #1
        b.gt     3b

4:
        ret


2:
        adds     w0, w0, #32
        b.eq     4b
        sub      x1, x1, #16
        sub      x2, x2, #16
        b        3b

        .end
