/* add_mul.s */
.data
.balign 4
message1:       .asciz "Enter first number : "
.balign 4
message2:       .asciz "Enter second number : "
.balign 4
message3:       .asciz "Addition: %d\n"
.balign 4
message4:       .asciz "Multiplication: %d\n"
.balign 4
scan_pattern:   .asciz  "%d"
.balign 4
num1:           .word   0
.balign 4
num2:           .word   0
.balign 4
return:         .word   0

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

    LDR     r0, =message2
    BL      printf

    LDR     r0, =scan_pattern
    LDR     r1, =num2
    BL      scanf

Addition:
    LDR     r0, =num1
    LDR     r0, [r0]
    LDR     r1, =num2
    LDR     r1, [r1]
    ADD     r1, r1, r0

    LDR     r0, =message3
    BL      printf

Multiplication:
    LDR     r0, =num1
    LDR     r0, [r0]
    LDR     r1, =num2
    LDR     r1, [r1]
    MUL     r2, r1, r0

    LDR     r0, =message4
    MOV     r1, r2
    BL      printf

Exit:
    LDR     lr, =return 
    LDR     lr, [lr]