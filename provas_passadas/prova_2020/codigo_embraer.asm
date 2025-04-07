# Embraer projeta “SUV voador elétrico” para operar como Uber aéreo 
#     “A equipe da Embraerse concentrou na experiência do cliente, utilizando sistemas
#   redundantes incorporados para alcançar a segurança ideal e também baixo ruído
#   com um sistema de oito rotores que permitem a elevação por extensão”,
#   disse Mark Moore, diretor de Engenharia de Aviação da Uber.

# a) Quais os tipos de classificação de computadores serão necessários para a operação deste SUV voador? 
# Justifique sua resposta.
# b) Pensando no funcionamento dos sistemas que esta SUV necessita para operação, tais como: navegação, 
# aplicativos, orientação, controle, responda, justificando como as arquiteturas Harvard e von
# Neumann se adequariam a cada tipo destes sistemas e quais pseudoinstruções, MIPS-32, seriam mais 
# comuns na programação direta das operações deste Uber aéreo ?.
# c) Escreva um código em MIPS Assembler que receberia o endereço que o passageiro quer chegar e que 
# faria o cálculo de quanto tempo levaria para atingir o endereço. (As variáveis extras necessárias
# à implementação são de livre criação sua).

# R: 

# a) Quais os tipos de classificação de computadores serão necessários para a operação deste SUV voador? 
# Justifique sua resposta.
# O SUV voador precisará de três tipos principais de computadores:
# Sistemas embarcados em tempo real para controlar os rotores e a estabilização, garantindo respostas imediatas e seguras.
# Computadores de alto desempenho para processar dados de navegação, como GPS e sensores, e tomar decisões rápidas.
# Sistemas de bordo para a interface com passageiros, como telas de toque e conexão com aplicativos (ex: Uber). Esses computadores
# são essenciais porque cada um cuida de uma parte crítica do voo, desde o controle físico até a experiência do usuário.

# b) Arquiteturas Harvard vs. von Neumann e pseudoinstruções:

# Controle e navegação usam Harvard (ex: cálculos de rota em tempo real), pois separa memória de dados e instruções, agilizando 
# processos críticos. Pseudoinstruções como mov.s $f0, $f1 (para cálculos com floats) são comuns.
# Aplicativos e interface usam von Neumann (ex: app do passageiro), por ser mais flexível para carregar diferentes programas. 
# Pseudoinstruções como li $v0, 4 (para exibir mensagens) são frequentes.
# A Harvard é melhor para tarefas rápidas e previsíveis, enquanto a von Neumann serve para sistemas que precisam de versatilidade.

# c) Código simplificado para cálculo de tempo de voo:
# O código em MIPS-32 abaixo calcula o tempo de voo com base na distância digitada pelo usuário e uma velocidade fixa (ex: 120 km/h):

.data
    pergunta:    .asciiz "Distância (km): "
    resposta:    .asciiz "Tempo: "
    minutos:     .asciiz " minutos\n"
    vel:         .float 120.0
    const_60:    .float 60.0    # Constante para conversão

.text
.globl main

main:
    # Pergunta a distância
    li $v0, 4
    la $a0, pergunta
    syscall

    # Lê a distância (float)
    li $v0, 6
    syscall
    mov.s $f1, $f0        # Guarda a distância em $f1

    # Carrega constantes
    lwc1 $f2, vel         # Velocidade média
    lwc1 $f3, const_60    # Fator de conversão

    # Calcula tempo (horas = distância/velocidade)
    div.s $f4, $f1, $f2

    # Converte para minutos (×60)
    mul.s $f5, $f4, $f3

    # Exibe resultado
    li $v0, 4
    la $a0, resposta
    syscall

    li $v0, 2
    mov.s $f12, $f5
    syscall

    li $v0, 4
    la $a0, minutos
    syscall

    # Encerra
    li $v0, 10
    syscall
