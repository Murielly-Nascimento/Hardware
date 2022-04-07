# Autora: Murielly
# Data: 11/10/2021
#
# Desc: Escreva um programa em assembly mips que salva os números de 1 a 10 na memória.
# a seguir leia os números da memória, calcule seu quadrado e salve novamente na memória. 
# Converta o programa para código de máquina e execute-o no simulador do mips monociclo v5.5 
# disponível nos arquivos da disciplina.

.include "bibliUtil.asm"

.data
	.align 2
	vetor: .space 40

.text
	la	$a1, vetor
	addi	$s0, $zero, 1	# i = 1;
	addi	$a2, $zero, 11
	
	
FOR:	slt	$t0, $s0, $a2	# i < 10 ? Se sim t0 = 1, se não t0 = 0 
	beq	$t0, $zero, RESPOSTA

	sw	$s0, 0($a1)	# v[i] = v[i] * v[i]
	
	addi	$s0, $s0, 1	# i++
	addi	$a1, $a1, 4	# v[i]++
	j	FOR
	
RESPOSTA:
	la	$a1, vetor
	addi	$s0, $zero, 1	# i = 1;

FOR2:	slt	$t0, $s0, $a2	# i < 10 ? Se sim t0 = 1, se não t0 = 0 
	beq	$t0, $zero, EXIT
	
	lw	$s1, 0($a1)	# s1 = v[i]
	mult	$s1, $s1	# s1*s1
	mflo	$s3
	sw	$s3, 0($a1)	# v[i] = v[i] * v[i]
	
	addi	$s0, $s0, 1	# i++
	addi	$a1, $a1, 4	# v[i]++
	j	FOR2
	
EXIT:
	return0
	
