# trabalho.asm

# DESC: Escreva um programa em assembly MIPS que leia um arquivo contendo mil números inteiros não ordenados. 
#	A seguir implemente um o algoritmo de ordenação qualquer que ordene os números lidos e finalmente imprima o arquivo ordenado na saída padrão. 
#	Utilize funções. Uma para a leitura do arquivo, outra para o algoritmo de ordenação e finalmente uma para a impressão dos números ordenados.

# Data: 30/08/2021

.include "bibliUtil.asm"

.data 
	.align 2
	str:	.asciiz	"teste.txt"
	str1:	.asciiz "Bem vindo ao trabalho de AOC"
	v:	.space 4000
	aux:	.space 16
	buffer: .space 4
	
	
.text
	printStr(str1)
	printNL
	
	# Abrir arquivo para leitura
	openFile(str)           
	move 	$s0, $v0         # salva o descritor do aqruivo 


	# Lendo do arquivo
	jal READING
	
	# Fechando o arquivo
	closeFile($s0)
	
	# Parâmetros da função SORT
	la	$a0, v
	addiu	$a1,$zero,1000		# Coloque aqui o tamanho do seu vetor
	jal SORT
	
	jal PRINT
	         	      
	return0
	
READING: 
	addi	$sp, $sp, -60		
	sw	$s0, 4($sp)		# Salvamos o descritor do arquivo
	
	li   	$v0, 14        # system call para leitura de arquivos
	la   	$a1, buffer    # endereço do buffer
	move 	$a0, $s0       # descritor do arquivo
	li   	$a2,  20       
	syscall 
	
	move	$a0, $a1 		#a0 contém o buffer  
	addu	$t0, $zero, $zero   	#t0 é nosso contador
	lb	$t1, buffer($t0)	#t1 armazena os caracteres
	addiu	$s0, $zero, 32		#s0 guarda o número ASCII para espaço
	addiu	$t7, $zero, 10		#t7 guarda o número ASCII para quebra de linha
	la	$s1, v			#s1 tem o endereço do vetor agora
	la	$s2, aux		# vetor auxiliar
	addu	$s5, $zero, $zero	# Contador de casas decimais
	
	FOR:	beq	$t1, $zero, SAI		# Vamos percorrer o arquivo. Se t1 = 0 é fim de arquivo
	
		FOR_aux:	beq	$s0, $t1, SAI_aux		# Se t1 = 32 sai do if
				beq	$t7, $t1, SAI_aux		# Se t1 = 10 sai do if
				beq	$t1, $zero, SAI_aux
				sub	$t2, $t1, 48			# transformo t1 em int e coloco em t2
				sb	$t2, 0($s2)			# Armazeno número no vetor aux
				addiu	$s2, $s2, 4
				addiu	$s5, $s5, 1			# casas++
				
				addiu	$t0, $t0, 1
				lb	$t1, buffer($t0)
				j	FOR_aux		
		SAI_aux: 
		sub	$s2, $s2, 4
		addiu	$t3, $zero, 1		# Vamos usar esse para criar casas decimais
		addu	$s4, $zero, $zero
		FOR_aux2: 	beq	$s5, $zero, EXIT
				lb	$s3, 0($s2)
				mul	$s3, $s3, $t3	# num *=10
				addu	$s4, $s4, $s3   # numero += num
				  
				sub	$s2, $s2, 4	# v[i]--
				sub	$s5, $s5, 1	# i--
				mul	$t3, $t3, 10	# num *= 10
				j	FOR_aux2
		
		EXIT:	sb	$s4, 0($s1)
			addiu	$s1, $s1, 4
			addiu	$t0, $t0, 1
			la	$s2, aux		# vetor auxiliar
			lb	$t1, buffer($t0)		
			j	FOR
	SAI:

	lw	$s0, 4($sp)
	lw	$a0, 8($sp)
	lw	$a1, 12($sp)		
	addi	$sp, $sp, 60
	
	jr	$ra
	
# // SORT
	
SORT:	
	addu	$a2, $zero, $a0			# a2 aponta para vetor[0]
	addiu	$s1, $zero, 1			# k = 1

# for (k = 1; k < n; k++) {	
FOR1:	slt	$t0, $s1, $a1			# k < 9? Se sim t0 =1, se não t0 = 0
	beq	$t0, $zero, RESPOSTA

# for (j = 0; j < n - k; j++) {	
	subu	$s3, $a1, $s1 			# n - k	
	addu	$s2, $zero, $zero 		# j = 0
	FOR2:	slt	$t1, $s2, $s3 		# j < n - k? Se sim t1=1, se não t1 = 0
		beq	$t1, $zero, SAI_FOR2 
		
		# if (vetor[j] > vetor[j + 1]) {
		lb	$s4, 0($a2)	# s4 = v[j]
		addiu 	$a2, $a2, 4	# ponteiro ++ ou a0++
		lb	$s5, 0($a2)	#s5 = v[j+1]
		
		slt	$t2, $s5, $s4 	# vetor[j+1] < vetor[j]? se sim t2=1 se não t2 = 0
		beq	$t2, $zero, SAI_IF2
		
			addu	$s6, $zero, $s4	# aux = vetor[j];
			addu	$s4, $zero, $s5 # vetor[j] = vetor[j + 1];
			addu	$s5, $zero, $s6 # vetor[j + 1] = aux;
		
			subiu 	$a2, $a2, 4
			sb	$s4, 0($a2)
			addiu 	$a2, $a2, 4
			sb	$s5, 0($a2)
	
	SAI_IF2:	addiu	$s2,$s2,1		# j ++
		j	FOR2
	
	SAI_FOR2:
		addu	$a2, $zero, $a0			# a2 aponta para vetor[0]
		addiu	$s1, $s1, 1			# k++
		j	FOR1
	
RESPOSTA:					# Essa função não retorna nada
	jr	$ra				# contém o endereço da próxima instrução

# // SORT
	
PRINT:
	addu 	$a2, $zero, $a0			# a2 aponta para vetor[0]
	addu	$s1, $zero, $zero		# i = 0 
	
	FOR3:	slt	$t0, $s1, $a1		# i < n? Se sim t0 =1 se não t0 = 0
		beq	$t0, $zero, TERMINA
		
		lb	$s2, 0($a2)
		printInt($s2)
		printNL
		addiu	$a2,$a2, 4
		
		addiu	$s1, $s1, 1
		j	FOR3	
TERMINA:
	jr	$ra
