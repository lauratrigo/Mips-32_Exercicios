# Implemente um Loop em MIPS Assembler o qual, para um dado positivo inteiro n no registrador $S0, calcule o enésimo número de Fibonacci, ou
# seja, o enésimo elemento nas séries do estilo 1, 1, 2, 3, 5, 8, 11, ... - cada número de Fibonacci é a soma dos dois anteriores. Por exemplo: 
# se $S0 contém 5, então deveria armazenar 8 no $S1.

C: 

#include <stdio.h>

int main() {
    int n = 5;              // exemplo com n=5 
    int a = 1, b = 1, temp;
    
    if (n == 0) {
        printf("0");
        return 0;
    } else if (n <= 2) {
        printf("1");
        return 0;
    }
    
    for (int i = 3; i <= n; i++) {
        temp = a + b;
        a = b;
        b = temp;
    }
    
    printf("%d", b);
    return 0;
}


MIPS 32:

.data
    n: .word 5       # Valor de n (pode ser alterado)
    result: .word 0   # Para armazenar o resultado

.text
.globl main

main:
    lw $s0, n        # Carrega n em $s0
    li $s1, 1        # Inicializa a = 1 (F(1))
    li $s2, 1        # Inicializa b = 1 (F(2))
    li $t0, 3        # Inicializa contador i = 3

    # Casos base
    blez $s0, fib0   # Se n <= 0, retorna 0
    li $t1, 1
    beq $s0, $t1, fib1  # Se n == 1, retorna 1
    li $t1, 2
    beq $s0, $t1, fib1  # Se n == 2, retorna 1

fib_loop:
    bgt $t0, $s0, end_loop  # Se i > n, termina
    
    add $t2, $s1, $s2  # temp = a + b
    move $s1, $s2      # a = b
    move $s2, $t2      # b = temp
    
    addi $t0, $t0, 1   # i++
    j fib_loop

end_loop:
    sw $s2, result     # Armazena o resultado
    j exit

fib0:
    li $s2, 0          # Retorna 0 para n <= 0
    sw $s2, result
    j exit

fib1:
    li $s2, 1          # Retorna 1 para n = 1 ou 2
    sw $s2, result

exit:
    # Para exibir o resultado (opcional)
    li $v0, 1
    move $a0, $s2
    syscall
    
    li $v0, 10        # Encerra o programa
    syscall
