# Considere o seguinte programa em MIPS32 Assembler:

.text
main: 
    li $v0, 5
    syscall         # ler inteiro
    move $S0, $v0
start: li $S1, 0
       j test
loop: andi $t0, $s0, 1
      xor $S1, $S1, $t0
      srl $S0, $S0, 1
test: bne $S0, $zero, loop
out: move $a0, $S1
     li $v0, 1
     syscall        # printar inteiros
     li $v0, 10     
     syscall        # exit

# A partir dele, faça o que se pede abaixo:
# a) Simule o programa manualmente para os Inputs: 15, 64, - 1. Em cada um dos 
# casos, indique quantas vezes o código realiza o loop e qual será sua saída.

# input: 15, nº de loops: 4, saída: 0, explicação: 15 tem 4 bits 1 (par)
# input: 64, nº de loops: 7, saída: 1, explicação: 64 tem 1 bit 1 (ímpar)
# input: -1, nº de loops: 32, saída: 0, explicação: -1 tem 32 bits 1 (par)

# b) Explique, de forma resumida, em uma única sentença, o que o código faz.

# O código conta o número de bits `1` na representação binária do valor de entrada e retorna 
# `1` se a quantidade for ímpar ou `0` se for par (calcula o bit de paridade ímpar).
