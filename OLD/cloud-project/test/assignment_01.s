.global _start
_start:
    push {r4, lr}
    
    mov r6, #0
loop:
    cmp r6, #3
    beq exit

    cmp r6, #2
    bleq search

    cmp r6, #1
    bleq add_student

    mov r0, #1
    mov r2, #(choose_end-choose)
    ldr r1, =choose
    mov r7, #4
    svc 0

    mov r0, #1
    mov r2, #(choose_num_end-choose_num)
    ldr r1, =choose_num
    mov r7, #4
    svc 0

    mov r0, #0
    ldr r1, =menu_number
    mov r2, #2
    mov r7, #3
    svc 0

    ldr r6, =menu_number
    ldrb r6, [r6, #0]
    sub r6, r6, #48
    b loop

exit:
    pop {r4, lr}
    mov r7, #1
    svc 0

search:
    push {r4-r12, lr}

    mov r0, #1
    mov r2, #(search_std_end-search_std)
    ldr r1, =search_std
    mov r7, #4
    svc 0

    mov r0, #0
    ldr r1, =find_id
    mov r2, #9
    mov r7, #3
    svc 0

    bl open_file
    mov r4, r0
    
    mov r0, r4
    ldr r1, =std_info
    mov r2, #10000
    mov r7, #3
    svc 0

    mov r6, #0
    mov r8, #0

loop_search:
    ldr r5, =std_info
    ldrb r5, [r5, r6]

    cmp r5, #0
    beq not_found_std

    ldr r9, =find_std
    ldrb r9, [r9, r8]

    cmp r5, r9
    beq equal
    b not_equal

equal:
    add r8, r8, #1
    beq end_equal

not_equal:
    mov r8, #0

end_equal:
    cmp r8, #8
    beq std_match
    b end_std_match

std_match:
    mov r0, r6

    mov r9, r0
    add r9, r9, #2

    mov r0, #1
    mov r2, #(std_name_end-std_name)
    ldr r1, =std_name
    mov r7, #4
    svc 0

loop_print:
    ldr r5, =std_info
    ldrb r5, [r5, r9]

    cmp r5, #'\n'
    beq end_loop_print

    ldr r1, =char_output
    mov r2, #1
    mov r7, #4
    mov r0, #1
    svc 0

    add r9, r9, #1
    b loop_print
    
end_loop_print:
    b end_loop_search

end_std_match:
    add r6, r6, #1
    b loop_search

not_found_std:
    mov r0, #1
    mov r2, #(no_std_end-no_std+2)
    ldr r1, =no_std
    mov r7, #4
    svc 0

end_loop_search:
    bl close_file
    mov r0, r4

    pop {r4-r12, lr}
    bx lr

add_student:
    push {r4-r12, lr}

    mov r0, #1
    mov r2, #(num_std_end-num_std)
    ldr r1, =num_std
    mov r7, #4
    svc 0

    bl open_file
    mov r4, r0

/* reset file pointer with lseek*/
    mov r0, r4
    mov r1, #0
    mov r2, #2
    mov r7, #19
    svc 0

/* student id sections */
    mov r0, #0
    ldr r1, =buffer
    mov r2, #10
    mov r7, #3
    svc 0

    mov r0, r4
    ldr r1, =buffer
    mov r2, #8
    mov r7, #4
    svc 0

/* empty sections */
    mov r0, r4
    ldr r1, =empty
    mov r2, #1
    mov r7, #4
    svc 0

/* student name sections */
    mov r0, #1
    mov r2, #(name_std_end-name_std)
    ldr r1, =name_std
    mov r7, #4
    svc 0

    mov r0, #0
    ldr r1, =buffer
    mov r2, #100
    mov r7, #3
    svc 0

    mov r2, r0
    mov r0, r4
    ldr r1, =buffer
    mov r7, #4
    svc 0

    bl close_file
    mov r0, r4
    
    pop {r4-r12, lr}
    bx lr

open_file:
    push {r4-r12, lr}

    ldr r0, =filepath
    mov r0, #0x42
    mov r1, #384
    mov r7, #5
    svc 0

    cmp r0, #-1
    beq fail_to_open

    pop {r4-r12, lr}
    bx lr

fail_to_open:
    bl close_file
    b exit

close_file:
    push {r4-r12, lr}
    
    mov r0, #0
    mov r1, #0
    mov r2, #0
    mov r3, #0
    mov r4, #0

    mov r4, #6
    svc 0

    pop {r4-r12, lr}
    bx lr

.data

/*--- file path ---*/
.balign 4
filepath: .asciz "/home/pi/wind/stdfile"

/*--- functions menu ---*/
.balign 4
choose: .asciz "\n /*--------- Functions Menu (Choose No. 1-3) ---------*/ \n"
choose_end:

.balign 4
choose_num: .asciz "1.Add Student / 2.Search Student / 3.Exit Program \n Enter: "
choose_num_end:

.balign 4
menu_number: .byte 1

/*--- search function ---*/
.balign 4
search_std: .asciz "Enter Student ID: "
search_std_end:

.balign 4
std_name: .asciz "Student Name: "
std_name_end:

.balign 4
std_info: .asciz " "

.balign 4
find_std: .asciz " "

.balign 4
find_id: .asciz " "

.balign 4
char_output: .asciz " "

.balign 4
no_std: .asciz "Student ID Not Found \n"
no_std_end:

/*--- add function ---*/
.balign 4
num_std: .asciz "Enter Student ID: "
num_std_end:

.balign 4
name_std: .asciz "Enter Student Name: "
name_std_end:

.balign 4
empty: .asciz " "

.balign 4
buffer: .byte 100