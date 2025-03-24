/* Suponha que você desenvolveu um sistema microcontrolado que calcula a área de uma mancha de petróleo, oriunda de um vazamento em alto mar.
Suponha que o sistema tenha arquitetura MIPS 32 e que o registrador $S2 é quem receba a vazão de vazamento oriunda de um sensor. Considere
que a mancha mantém-se constantemente como uma circunferência. Despreze efeitos viscosos e de ondas. Escreva o script em MIPS 32 Assembly */

C:

#include <stdio.h>

int main() {
    float pi = 3.14159;   // definição da constante π
    int s2 = 5;           // simulando o valor vindo do sensor (raio ou vazão)
    
    // calcula a área da circunferência
    float area = pi * (s2 * s2);

    // imprime o resultado
    printf("Área da mancha de petróleo: %.2f\n", area);

    return 0;
}

Mips 32:

.data
    pi: .float 3.14159

.text
    .globl main

main:
    # inicializa $s2 com um valor de exemplo (raio ou vazão)
    li $s2, 5          # $s2 = 5 (valor de exemplo para o raio ou vazão)

    # calcula o quadrado do raio (raio * raio)
    mul $t0, $s2, $s2  # $t0 = $s2 * $s2

    # carrega o valor de pi da memória para um registrador de ponto flutuante
    la $t1, pi         # $t1 = endereço de pi
    lwc1 $f1, 0($t1)   # $f1 = pi (carrega o valor de pi para o registrador de ponto flutuante $f1)

    # converte o valor inteiro em $t0 para ponto flutuante e armazena em $f2
    mtc1 $t0, $f2      # move o valor inteiro de $t0 para o registrador de ponto flutuante $f2
    cvt.s.w $f2, $f2   # converte o valor inteiro em $f2 para ponto flutuante

    # multiplica o valor de pi pelo quadrado do raio (pi * raio^2)
    mul.s $f0, $f1, $f2 # $f0 = $f1 * $f2 (pi * raio^2)

    # move o resultado para $f12, que é o registrador usado para imprimir floats
    mov.s $f12, $f0    # $f12 = $f0

    # imprime o valor da área (que está em $f12)
    li $v0, 2          # código para imprimir float
    syscall

    # termina o programa
    li $v0, 10         # código para sair do programa
    syscall
