//-----------------------------------------------------------------------------
// hao.chen
// 2022/09/20
//-----------------------------------------------------------------------------

                .section testcode, "ax", %progbits

                .global bootcode
bootcode:
                // Initialise the register file as a safeguard against
                // spurious X propagation.
                mov     x0,  xzr
                mov     x1,  xzr
                mov     x2,  xzr
                mov     x3,  xzr
                mov     x4,  xzr
                mov     x5,  xzr
                mov     x6,  xzr
                mov     x7,  xzr
                mov     x8,  xzr
                mov     x9,  xzr
                mov     x10, xzr
                mov     x11, xzr
                mov     x12, xzr
                mov     x13, xzr
                mov     x14, xzr
                mov     x15, xzr
                mov     x16, xzr
                mov     x17, xzr
                mov     x18, xzr
                mov     x19, xzr
                mov     x20, xzr
                mov     x21, xzr
                mov     x22, xzr
                mov     x23, xzr
                mov     x24, xzr
                mov     x25, xzr
                mov     x26, xzr
                mov     x27, xzr
                mov     x28, xzr
                mov     x29, xzr
                mov     x30, xzr
                mov     sp,  x0

                // Only CPU0 prints the message and all other CPUs enter a
                // WFI state.  A CPU can determine its number within a cluster
                // reading bits[7:0] of the MPIDR (Affinity level 0 field).
                mrs     x0, mpidr_el1           // x0 == MPIDR
                and     x0, x0, #0xFF           // x0 == Affinity level 0
                cbnz    x0, wfi_spin            // WFI if not CPU0

                // CPU0:
                // Write the text one byte at a time to the tube address
                // test main
                mov x0, #0x1
                mov x1, #0x2
                adr x6, data_ld
                adr x7, data_amo
                sub	x2, x1, x0
                add	x3, x2, x0
                sub	x4, x3, x2

                str	x2, [x7]
                str x3, [x7]
                str x4, [x7]
                ldadd x1, x8, [x6]
                ldr	x2, [x7]
                ldr x3, [x7]
                ldr x4, [x7]

                mov     x0, #0x13000000 // Tube address
                adr     x1, message

loop:           ldrb    w2, [x1], #1
                cbz     w2, end         // Branch to end on NULL byte
                strb    w2, [x0]
                b       loop

end:            mov     w2, #0x04       // EOT character
                strb    w2, [x0]
                dsb     sy

wfi_spin:       wfi
                b       wfi_spin

// The message to print.  It is NULL-terminated so that the print loop
// can detect the end of the string.
                .balign 4 
message:        .asciz "Hello 64-bit World!\n\n** TEST PASSED OK **\n"


.data
.balign 64, 0
data_ld:
    .word 0x12345678
    .word 0x22222222
data_amo:
    .word 0x11111111
    .word 0x22222222
    .word 0x33333333
