.data
msg:            .asciz  "Please enter a number: "
input_format:   .asciz  "%d"
input_buffer:   .skip   4
space:          .asciz  " "
x:              .asciz  "*"
newline:        .asciz  "\n"

.text
.global main
.global printf
.global scanf

main:
    PUSH    {lr}

@ ask user for input
ldr r0, =msg
bl printf
ldr r0, =input_format
ldr r1, =input_buffer
bl scanf

@ convert input to integer
ldr r0, =input_buffer
mov r1, #0
ldr r2, [r0, #0]
loop1:
    cmp r2, #10
    blt done1
    ldrb r2, [r0, #1]!
    sub r2, r2, #48
    lsl r1, r1, #1
    add r1, r1, r2
    b loop1
done1:

@ initialize loop variables
mov r3, #0          @ i
mov r4, r0          @ n
loop2:
    cmp r3, r4
    bge done2

    @ print spaces before x's
    mov r2, r4
    sub r2, r2, r3, lsr #1
    sub r2, r2, #1
    loop3:
        cmp r2, #0
        blt done3
        ldr r0, =space
        bl printf
        sub r2, r2, #1
        b loop3
    done3:

    @ print x's
    mov r2, r3, lsl #1
    add r2, r2, #1
    loop4:
        cmp r2, #0
        blt done4
        ldr r0, =x
        bl printf
        sub r2, r2, #1
        b loop4
    done4:

    @ print spaces after x's
    mov r2, r4
    sub r2, r2, r3, lsr #1
    sub r2, r2, #1
    loop5:
        cmp r2, #0
        blt done5
        ldr r0, =space
        bl printf
        sub r2, r2, #1
        b loop5
    done5:

    @ print newline
    ldr r0, =newline
    bl printf

    @ increment i
    add r3, r3, #1
    b loop2
done2:

    pop     {lr}
    bx      lr

