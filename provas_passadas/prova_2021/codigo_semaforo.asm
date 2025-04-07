# Suponha que um automóvel seja autônomo, interligado com os sistemas de sinais de uma cidade inteligente. A central eletrônica deste
# automóvel precisa calcular a aceleração/desaceleração que precisará submeter o veículo de forma que o mesmo pegue a chamada “onda verde” 
# (se passar por um sinal verde, todos os demais também precisarão estar verdes ainda). Tendo isto como premissa, faça o que se pede abaixo:
# a) Indique quais classes de computadores serão necessárias para este modelo.
# b) Faça um código em C e em MIPS-32 Assembler que receba como entrada de I/O os sensores de velocidade, posição do automóvel em relação ao semáforo 
# e o tempo de sinal verde do mesmo e assim, o código fará os cálculos e disparará o comando para acionar mais ou menos o motor (Label). Lembre-se de 
# definir o espaço de dados.
# c) Faça o fluxograma dos modos de endereçamento utilizados no código da alínea anterior. 

Um automóvel autônomo integrado a sistemas de tráfego inteligente requer **quatro classes principais de computadores**: (1) **sistemas embarcados em tempo real (RTOS)** para controle preciso e imediato de aceleração, frenagem e direção, garantindo respostas determinísticas; (2) **computadores de alto desempenho** com capacidade para processar dados complexos de sensores (LIDAR, câmeras) e algoritmos de IA, responsáveis por calcular a trajetória e sincronizar com os semáforos; (3) **unidades de comunicação V2X** (Vehicle-to-Everything) para troca de dados em tempo real com a infraestrutura urbana, como semáforos e outros veículos, assegurando coordenação e redundância; e (4) **computadores de bordo** para interface com passageiros e exibição de informações em tempo real. Essa divisão equilibra **segurança** (RTOS), **processamento avançado** (IA), **conectividade** (V2X) e **usabilidade** (interface), permitindo que o veículo opere de forma autônoma e eficiente na "onda verde".

C:

#include <stdio.h>

int main() {
    float velocidade, distancia, tempo_verde, aceleracao;
    
    // Entrada de dados
    printf("Velocidade (m/s): ");
    scanf("%f", &velocidade);
    
    printf("Distancia (m): ");
    scanf("%f", &distancia);
    
    printf("Tempo verde (s): ");
    scanf("%f", &tempo_verde);
    
    // Cálculo básico
    if (distancia / velocidade <= tempo_verde) {
        aceleracao = 0;  // Mantém velocidade
    } else {
        // Fórmula simplificada: a = 2*(d - v*t)/t²
        aceleracao = 2 * (distancia - velocidade * tempo_verde) / (tempo_verde * tempo_verde);
        
        // Limites de segurança
        if (aceleracao > 2) aceleracao = 2;
        if (aceleracao < -3) aceleracao = -3;
    }
    
    // Saída do comando
    if (aceleracao > 0) {
        printf("Acelerar: %.2f m/s²\n", aceleracao);
    } else if (aceleracao < 0) {
        printf("Desacelerar: %.2f m/s²\n", -aceleracao);
    } else {
        printf("Manter velocidade\n");
    }
    
    return 0;
}


MIPS 32:

.data
    prompt_vel:     .asciiz "Velocidade (m/s): "
    prompt_dist:    .asciiz "Distancia (m): "
    prompt_temp:    .asciiz "Tempo verde (s): "
    msg_acelera:    .asciiz "Acelerar: "
    msg_desacelera: .asciiz "Desacelerar: "
    msg_mantem:     .asciiz "Manter velocidade\n"
    msg_units:      .asciiz " m/s²\n"
    newline:        .asciiz "\n"
    
    # Constantes float
    const_2:        .float 2.0
    const_3:        .float 3.0
    const_0:        .float 0.0

.text
.globl main

main:
    # Configuração inicial
    li $v0, 4
    la $a0, prompt_vel
    syscall
    
    # Ler velocidade
    li $v0, 6
    syscall
    mov.s $f1, $f0        # $f1 = velocidade
    
    # Ler distância
    li $v0, 4
    la $a0, prompt_dist
    syscall
    
    li $v0, 6
    syscall
    mov.s $f2, $f0        # $f2 = distancia
    
    # Ler tempo verde
    li $v0, 4
    la $a0, prompt_temp
    syscall
    
    li $v0, 6
    syscall
    mov.s $f3, $f0        # $f3 = tempo_verde
    
    # Calcular tempo_atual = distancia / velocidade
    div.s $f4, $f2, $f1   # $f4 = tempo_atual
    
    # if (tempo_atual <= tempo_verde)
    lwc1 $f5, const_0
    c.le.s $f4, $f3
    bc1t manter_vel
    
    # else: calcular aceleração
    lwc1 $f6, const_2
    mul.s $f7, $f1, $f3   # v * t
    sub.s $f8, $f2, $f7   # d - v*t
    mul.s $f8, $f8, $f6   # 2*(d - v*t)
    mul.s $f9, $f3, $f3   # t²
    div.s $f10, $f8, $f9  # a = 2*(d - v*t)/t²
    
    # Verificar limites
    lwc1 $f11, const_2
    c.le.s $f10, $f11
    bc1f limit_max
    lwc1 $f11, const_3
    neg.s $f11, $f11
    c.lt.s $f10, $f11
    bc1t limit_min
    j print_result
    
limit_max:
    lwc1 $f10, const_2
    j print_result
    
limit_min:
    lwc1 $f10, const_3
    neg.s $f10, $f10
    
print_result:
    # Verificar se acelera, desacelera ou mantém
    lwc1 $f5, const_0
    c.eq.s $f10, $f5
    bc1t manter_vel
    
    c.lt.s $f10, $f5
    bc1t desacelerar
    
    # Acelerar
    li $v0, 4
    la $a0, msg_acelera
    syscall
    
    li $v0, 2
    mov.s $f12, $f10
    syscall
    
    li $v0, 4
    la $a0, msg_units
    syscall
    
    j exit
    
desacelerar:
    li $v0, 4
    la $a0, msg_desacelera
    syscall
    
    li $v0, 2
    abs.s $f12, $f10
    syscall
    
    li $v0, 4
    la $a0, msg_units
    syscall
    
    j exit
    
manter_vel:
    li $v0, 4
    la $a0, msg_mantem
    syscall
    
exit:
    li $v0, 10
    syscall
