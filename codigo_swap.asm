O código em C é uma função chamada swap que troca dois elementos adjacentes em um vetor de inteiros:

C:

#include <stdio.h>

// função que recebe um vetor V e um índice k
swap(int v[], int k) {
    int temp; // variável temporária que armazenará o valor durante a troca
    temp = v[k]; // adiciona o valor atual de v[k] em temp
    v[k] = v[k + 1]; // move o valor de v[k + 1] para v[k]
    v[k + 1] = temp; // move o valor original de v[k] para v[k + 1]
}

int main() {
    int v[] = {10, 20, 30, 40, 50};  // exemplo de vetor com valores
    int k = 2;  // índice para troca (no caso, vai trocar os valores nos índices 2 e 3)

    // mostrando o vetor antes da troca
    printf("Antes da troca: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", v[i]);
    }
    printf("\n");

    // chama a função swap para trocar os elementos nos índices k e k+1
    swap(v, k);

    // mostrando o vetor depois da troca
    printf("Depois da troca: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", v[i]);
    }
    printf("\n");

    return 0;
}


MIPS 32:

.data
v:  .word 10, 20, 30, 40, 50       # Vetor v com os valores {10, 20, 30, 40, 50}
msg1: .asciiz "Antes da troca: "
msg2: .asciiz "Depois da troca: "
space: .asciiz " "                 # Espaço para separar os números na impressão

.text
.globl main

main:
    # Imprimir "Antes da troca: "
    li $v0, 4               # Syscall para imprimir string
    la $a0, msg1            # Carregar o endereço da string msg1
    syscall

    # Imprimir os elementos de v[] antes da troca
    li $t0, 0               # Índice inicial (i = 0)
print_before:
    bge $t0, 5, print_after  # Se i >= 5, pula para print_after
    la $t1, v               # Carregar o endereço do vetor v
    sll $t2, $t0, 2         # Multiplica i por 4 (para indexar corretamente)
    add $t1, $t1, $t2       # Adiciona o deslocamento ao endereço base
    lw $a0, 0($t1)          # Carrega o valor correto de v[i] em $a0
    
    li $v0, 1               # Syscall para imprimir inteiro
    syscall

    li $v0, 4               # Syscall para imprimir espaço
    la $a0, space
    syscall

    addi $t0, $t0, 1        # Incrementar i
    j print_before          # Repetir

print_after:
    # Imprimir "Depois da troca: "
    li $v0, 4               # Syscall para imprimir string
    la $a0, msg2            # Carregar o endereço da string msg2
    syscall

    # Chama a função swap para trocar os elementos
    li $a0, 2               # Definir o índice k = 2
    jal swap                # Chama a função swap

    # Imprimir os elementos de v[] depois da troca
    li $t0, 0               # Índice inicial (i = 0)
print_after_swap:
    bge $t0, 5, end         # Se i >= 5, termina
    la $t1, v               # Carregar o endereço do vetor v
    sll $t2, $t0, 2         # Multiplica i por 4 (para indexar corretamente)
    add $t1, $t1, $t2       # Adiciona o deslocamento ao endereço base
    lw $a0, 0($t1)          # Carrega o valor correto de v[i]

    li $v0, 1               # Syscall para imprimir inteiro
    syscall

    li $v0, 4               # Syscall para imprimir espaço
    la $a0, space
    syscall

    addi $t0, $t0, 1        # Incrementar i
    j print_after_swap      # Repetir

end:
    li $v0, 10              # Syscall para terminar o programa
    syscall

swap:  
    # Função swap (troca v[k] com v[k + 1])
    # Parâmetro:
    #   $a0 = índice k
    
    sll $t2, $a0, 2         # Multiplica k por 4 (para indexar corretamente)
    la $t1, v               # Carregar o endereço base do vetor
    add $t1, $t1, $t2       # Adicionar o deslocamento (k * 4) ao endereço base

    lw $t0, 0($t1)          # Carregar v[k] em $t0

    addi $t1, $t1, 4        # Avançar para v[k + 1]
    lw $t3, 0($t1)          # Carregar v[k + 1] em $t3

    # Troca os valores
    sw $t3, -4($t1)         # Armazena v[k + 1] em v[k]
    sw $t0, 0($t1)          # Armazena v[k] em v[k + 1]

    jr $ra                  # Retorna ao chamador (main)

  
