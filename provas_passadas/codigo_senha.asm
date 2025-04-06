# Escreva um código em MIPS Assembler no qual receba em um dos registradores o login e em um outro a senha e compare com os dados armazenados
# na memória (o login e a senha são uma string que contêm 6 caracteres numéricos) e, caso em 3 tentativas erradas, não permita mais a inserção de dados.

C:

#include <stdio.h>
#include <string.h>

int main() {

    char login_salvo[] = "123456";
    char senha_salva[] = "654321";
    char login[7];
    char senha[7];
    int tentativas = 3;

    while (tentativas > 0) {

        printf("Digite o login: \n");
        scanf("%6s", &login);
        printf("Digite a senha: \n");
        scanf("%6s", &senha);

        if (strcmp(login, login_salvo) == 0 && strcmp(senha, senha_salva) == 0) {
            
            printf("Login e senha corretos");
            break;
        }
        else {
            tentativas--;
            printf("Login ou senha incorretos, numero restante de tentativas: %d\n", tentativas);
            

            if (tentativas == 0) {
                printf("Numero de tentativas atingido");
            }
        }

    }

    return 0;
}


MIPS 32:

.data
    # strings armazenadas
    login_salvo: .asciiz "123456"
    senha_salva: .asciiz "654321"
    
    # buffers para entrada
    login: .space 7       # 6 caracteres + null terminator
    senha: .space 7
    
    # mensagens
    msg_login: .asciiz "Digite o login: \n"
    msg_senha: .asciiz "Digite a senha: \n"
    msg_sucesso: .asciiz "Login e senha corretos"
    msg_erro: .asciiz "Login ou senha incorretos, numero restante de tentativas: "
    msg_bloqueio: .asciiz "Numero de tentativas atingido"
    newline: .asciiz "\n"

.text
.globl main

main:
    # inicializa tentativas
    li $s0, 3             # $s0 = tentativas = 3

loop:
    blez $s0, bloqueio    # se tentativas <= 0, vai para bloqueio

    # solicita login
    li $v0, 4
    la $a0, msg_login
    syscall

    # lê login (máximo 6 caracteres)
    li $v0, 8
    la $a0, login
    li $a1, 7             # tamanho do buffer (incluindo \0)
    syscall

    # remove newline e limpa buffer
    la $a0, login
    jal clean_input

    # solicita senha
    li $v0, 4
    la $a0, msg_senha
    syscall

    # lê senha (máximo 6 caracteres)
    li $v0, 8
    la $a0, senha
    li $a1, 7
    syscall

    # remove newline e limpa buffer
    la $a0, senha
    jal clean_input

    # compara login
    la $a0, login
    la $a1, login_salvo
    jal strcmp
    move $t0, $v0         # salva resultado da comparação

    # compara senha
    la $a0, senha
    la $a1, senha_salva
    jal strcmp
    move $t1, $v0         # salva resultado da comparação

    # verifica se ambos são iguais (retorno 0)
    or $t2, $t0, $t1
    beqz $t2, sucesso

    # se incorreto, decrementa tentativas
    addi $s0, $s0, -1

    # mostra mensagem de erro
    li $v0, 4
    la $a0, msg_erro
    syscall

    # mostra tentativas restantes
    li $v0, 1
    move $a0, $s0
    syscall

    # nova linha
    li $v0, 4
    la $a0, newline
    syscall

    j loop

sucesso:
    li $v0, 4
    la $a0, msg_sucesso
    syscall
    j fim

bloqueio:
    li $v0, 4
    la $a0, msg_bloqueio
    syscall

fim:
    li $v0, 10
    syscall

# função para limpar input e remover newline
clean_input:
    li $t1, 10            # carrega newline
clean_loop:
    lb $t0, 0($a0)        # carrega caractere atual
    beq $t0, $t1, clean_found  # se encontrou newline
    beqz $t0, clean_end    # se encontrou null terminator
    addi $a0, $a0, 1       # próximo caractere
    j clean_loop
clean_found:
    sb $zero, 0($a0)       # substitui newline por null terminator
clean_end:
    jr $ra

# função strcmp corrigida
strcmp:
    li $v0, 0             # inicializa retorno como 0 (igual)
    li $t3, 0             # contador de caracteres
    
strcmp_loop:
    lb $t0, 0($a0)        # carrega byte da string 1
    lb $t1, 0($a1)        # carrega byte da string 2
    
    # verifica se ambas strings terminaram
    beqz $t0, check_str2_end
    beqz $t1, strcmp_diff # se str2 acabou antes, são diferentes
    
    bne $t0, $t1, strcmp_diff
    
    addi $a0, $a0, 1      # próximo caractere string1
    addi $a1, $a1, 1      # próximo caractere string2
    addi $t3, $t3, 1      # incrementa contador
    j strcmp_loop

check_str2_end:
    lb $t1, 0($a1)        # verifica se str2 também terminou
    beqz $t1, strcmp_end  # se ambas terminaram, são iguais
    # se não, são diferentes

strcmp_diff:
    li $v0, 1             # strings diferentes

strcmp_end:
    jr $ra
