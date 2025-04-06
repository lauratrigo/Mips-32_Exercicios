# Conside o seguinte programa em MIPS32 Assembler:

    move $s0, $Zero
    move $t0, $Zero
LOOP: muli $t1, $t0, 4
    add $t1, $t1, $s1
    lw $t2, 0($t1)
    add $s0, $s0, $t2
    addi $t0, $t0, 1
    blt $t0, $s2, LOOP

# a) Descreva o que cada linha do código faz:

    move $s0, $Zero     # inicializa $s0 com 0 (registrador que acumulará a soma)
    move $t0, $Zero     # inicializa $t0 com 0 (é o contador do loop)
LOOP: muli $t1, $t0, 4  # calcula o offset: $t1 = $t0 * 4 (cada elemento ocupa 4 bytes)
    add $t1, $t1, $s1   # calcula o endereço do elemento: $t1 = endereço_base ($s1) + offset
    lw $t2, 0($t1)      # carrega o valor do $t1 em $t2 (carrega o valor do array na posição atual em $t2)
    add $s0, $s0, $t2   # acumula o valor no somatório: $s0 += $t2
    addi $t0, $t0, 1    # incrementa o contador: $t0++
    blt $t0, $s2, LOOP  # se $t0 < $s2 (que é o tamanho do array), o loop se repete

# Funcionamento Geral:
    # Este código calcula a soma dos elementos de um array de inteiros. Equivalente em C:

    # int sum = 0;
    # for(int i = 0; i < n; i++) {
    #     sum += array[i];
    # }

# Definição de offset?
#     No contexto de MIPS32 e programação de baixo nível, offset (deslocamento) refere-se a:
#     Um valor numérico usado para calcular posições relativas na memória.
#     Em arrays e estruturas de dados, o offset é a distância em bytes entre o endereço base (início do array) e o 
#     elemento desejado.

# b) O presente código não está escrito de forma eficaz. Dessa forma, reescreva-o, fazendo as adaptações necessárias 
# para torna-lo eficiente. Comente cada linha do seu código.

    # inicialização dos registradores
    add $s0, $zero, $zero   # $s0 = 0 (acumulador da soma)
    add $t0, $zero, $zero   # $t0 = 0 (contador do loop)
LOOP: 
    sll $t1, $t0, 2     # $t1 = $t0 * 4 (sll(shift) é mais rápido para multiplicação)
    addu $t1, $t1, $s1  # $t1 = endereço do elemento atual, e usa addu para evitar overflow
    lw $t2, 0($t1)      # carrega o valor atual do array[$t0] em $t2
    addu $s0, $s0, $t2  # soma ao acumulador: $s0 += $t2
    addiu $t0, $t0, 1   # incrementa o contador: $t0++
    slt $t3, $t0, $s2   # $t3 = 1 se $t0 < $s2, caso contrário, $t3 = 0
    bne $t3, $zero, LOOP # se $t3 != 0, o loop continua
