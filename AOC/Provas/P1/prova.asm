# prova.asm

# DESC: Exercício da P1

# Data: 23/08/2021

# int main(void){
#	int v[42] = {0};
#	for(int i=0; i< 42; i++)
#		scanf("%d",&v[i]);
#	Soma = soma(v);
#	Menor = menor(v);
#	Maior = maior(v);
#	
#	printf("Soma: %d\n", Soma);
#	printf("Menor: %d\n", Menor);
#	printf("Maior: %d\n", Maior);
#
#	return 0;
# }

.include "bibliUtil.asm"

.data
	.align 2
	v:	.word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	str1:	.asciiz "Bem vindo!"
	str2:	.asciiz "Digite um número: "
	str3:	.asciiz "Soma: "
	str4:	.asciiz "Menor: "
	str5:	.asciiz "Maior: "
	
.text
	printStr(str1)
	printNL
	addu	$s0, $zero, $zero	# i = 0
	la	$s1, v			# ponteiro para vetor
	
FOR:	slti	$t0, $s0, 42		# s0 < 42? Se sim t0 = 1, se não t0 = 0
	beq	$t0, $zero, SAI_FOR
	
	# scanf("%d",&v[i]);
	printStr(str2)
	readInt($s3)
	sw $s3, 0($s1)			
	
	addiu	$s0, $s0, 1		# i++
	addiu	$s1, $s1, 4		# ponteiro ++
	j	FOR	
	
SAI_FOR:
	
	la	$s1, v			# ponteiro aponta para a primeira posição
	jal	SOMA
	addu 	$t0, $zero, $v0
	printStr(str3)
	printInt($t0)
	printNL
	
	jal	MENOR
	addu 	$t0, $zero, $v0
	printStr(str4)
	printInt($t0)
	printNL
	
	jal	MAIOR
	addu 	$t0, $zero, $v0
	printStr(str5)
	printInt($t0)
	printNL
	
	return0
	
### FUNÇÕES ###

SOMA:	addi	$sp, $sp, -60
	sw	$s1, 4($sp)

	addu 	$s2, $zero, $zero	# soma = 0;
	addu	$s0, $zero, $zero	# i = 0
	
	FOR1:	slti	$t0, $s0, 42		# s0 < 42? Se sim t0 = 1, se não t0 = 0
		beq	$t0, $zero, SAI_FOR1
	
		lw   $t1, 0($s1)	
		addu $s2, $s2, $t1		# soma+= v[i] 		
		
		addiu	$s0, $s0, 1		# i++
		addiu	$s1, $s1, 4		# ponteiro ++
		j	FOR1	
	
	SAI_FOR1:
	
		lw	$s1, 4($sp)
		addi	$sp, $sp, 60
		
		addu $v0, $zero, $s2	# return soma;
		jr	$ra
		
MENOR:
	addi	$sp, $sp, -60
	sw	$s1, 4($sp)
	
	lw   $t1, 0($s1)		# t1 = v[0]
	addu 	$s2, $zero, $t1		# menor = t1;
	addu	$s0, $zero, $zero	# i = 0
	
	FOR2:	slti	$t0, $s0, 42		# s0 < 42? Se sim t0 = 1, se não t0 = 0
		beq	$t0, $zero, SAI_FOR2
	
		lw   $t1, 0($s1)	
		
		slt	$t2, $t1, $s2		# t1 < s2? Se sim t2 = 1, se não t0 = 0
		beq	$t2, $zero, SAI_IF
		
		addu	$s2, $zero, $t1		# s2 = t1
		
	SAI_IF:	
		
		addiu	$s0, $s0, 1		# i++
		addiu	$s1, $s1, 4		# ponteiro ++
		j	FOR2	
	
	SAI_FOR2:
	
		lw	$s1, 4($sp)
		addi	$sp, $sp, 60
	
		addu $v0, $zero, $s2	# return menor;
		jr	$ra
		
MAIOR:
	addi	$sp, $sp, -60
	sw	$s1, 4($sp)
	
	lw   $t1, 0($s1)		# t1 = v[0]
	addu 	$s2, $zero, $t1		# maior = t1;
	addu	$s0, $zero, $zero	# i = 0
	
	FOR3:	slti	$t0, $s0, 42		# s0 < 42? Se sim t0 = 1, se não t0 = 0
		beq	$t0, $zero, SAI_FOR3
	
		lw   $t1, 0($s1)	
		
		slt	$t2, $s2, $t1		# s2 < t1? Se sim t2 = 1, se não t0 = 0
		beq	$t2, $zero, SAI_IF1
		
		addu	$s2, $zero, $t1		# s2 = t1
		
	SAI_IF1:	
		
		addiu	$s0, $s0, 1		# i++
		addiu	$s1, $s1, 4		# ponteiro ++
		j	FOR3	
	
	SAI_FOR3:
	
		lw	$s1, 4($sp)
		addi	$sp, $sp, 60
	
		addu $v0, $zero, $s2	# return maior;
		jr	$ra
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	