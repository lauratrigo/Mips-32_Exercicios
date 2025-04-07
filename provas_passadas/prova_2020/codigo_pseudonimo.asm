# Abaixo segue um pseudocódigo classificador (“sort”)

# inicio
#     variavel    texto   nome[5]
#     variavel    real    nota[5]
#     variavel    inteiro i, j	
#     variavel    real aux
#     variavel    texto   naux
#     para i de 1 até 5
#         escrever "Nome ", i, " = "
#         ler nome (i-1)
#         escrever "Nota ", i, " = "
#         ler nota (i-1)
#     proximo
#     para i de 0 até 4
#         para j de i+1 até 4
#             se nota[i]<=nota[j] então 
#                 aux <- nota[i]
#                 nota[i] <- nota[j]
#                 nota[j] <- aux
#                 naux <- nome[i]
#                 nome[i] <- nome[j]
#                 nome[j] <- naux
#             fimSe
#         proximo
#     proximo
#     para i de 1 até 5
#         escrever nome[i-1], ": ",nota[i-1], "\n"
#     proximo
# fim

# a) Identifique quais são as variáveis que são ordenadas e qual é a ordem de classificação. Justifique sua resposta.
# b) Transcreva este pseudocódigo para MIPS-32 Assembler. (Comente as linhas, do contrário, não aceitarei a resposta).
# c) Identifique as pseudoinstruções que você utilizou e mostre quais seriam seus modos de endereçamento.
    			
R: 

# a) Variáveis ordenadas e ordem de classificação:
# As variáveis ordenadas são os vetores `nome[5]` (texto) e `nota[5]` (real), que são ordenados **em ordem decrescente de notas** (do maior para o menor). 
# Isso é evidenciado pela condição `se nota[i]<=nota[j] então`, que realiza a troca quando uma nota anterior é menor ou igual à posterior, efetivamente 
# empurrando as menores notas para o final do vetor. O vetor `nome` é reordenado em conjunto para manter a correspondência com as notas.

# b) Transcreva este pseudocódigo para MIPS-32 Assembler. (Comente as linhas, do contrário, não aceitarei a resposta).

.data
    nome:       .space 20        # 5 nomes x 4 bytes cada
    nota:       .space 20        # 5 notas x 4 bytes cada
    msg_nome:   .asciiz "Nome "
    msg_nota:   .asciiz "Nota "
    msg_igual:  .asciiz " = "
    msg_sep:    .asciiz ": "
    newline:    .asciiz "\n"

.text
.globl main

main:
    # Inicialização
    li $t0, 0                   # i = 0
    la $s0, nome                # Carrega endereço base dos nomes
    la $s1, nota                # Carrega endereço base das notas

ler_dados:
    # Mostra "Nome i = "
    li $v0, 4
    la $a0, msg_nome
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, msg_igual
    syscall

    # Lê nome[i]
    li $v0, 8
    move $a0, $s0               # Endereço atual do nome
    li $a1, 4                   # Lê no máximo 3 caracteres + null
    syscall

    # Mostra "Nota i = "
    li $v0, 4
    la $a0, msg_nota
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, msg_igual
    syscall

    # Lê nota[i]
    li $v0, 6
    syscall
    swc1 $f0, 0($s1)            # Armazena nota

    # Atualiza ponteiros
    addi $s0, $s0, 4            # Avança para próximo nome
    addi $s1, $s1, 4            # Avança para próxima nota
    addi $t0, $t0, 1            # i++
    blt $t0, 5, ler_dados       # Repete para 5 entradas

    # Ordenação (Bubble Sort)
    li $t0, 0                   # i = 0
outer_loop:
    li $t1, 0                   # j = 0
inner_loop:
    # Carrega nota[i] e nota[j]
    sll $t2, $t0, 2             # i*4 (offset)
    sll $t3, $t1, 2             # j*4 (offset)
    add $t4, $s1, $t2           # Endereço nota[i]
    add $t5, $s1, $t3           # Endereço nota[j]
    lwc1 $f0, 0($t4)            # nota[i]
    lwc1 $f1, 0($t5)            # nota[j]

    # Se nota[i] <= nota[j], não troca
    c.le.s $f0, $f1
    bc1t no_swap

    # Troca notas
    swc1 $f0, 0($t5)
    swc1 $f1, 0($t4)

    # Troca nomes
    lw $t6, nome($t2)           # Carrega nome[i]
    lw $t7, nome($t3)           # Carrega nome[j]
    sw $t6, nome($t3)           # Armazena nome[j]
    sw $t7, nome($t2)           # Armazena nome[i]

no_swap:
    addi $t1, $t1, 1            # j++
    blt $t1, 5, inner_loop       # Continua loop interno
    addi $t0, $t0, 1            # i++
    blt $t0, 4, outer_loop       # Continua loop externo

    # Mostra resultados
    li $t0, 0                   # i = 0
print_loop:
    # Calcula offset
    sll $t1, $t0, 2             # i*4

    # Mostra nome[i] - CORREÇÃO CRÍTICA AQUI
    li $v0, 4
    la $a0, nome                # Carrega endereço base
    add $a0, $a0, $t1           # Adiciona offset
    syscall

    # Mostra ": "
    li $v0, 4
    la $a0, msg_sep
    syscall

    # Mostra nota[i]
    li $v0, 2
    lwc1 $f12, nota($t1)
    syscall

    # Nova linha
    li $v0, 4
    la $a0, newline
    syscall

    addi $t0, $t0, 1            # i++
    blt $t0, 5, print_loop       # Repete até mostrar todos

    # Fim
    li $v0, 10
    syscall

# c) Pseudoinstruções e modos de endereçamento:

# 1. **Pseudoinstruções identificadas:**
#    - `la` (Load Address): Traduzida para `lui` + `ori`
#    - `blt` (Branch if Less Than): Traduzida para `slt` + `bne`
#    - Uso de labels em `lw`/`sw`: Convertidas para endereçamento relativo ao PC ou base + offset

# 2. **Modos de endereçamento utilizados:**
#    - **Imediato:** Para constantes (ex: `li $v0, 4`)
#    - **Base + Deslocamento:** Para acessar vetores (ex: `lwc1 $f0, nota($t0)`)
#    - **Registrador:** Para operações aritméticas (ex: `addi $t0, $t0, 1`)
#    - **PC-relativo:** Para branches (ex: `blt $t0, 5, print_loop`)

# Observação: O código assume que cada nome ocupa 4 bytes (ajuste conforme necessário para strings maiores) e utiliza alinhamento correto para floats.
