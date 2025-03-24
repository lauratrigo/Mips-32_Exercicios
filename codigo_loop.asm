C:

#include <stdio.h>

int main() {
    int a[] = {1, 2, 3, 4, 5};   // Exemplo de vetor
    int n = 5;                   // Tamanho do vetor
    int s = 0;                   // Soma
    int i = 0;                   // Índice

    while (i < n) {
        s = s + a[i];  // Adiciona o valor de a[i] à soma
        i++;           // Incrementa o índice
    }

    printf("Soma: %d\n", s);  // Imprime o resultado
    return 0;
}


MIPS 32:

  .data
    L: .word 0              # L = 0
    S: .word 0              # S = 0
    A: .word 1, 2, 3, 4, 5  # Array A com 5 elementos
    n: .word 5              # Tamanho do array (n = 5)
    i: .word 0              # Índice i = 0

.text
    .globl main

main:
    # Inicialização dos registradores
    lw $t0, L           # Carrega L em $t0 (não usado no loop, apenas para inicialização)
    lw $t1, S           # Carrega S em $t1
    lw $t2, i           # Carrega i em $t2
    lw $t3, n           # Carrega n em $t3
    la $t4, A           # Carrega o endereço base do array A em $t4

loop:
    # Verifica se i < n
    bge $t2, $t3, end_loop  # Se i >= n, sai do loop

    # Calcula o endereço de A[i]
    sll $t5, $t2, 2     # Multiplica i por 4 (tamanho de um word) para obter o deslocamento
    add $t5, $t4, $t5   # Adiciona o deslocamento ao endereço base de A
    lw $t6, 0($t5)      # Carrega o valor de A[i] em $t6

    # S = S + A[i]
    add $t1, $t1, $t6   # $t1 = $t1 + $t6 (S = S + A[i])

    # Incrementa i (i++)
    addi $t2, $t2, 1    # $t2 = $t2 + 1 (i++)

    # Volta para o início do loop
    j loop

end_loop:
    # Salva os valores atualizados de S e i na memória (opcional)
    sw $t1, S           # Salva o valor de S na memória
    sw $t2, i           # Salva o valor de i na memória

    # Imprime o valor final de S (opcional)
    move $a0, $t1       # Move o valor de S para $a0
    li $v0, 1           # Código para imprimir um inteiro
    syscall

    # Encerra o programa
    li $v0, 10          # Código para encerrar o programa
    syscall
