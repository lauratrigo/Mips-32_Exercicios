# Suponha que tenhamos um arranjo 𝐴 = [1, 4, 2, 10, 8] e o arranjo 𝐵 = [0, 6, 3, 9, 7]. Escreva um programa em C e em MIPS Assembler para
# formarmos um arranjo que receba os valores contidos em A e B e que, estejam em ordem crescente.

C:

#include <stdio.h>

int main() {
    int A[] = {1, 4, 2, 10, 8};
    int B[] = {0, 6, 3, 9, 7};
    int C[10];
    int i, j, temp;

    // combina A e B em C
    for(i = 0; i < 5; i++) {
        C[i] = A[i];
        C[i+5] = B[i];
    }

    // ordena C em ordem crescente (Bubble Sort)
    for(i = 0; i < 9; i++) {
        for(j = 0; j < 9-i; j++) {
            if(C[j] > C[j+1]) {
                temp = C[j];
                C[j] = C[j+1];
                C[j+1] = temp;
            }
        }
    }

    // imprime o resultado
    printf("Array ordenado: ");
    for(i = 0; i < 10; i++) {
        printf("%d ", C[i]);
    }
    
    return 0;
}


MIPS 32:

.data
    A:      .word 1, 4, 2, 10, 8
    B:      .word 0, 6, 3, 9, 7
    C:      .space 40            # 10 elementos * 4 bytes cada
    msg:    .asciiz "Array ordenado: "
    space:  .asciiz " "

.text
.globl main

main:
    # Inicializa ponteiros
    la $s0, A        # Ponteiro para A
    la $s1, B        # Ponteiro para B
    la $s2, C        # Ponteiro para C
    li $t0, 0        # Contador i

# Combina A e B em C
combine:
    lw $t1, 0($s0)   # Carrega A[i]
    sw $t1, 0($s2)   # Armazena em C[i]
    
    lw $t1, 0($s1)   # Carrega B[i]
    sw $t1, 20($s2)  # Armazena em C[i+5] (5*4 bytes)
    
    addi $s0, $s0, 4 # Avança A
    addi $s1, $s1, 4 # Avança B
    addi $s2, $s2, 4 # Avança C
    addi $t0, $t0, 1 # i++
    blt $t0, 5, combine

# Ordenação (Bubble Sort)
    li $t0, 0        # i = 0
outer_loop:
    li $t1, 0        # j = 0
    li $t2, 9        # 10 - i - 1
    sub $t2, $t2, $t0
inner_loop:
    la $s2, C        # Recarrega ponteiro de C
    sll $t3, $t1, 2  # j*4
    add $s2, $s2, $t3
    
    lw $t4, 0($s2)   # C[j]
    lw $t5, 4($s2)   # C[j+1]
    
    ble $t4, $t5, no_swap
    
    # Swap
    sw $t5, 0($s2)
    sw $t4, 4($s2)
    
no_swap:
    addi $t1, $t1, 1 # j++
    blt $t1, $t2, inner_loop
    
    addi $t0, $t0, 1 # i++
    blt $t0, 9, outer_loop

# Imprime resultado
    li $v0, 4
    la $a0, msg
    syscall
    
    la $s2, C
    li $t0, 0
print_loop:
    li $v0, 1
    lw $a0, 0($s2)
    syscall
    
    li $v0, 4
    la $a0, space
    syscall
    
    addi $s2, $s2, 4
    addi $t0, $t0, 1
    blt $t0, 10, print_loop

# Termina programa
    li $v0, 10
    syscall
