.data
.balign 4
message1:       .asciz "Enter a number : "
.balign 4
scan_pattern:   .asciz  "%d"
.balign 4
0x2A:   .asciz  "* "

.text
.global main
.global printf
.global scanf

main:
    LDR     lr, =return
    STR     lr, [lr]

input:
    LDR     r0, =message1
    BL      printf

    LDR     r0, =scan_pattern
    LDR     r1, =num1
    BL      scanf

    LDR     r0, =0x2A
    BL      printf