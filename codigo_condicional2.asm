C:

#include <stdio.h>

int main() {

    int i = 0;
    int a = 0;
    int b = 10;
    int c = 20;

    while (i < 5) {
        a = b + c;
        i ++;
    }

    printf("%d", a);

    return 0;
}


Mips 32:

.data
    # Declaração das variáveis
    i: .word 0       # i = 0
    a: .word 0       # a = 0
    b: .word 10      # b = 10 (valor de exemplo)
    c: .word 20      # c = 20 (valor de exemplo)

.text
    .globl main

main:
    # Inicialização dos registradores
    lw $t0, i        # Carrega o valor de i em $t0
    lw $t1, b        # Carrega o valor de b em $t1
    lw $t2, c        # Carrega o valor de c em $t2
    lw $t3, a        # Carrega o valor de a em $t3

loop:
    # Verifica a condição do while (i < 5)
    li $t4, 5        # Carrega o valor 5 em $t4
    bge $t0, $t4, end_loop  # Se i >= 5, sai do loop

    # Corpo do loop: a = b + c
    add $t3, $t1, $t2  # $t3 = $t1 + $t2 (a = b + c)

    # Incrementa i (i++)
    addi $t0, $t0, 1   # $t0 = $t0 + 1 (i++)

    # Volta para o início do loop
    j loop

end_loop:
    # Imprime o valor final de a
    move $a0, $t3      # Move o valor de a para $a0
    li $v0, 1          # Código para imprimir um inteiro
    syscall

    # Encerra o programa
    li $v0, 10         # Código para encerrar o programa
    syscall
