# Suponha que a arquitetura onde esteja instalado o código seja MIPS32, implemente um script em MIPS Assembler em que se escolhe entre 3 tipos de
tamanho e 3 opções de pizza. (Faça comentários nas linhas explicando o que cada instrução faz. OBS: # é usado para comentário). #

C: 
#include <stdio.h>

int main() {
    
    int tam;
    int sabor;

    printf("Escolha um tamanho de pizza:\n1 - Tamanho pequeno\n2 - Tamanho Medio\n3 - Tamanho Grande\n");
    scanf("%d", &tam);

    printf("Escolha um sabor de pizza:\n1 - Marguerita\n2 - Calabresa\n3 - Portuguesa\n");
    scanf("%d", &sabor);

    if (tam == 1) {
        printf("O tamanho pequeno foi escolhido\n");
    }
    else if (tam == 2) {
        printf("O tamanho medio foi escolhido\n");
    }
    else if (tam == 3) {
        printf("O tamanho grande foi escolhido\n");
    }
    else {
        printf("Ocorreu um erro, por favor escolha outro tamanho\n");
    }

    if (sabor == 1) {
        printf("O sabor marguerita foi escolhido\n");
    }
    else if (sabor == 2) {
        printf("O sabor calabresa foi escolhido\n");
    }
    else if (sabor == 3) {
        printf("O sabor portuguesa foi escolhido\n");
    }
    else {
        printf("Ocorreu um erro, por favor escolha outro sabor\n");
    }

    return 0;
}


MIPS 32:

.data
    # printf das mensagens com o menu dos tamanhos
    msg_tamanho: .asciiz "Escolha um tamanho de pizza:\n1 - Tamanho pequeno\n2 - Tamanho Medio\n3 - Tamanho Grande\n"
    pequeno: .asciiz "O tamanho pequeno foi escolhido\n"
    medio: .asciiz "O tamanho medio foi escolhido\n"
    grande: .asciiz "O tamanho grande foi escolhido\n"
    erro_tamanho: .asciiz "Ocorreu um erro, por favor escolha outro tamanho\n"

    # printf das mensagens com o menu dos sabores
    msg_sabor: .asciiz "Escolha um sabor de pizza:\n1 - Marguerita\n2 - Calabresa\n3 - Portuguesa\n"
    marguerita: .asciiz "O sabor marguerita foi escolhido\n"
    calabresa: .asciiz "O sabor calabresa foi escolhido\n"
    portuguesa: .asciiz "O sabor portuguesa foi escolhido\n"
    erro_sabor: .asciiz "Ocorreu um erro, por favor escolha outro sabor\n"

    # inicialização dos registradores para armazenar as escolhas
    tamanho: .word 0    # armazena o valor escolhido (inicializado com 0)
    sabor: .word 0

.text
    .globl main

main: 
    # printa o menu de tamanhos
    li $v0, 4           # código para imprimir string
    la $a0, msg_tamanho # carrega endereço da mensagem
    syscall

    # lê a escolha do tamanho
    li $v0, 5           # código para ler o inteiro
    syscall
    sw $v0, tamanho     # armazena o valor lido na variável tamanho

    # printa o menu de sabores
    li $v0, 4
    la $a0, msg_sabor
    syscall

    # lê a escolha do tamanho
    li $v0, 5
    syscall
    sw $v0, sabor   # armazena o valor lido na variável sabor

processa_tamanho:
    # processa a escolha do tamanho
    lw $t0, tamanho         # carrega o valor do tamanho em $t0

    beq $t0, 1, escolha_pequeno # se tamanho == 1
    beq $t0, 2, escolha_medio   # se tamanho == 2
    beq $t0, 3, escolha_grande  # se tamanho == 3

    # caso nenhuma opção seja válida
    li $v0, 4
    la $a0, erro_tamanho
    syscall
    j processa_sabor    # pula para processar sabor mesmo com erro

escolha_pequeno:
    li $v0, 4
    la $a0, pequeno
    syscall
    j processa_sabor    # vai para processar sabor

escolha_medio:
    li $v0, 4
    la $a0, medio
    syscall
    j processa_sabor

escolha_grande:
    li $v0, 4
    la $a0, grande 
    syscall

processa_sabor:
    # processa a escolha do sabor
    lw $t0, sabor

    beq $t0, 1, escolha_marguerita
    beq $t0, 2, escolha_calabresa
    beq $t0, 3, escolha_portuguesa

    # caso nenhuma opção seja válida
    li $v0, 4
    la $a0, erro_sabor
    syscall
    j fim

escolha_marguerita:
    li $v0, 4
    la $a0, marguerita
    syscall
    j fim

escolha_calabresa:
    li $v0, 4
    la $a0, calabresa
    syscall
    j fim

escolha_portuguesa:
    li $v0, 4
    la $a0, portuguesa
    syscall

fim:
    # código para encerrar o programa
    li $v0, 10
    syscall
