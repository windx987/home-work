.data
.balign 4
message1:       .asciz  "Enter a number : "
.balign 4
scan_pattern:   .asciz  "%d"
.balign 4
new_line:       .asciz  "\n"
.balign 4
star:           .asciz  "* "
.balign 4
input:          .word   0

.text
.global main
.global printf
.global scanf

main:
    PUSH    {lr}

_input:
    LDR     r0, =message1
    BL      printf

    LDR     r0, =scan_pattern
    LDR     r1, =input
    BL      scanf

_print:
    LDR     r4, =input
    LDR     r4, [r4]
    
    MOV     r5, #0
_loop:
    LDR     r0, =star
    BL      printf
    ADD     r5, r5, #1
    CMP     r5, r4
    BNE     _loop

    MOV     r5, #0
    LDR     r0, =new_line
    BL      printf

    SUB     r4, r4, #1
    CMP     r4, #0
    BNE     _loop

end:
    POP     {lr}