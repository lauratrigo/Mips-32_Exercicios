C:

#include <stdio.h>

int main() {
    
    int i = 1;
    int j = 1;
    int h;

    if  (i == j) {
        h = i + j;
    }

    printf("%d\n", h);

    return 0;
}

Mips 32:

.data

.text
    .globl main

main:
    # Inicializa i e j com 1
    li $t0, 1    # i = 1
    li $t1, 1    # j = 1
    li $t2, 0    # h = 0 (inicializado para evitar valores indefinidos)

    # if (i == j)
    bne $t0, $t1, end_if  # Se i != j, pula para end_if
    add $t2, $t0, $t1     # h = i + j

end_if:
    # Imprimir h
    move $a0, $t2         # Passa h para $a0
    li $v0, 1             # Código da syscall para imprimir inteiro
    syscall

    # Finaliza o programa
    li $v0, 10
    syscall
