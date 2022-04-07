# biblioteca.asm

# DESC: Biblioteca de funções em assembly

# Data: 13/08/2021

.macro return0
	addiu	$v0, $zero, 10
	syscall
.end_macro

.macro printInt(%d)
	addiu	$v0, $zero, 1
	addu	$a0, $zero, %d
	syscall
.end_macro

.macro printStr(%s)
	addiu	$v0, $zero, 4
	la	$a0, %s
	syscall
.end_macro

.macro printNL
	addiu	$v0, $zero, 4
	la	$a0, nl
	syscall
.end_macro

.macro readInt(%Int)
	addiu	$v0, $zero, 5
	syscall
	addu	%Int, $zero, $v0
.end_macro

.macro PUSH
	addi	$sp, $sp, -60
	sw	$ra, 4($sp)
	sw	$a0, 8($sp)
	sw	$a1, 12($sp)
	sw	$a2, 16($sp)
	sw	$a3, 20($sp)
	sw	$v0, 24($sp)
	sw	$v1, 28($sp)
	sw	$s0, 32($sp)
	sw	$s1, 36($sp)
	sw	$s2, 40($sp)
	sw	$s3, 44($sp)
	sw	$s4, 48($sp)
	sw	$s5, 52($sp)
	sw	$s6, 56($sp)
	sw	$s7, 60($sp)
.end_macro

.macro POP
	lw	$ra, 4($sp)
	lw	$a0, 8($sp)
	lw	$a1, 12($sp)
	lw	$a2, 16($sp)
	lw	$a3, 20($sp)
	lw	$v0, 24($sp)
	lw	$v1, 28($sp)
	lw	$s0, 32($sp)
	lw	$s1, 36($sp)
	lw	$s2, 40($sp)
	lw	$s3, 44($sp)
	lw	$s4, 48($sp)
	lw	$s5, 52($sp)
	lw	$s6, 56($sp)
	lw	$s7, 60($sp)
	addi	$sp, $sp, 60
.end_macro


.data
	nl:	.asciiz	"\n"
