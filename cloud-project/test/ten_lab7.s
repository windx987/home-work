.global _start
_start:
   PUSH {r4,lr} @open or create file
   LDR r0,=stdData
   MOV r1,#0x42
   MOV r2,#384
   MOV r7,#5
   SVC 0

   @can open file?
   CMP r0,#-1
   BEQ _err
   @if can open save file destination
   MOV r4,r0

   @show question
   MOV r0,#1 @stdout
   LDR r1,=question
   MOV r2,#(question_end-question)
   MOV r7,#4
   SVC 0

   BL _input
   @if choice one
   LDRB r3,[r1]
   CMP r3,#'1'
   BEQ choice_one

   CMP r3,#'2'
   BEQ choice_two

   @if choice three
   CMP r3,#'3'
   BEQ _exit

_input:
   @input
   MOV r0, #0 @stdin
   LDR r1,=buffer
   MOV r2,#81
   MOV r7,#3
   SVC 0
   MOV r5,r0 @length of that charactor
   BX lr @branch exchange to stack


choice_one:

   MOV r0,#1
   LDR r1,=stdid
   MOV r2,#(std_end-stdid)
   MOV r7,#4
   SVC 0

   BL _input
   CMP r5,#9
   BNE _err

   @lseek where the last
   MOV r0,r4
   MOV r1,#0
   MOV r2,#2
   MOV r7,#19
   SVC 0

   @write file
   MOV r0,r4
   LDR r1, =buffer
   MOV r2,#32 @space
   STRB r2,[r1,#8] @add space to character 8
   MOV r2, r5@Length of data to write
   MOV r7, #4
   SVC 0

   @name
   MOV r0,#1
   LDR r1,=name
   MOV r2, #(name_end-name)
   MOV r7,#4
   SVC 0
   BL _input

   CMP r5,#81
   BGE _err

   @lseek where the last
   MOV r0,r4
   MOV r1,#0
   MOV r2,#2
   MOV r7,#19
   SVC 0

   @write file
   MOV r0, r4 @ file descriptor
   LDR r1, =buffer
   MOV r2,r5 @ length of data to write
   MOV r7, #4
   SVC 0

   BL close_file
   B _start
close_file:
   MOV  r7, #6 @ close
   SVC 0
   MOV r0, r4 @ return file descriptor
   BX lr
choice_two:
   @open file and store
   MOV r0,r4
   LDR r1,=content_all
   MOV r2,#65536
   MOV r7,#3
   SVC 0
   MOV r10,r0 @store length of file

   @show question search
   MOV r0,#1 @stdout
   LDR r1,=search
   MOV r2,#28
   MOV r7,#4
   SVC 0

   BL _input
   CMP r5,#9
   BNE _err

   LDR r2,=content_all
   MOV r3,#0
   MOV r4,#0
_loop_to_check:
   LDRB r8,[r2,r3]
   LDRB r9,[r1,r4]
   CMP r8,r9
   ADDNE r3,r3,#1
   BNE not_one
if_found_id:
   ADD r4,r4,#1
   ADD r3,r3,#1
   LDRB r8,[r2,r3]
   LDRB r9,[r1,r4]

   B fully_id
not_one:
   CMP r3,r10
   BEQ print_not_found
   BNE _loop_to_check
fully_id:
   CMP r4,#8
   BEQ found_id
   BNE if_not_reset

if_not_reset:
   CMP r8,r9
   BEQ if_found_id
   MOVNE r4,#0
   BNE _loop_to_check
found_id:
   MOV r6,#0
   LDR r12,=buffer
   ADD r3,r3,#1
_savecha:
   LDRB r5,[r2,r3]
   STRB r5,[r12,r6]
   ADD r3,r3,#1
   ADD r6,r6,#1
   CMP r5,#'\n'
   BNE _savecha
print_found:
   LDR r1,=name
   MOV r0,#1
   MOV r2,#(name_end-name)
   MOV r7,#4
   SVC 0

   LDR r1,=buffer
   MOV r0,#1
   MOV r2,r6
   MOV r7,#4
   SVC 0
   BL close_file
   B _start

print_not_found:
   LDR r1,=donthave
   MOV r0,#1
   MOV r2,#(donthave_end-donthave)
   MOV r7,#4
   SVC 0
   BL close_file
   B _start

_err:
   LDR r1,=err
   MOV r0,#1
   MOV r2,#(err_end-err)
   MOV r7,#4
   SVC 0
_exit:
   BL close_file
   MOV r7,#1
   SVC 0

.data

stdData: .asciz "/home/pi/assignment1/std"

question: .asciz "Choose 1:Add STUDENT | 2:Search STUDENT| 3:Exit :"
question_end:

err: .asciz "ERROR\n"
err_end:

stdinput: .word 0

name: .asciz "NAME : "
name_end:

stdid: .asciz "STUDENT ID(8 Character): "
std_end:

donthave: .asciz "DONT HAVE ANY STUDENT MATCH\n"
donthave_end:

search: .asciz "Enter student id to search: "
content_all: .space 65536

buffer: .byte 100