# Exercício que pede para o usuário inserir dois números, e realiza a soma e subtração dos mesmos:

C:

#include <stdio.h>

int main() {

    int a;
    int b;
    int soma = 0;
    int subtracao = 0;

    printf("Insira dois numeros inteiros: ");
    scanf("%d%d", &a, &b);

    soma = a + b;
    subtracao = a - b;

    printf("Soma dos números: %d\n", soma);
    printf("Subtração dos numeros: %d", subtracao);

    return 0;
}


MIPS 32:

.data 

printfMsg: .asciiz "Insira dois números inteiros: "
somMsg: .asciiz "Soma dos números: "
subMsg: .asciiz "Subtração dos números: "

.text

li $v0, 4           # código 4 tem a função de imprimir uma string
la $a0, printfMsg   # carrega o endereço de "printfMsg" no registrador $a0
syscall             # chama a syscall para imprimir a string

# lendo o primeiro número inteiro
li $v0, 5           # código 5 tem a função de avisar a syscall vai ler um número inteiro do usuário
syscall             # chamada de sistema que espera o usuário digitar um número inteiro e o armazena no registrador $v0
move $t0, $v0       # o número digitado é movido para o registrador $t0, assim armazenando o primeiro número inteiro

# lendo o segundo número inteiro
li $v0, 5
syscall
move $t1, $v0       # o número digitado é movido para o registrador $t1, assim armazenando o segundo número inteiro


# exibindo a mensagem de soma
li $v0, 4
la $a0, somMsg      # carrega o endereço da string somMsg no registrador $a0
syscall
