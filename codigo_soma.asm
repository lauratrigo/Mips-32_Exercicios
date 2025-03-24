C:

#include <stdio.h>

int main() {

    int a = 5;
    int b = 10;
    int soma = 0;

    soma = a + b;

    printf("%d", soma);

    return 0;
}


MIPS 32:

.text
    .globl main

main:
    # atribuição dos valores para os dois registradores, t0 = 5, e t1 = 10
    li $t0, 5
    li $t1, 10

    # realiza a soma entre os dois registradores e armazena o resultado em $t2, $t2 = 15
    add $t2, $t0, $t1

    # move o valor do registrador $t2 para o registrador $a0 para permitir a impressão do valor inteiro
    move $a0, $t2

    # configura o syscall para impressão do valor inteiro
    li $v0, 1
    syscall  # executa o syscall para impressão do valor inteiro

    # encerra o programa
    li $v0, 10
    syscall
