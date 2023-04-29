.data
		.balign 4
message1: 	.asciz "Enter the first number: "

		.balign 4
message2:	.asciz  "Enter the second number: "

		.balign 4
scan_type: 	.asciz 	"%d"

		.balign 4
number1:	.word		0

		.balign 4
number2:	.word		0

		.balign 4
return:	.word		0

		.balign 4
add_text:	.asciz	"Addition: "
		
		.balign 4
mul_text:	.asciz	"Multiplication: "

		
		.text		
		.global 	main
		.global 	printf
		.global	    scanf

main:
	ldr	r1,=return
	str 	lr, [r1]

	ldr 	r0,=message1
	bl	printf

	ldr 	r0,=scan_type
	ldr	r1,=number1
	bl	scanf

	ldr 	r0,=message2
	bl	printf

	ldr 	r0,=scan_type
	ldr     r1,=number2
	bl	scanf

	ldr 	r1, =number1
	ldr 	r2, =number2
	
	add	r3, r1, r2
	mul	r4, r1, r2

	ldr	r0,=add_text
	bl	printf

	mov	r0,r3
	bl	printf

	ldr	r0,=mul_text
	bl	printf

	mov	r0,r4
	bl	printf

	ldr	lr,=return
	ldr	lr, [lr]
	bx	lr