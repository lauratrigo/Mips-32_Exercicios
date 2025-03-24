C:

#include <stdio.h>

int main() {

    int a = 4;
    int b = 6;
    int mult = 0;

    mult = a * b;

    printf("%d\n", mult);

    return 0;
}


MIPS 32:

.text
    .globl main

main:

    # atribuí os valores aos registradores, $t0 = 4, $t1 = 6
    li $t0, 4
    li $t1, 6

    # realiza a multiplicação dos dois registradores $t0 e $t1 e armazena em $t2
    mul $t2, $t0, $t1

    # move o valor da multiplicação para o registrador $a0 
    move $a0, $t2

    # configura o syscall para a impressão do valor inteiro
    li $v0, 1
    syscall  # imprimi o valor inteiro 

    # encerra o programa
    li $v0, 10
    syscall
