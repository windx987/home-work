.global _start
_start:
    push {r4, lr}
    ldr r0,=filepath
    mov r1,#0x42
    mov r2,#384
    mov r7,#5
    svc 0
    
    @can open file?
    cmp r0,#-1
    beq error

    @if can open save file destination
    mov r4,r0
    mov r6, #0

    mov r0, #1
    mov r2, #(choose_end-choose)
    ldr r1, =choose
    mov r7, #4
    svc 0

try_again:
    mov r0, #1
    mov r2, #(choose_num_end-choose_num)
    ldr r1, =choose_num
    mov r7, #4
    svc 0

    bl _input
    ldrb r6,[r1]

    cmp r5,#2
    bne wrong

    cmp r6, #'1'
    beq add_student

    cmp r6, #'2'
    beq search

    cmp r6, #'3'
    beq exit

wrong:
    mov r0, #1
    mov r2, #(again_end-again)
    ldr r1, =again
    mov r7, #4
    svc 0

    b try_again

_input: @input
    mov r0, #0 @stdin
    ldr r1,=buffer
    mov r2,#81
    mov r7,#3
    svc 0

    mov r5,r0 @length of that charactor
    bx lr @branch exchange to stack

exit:
    pop {r4, lr}
    mov r7, #1
    svc 0

add_student: @function 1
    mov r0, #1
    mov r2, #(num_std_end-num_std)
    ldr r1, =num_std
    mov r7, #4
    svc 0

   bl _input

   cmp r5,#9
   bne error
   
   /* reset file pointer with lseek*/
    mov r0, r4
    mov r1, #0
    mov r2, #2
    mov r7, #19
    svc 0

    /* write student id sections */
    mov r0,r4
    ldr r1, =buffer
    mov r2,#32 @space
    strb r2,[r1,#8] @add space to character 8
    mov r2, r5 @Length of data to write
    mov r7, #4
    svc 0

    /* student name sections */
    mov r0, #1
    mov r2, #(name_std_end-name_std)
    ldr r1, =name_std
    mov r7, #4
    svc 0

    bl _input

    cmp r5,#81
    bge error

   /* reset file pointer with lseek*/
    mov r0, r4
    mov r1, #0
    mov r2, #2
    mov r7, #19
    svc 0

    /* write student name sections */
    mov r0, r4 @ file descriptor
    ldr r1, =buffer
    mov r2,r5 @ length of data to write
    mov r7, #4
    svc 0

    bl close_file
    b _start

close_file:
    mov  r7, #6 @ close
    svc 0
    mov r0, r4 @ return file descriptor
    bx lr   

search: @function 2
    mov r0,r4
    ldr r1,=content_all
    mov r2,#65536
    mov r7,#3
    svc 0
    mov r10,r0 @store length of file

    mov r0, #1
    mov r2, #(search_std_end-search_std)
    ldr r1, =search_std
    mov r7, #4
    svc 0

    bl _input

    cmp r5,#9
    bne error

    ldr r2,=content_all
    
    mov r3,#0
    mov r4,#0
_loop_to_check:
    ldrb r8,[r2,r3]
    ldrb r9,[r1,r4]

    cmp r8,r9
    addne r3,r3,#1
    bne not_one

if_found_id:
    add r4,r4,#1
    add r3,r3,#1

    ldrb r8,[r2,r3]
    ldrb r9,[r1,r4]

    b fully_id

not_one:
    cmp r3,r10
    beq print_not_found
    bne _loop_to_check

fully_id:
    cmp r4,#8
    beq found_id
    bne if_not_reset

if_not_reset:
    cmp r8,r9
    beq if_found_id
    movne r4,#0
    bne _loop_to_check

found_id:
    mov r6,#0
    ldr r12,=buffer
    add r3,r3,#1

_savecha:
    ldrb r5,[r2,r3]
    strb r5,[r12,r6]
    add r3,r3,#1
    add r6,r6,#1
    cmp r5,#'\n'
    bne _savecha

print_found:
    ldr r1,=name
    mov r0,#1
    mov r2,#(name_end-name)
    mov r7,#4
    svc 0

    ldr r1,=buffer
    mov r0,#1
    mov r2,r6
    mov r7,#4
    svc 0
    bl close_file
    b _start

print_not_found:
    ldr r1,=no_std
    mov r0,#1
    mov r2,#(no_std_end-no_std)
    mov r7,#4
    svc 0
    bl close_file
    b _start

error:
   ldr r1,=err
   mov r0,#1
   mov r2,#(err_end-err)
   mov r7,#4
   svc 0

.data

/*--- file path ---*/
.balign 4
filepath: .asciz "/home/pi/game/stdfile"

/*--- functions menu ---*/
.balign 4
choose: .asciz "\n /*--------- Functions Menu (Choose No. 1-3) ---------*/ \n"
choose_end:

.balign 4
choose_num: .asciz "1.add Student / 2.Search Student / 3.Exit Program \n Enter: "
choose_num_end:

/*--- input ---*/
.balign 4
input: .word 0
buffer: .byte 100

/*--- error ---*/
.balign 4
err: .asciz "ERROR\n"
err_end:

.balign 4
no_std: .asciz "Student ID Not Found \n"
no_std_end:

.balign 4
again: .asciz "\n -- Wrong input  -- \n"
again_end:

/*--- add function ---*/
.balign 4
num_std: .asciz "Enter Student ID: "
num_std_end:

.balign 4
name_std: .asciz "Enter Student Name: "
name_std_end:

/*--- search function ---*/
.balign 4
search_std: .asciz "Enter Student ID: "
search_std_end:

content_all: .space 65536

name: .asciz "NAME : "
name_end:
