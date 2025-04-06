// Implemente em MIPS e em C, ou C++, um script no qual, dados valores de x e y, os quais estão armazenados em $S0 e $S1 
// respectivamente,calcule a expressão x³+6x²y+12xy²+8y³ e armazene o resultado em $S2.
// OBS: Não é preciso checar OVERFLOWS. 

C:

#include <stdio.h>

int main() {
    int x, y;
    
    printf("Digite o valor de x: ");
    scanf("%d", &x);
    printf("Digite o valor de y: ");
    scanf("%d", &y);

    // Calcula cada termo separadamente
    int x3 = x * x * x;
    int x2y = 6 * (x * x * y);
    int xy2 = 12 * (x * y * y);
    int y3 = 8 * (y * y * y);
    
    int resultado = x3 + x2y + xy2 + y3;
    
    printf("Resultado: %d\n", resultado);
    return 0;
}


MIPS 32:

.data
    msg_x: .asciiz "Digite o valor de x: "
    msg_y: .asciiz "Digite o valor de y: "
    msg_result: .asciiz "Resultado: "
    newline: .asciiz "\n"

.text
.globl main

main:
    # lê o valor de x
    li $v0, 4
    la $a0, msg_x
    syscall
    
    li $v0, 5
    syscall
    move $s0, $v0        # $s0 = x
    
    # lê o valor de y
    li $v0, 4
    la $a0, msg_y
    syscall
    
    li $v0, 5
    syscall
    move $s1, $v0        # $s1 = y

    # calcula x³ ($t0 = x³)
    mul $t0, $s0, $s0    # x²
    mul $t0, $t0, $s0    # x³

    # calcula 6x²y ($t1 = 6x²y)
    mul $t1, $s0, $s0    # x²
    mul $t1, $t1, $s1    # x²y
    li $t2, 6
    mul $t1, $t1, $t2    # 6x²y

    # calcula 12xy² ($t2 = 12xy²)
    mul $t2, $s1, $s1    # y²
    mul $t2, $t2, $s0    # xy²
    li $t3, 12
    mul $t2, $t2, $t3    # 12xy²

    # calcula 8y³ ($t3 = 8y³)
    mul $t3, $s1, $s1    # y²
    mul $t3, $t3, $s1    # y³
    li $t4, 8
    mul $t3, $t3, $t4    # 8y³

    # soma todos os termos ($s2 = resultado final)
    add $s2, $t0, $t1
    add $s2, $s2, $t2
    add $s2, $s2, $t3

    # imprime a mensagem do resultado
    li $v0, 4
    la $a0, msg_result
    syscall
    
    # imprime o resultado
    li $v0, 1
    move $a0, $s2
    syscall
    
    # imprime uma linha nova
    li $v0, 4
    la $a0, newline
    syscall

    # encerrar programa
    li $v0, 10
    syscall
