                .section testcode, "ax", %progbits

                .global bootcode
bootcode:
                # init register x0 ~ x9
                mov x0, xzr
                mov x1, #1
                mov x2, #4
                mov x3, #7
                mov x4, #8
                mov x5, #-1
                mov x6, #-2
                mov x7, #-4
                mov x8, #-8
                mov x9, #243

                # add imm
                add x10, x0, #4
                add x10, x0, #4, LSL #0
                add x10, x0, #4, LSL #12

                # adds
                adds x10, x0, #4
                adds x10, x5, #4, LSL #0
                adds x10, x3, #4, LSL #12

                # sub imm
                sub x10, x0, #4
                sub x10, x0, #4, LSL #0
                sub x10, x0, #4, LSL #12

                # subs
                subs x10, x0, #4
                subs x10, x5, #4, LSL #0
                subs x10, x3, #4, LSL #12

                # and, orr, eor, ands
                and x10, x1, #0x7ff
                orr x10, x1, #0x7ff
                eor x10, x1, #0x7ff
                ands x10, x1, #0x7ff
                and	w10, w1, #0xc1ffc1ff

                # add shift register, lat=1, pip=I
                add x10, x0, x1, LSL #0
                add x10, x0, x1, LSL #3

                # add shift register, lat=2, pip=M
                add x10, x0, x6, LSR #1
                add x10, x0, x1, LSL #8

                # add extend, fs=1
                add x11, x1, w6, SXTW
                add x11, x1, w6, UXTW
                add x11, x1, w6, SXTB
                add x11, x1, w6, UXTH

                # add extend, fs=0
                add w11, w1, w6, SXTW
                add w11, w1, w6, UXTW
                add w11, w1, w6, SXTB
                add w11, w1, w6, UXTH

                add w11, w1, w6, SXTB #2
                add x11, x1, w6, SXTB #2

                adr x12, data
                adrp x13, data


                # exit simulator
                mov     x10, #0x13000000 // Tube address
                mov     w11, #0x04
                strb    w11, [x10]
                dsb     sy

.data
.balign 64, 0
data:
    .dword 0x11111111
    .dword 0x22222222
    .dword 0x33333333
    .dword 0x44444444
    .dword 0x55555555
    .dword 0x66666666
    .dword 0x77777777
    .dword 0x88888888
