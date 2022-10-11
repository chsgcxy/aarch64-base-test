                .section testcode, "ax", %progbits

                .global bootcode
bootcode:
                mov x0, #0x1
                mov x1, #0x2

                add x2, x0, x1
                add x3, x0, x1
                add x4, x0, x1
                add x5, x0, x1

                add x6, x0, x1
                madd x7, x6, x1, x0
                madd x8, x6, x1, x0
                add x9, x8, x7
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
