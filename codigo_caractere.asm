C:

#include <stdio.h>

int main() {

    char a = 'A';

    printf("%c", a);
}


MIPS 32:

.data
    caractere: .byte 'A' #o caractere A será impresso

.text
    li $v0, 4 #configura o syscall para imprimir o caractere
    la $a0, caractere #carrega o endereço da variável "caractere" em $a0
    syscall 

#não precisa usar li $v0, 10 para encerrar o programa pois ele se encerrará naturalmente após li $v0, 4
