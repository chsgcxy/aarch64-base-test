                .section testcode, "ax", %progbits

                .global bootcode
bootcode:
                adr x0, data_ld
                adr x1, data_store
                mov x10,  xzr
                msr NZCV, x9
                msr DAIFClr, #0xf
                msr DAIFSet, #0xf

                ldr	x2, [x0]
                str	x2, [x1]

                str x2, [x1, 8]
                ldr x3, [x1, 8]
                ldr x4, [x0, 16]
                ldr x5, [x0, 24]
                str x4, [x1, 16] 
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop
                nop

                mov     x10, #0x13000000 // Tube address
                mov     w11, #0x04
                strb    w11, [x10]
                dsb     sy

.data
.balign 64, 0
data_ld:
    .dword 0x11111111
    .dword 0x22222222
    .dword 0x33333333
    .dword 0x44444444
    .dword 0x55555555
    .dword 0x66666666
    .dword 0x77777777
    .dword 0x88888888
data_store:
    .dword 0x0
    .dword 0x0
    .dword 0x0
    .dword 0x0
    .dword 0x0
    .dword 0x0
    .dword 0x0
    .dword 0x0

