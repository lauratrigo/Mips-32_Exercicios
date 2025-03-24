# A instrução SLT (Set on Less Than) em MIPS define que se a comparação entre dois valores for verdadeira, o registrador terá valor
1, enquanto caso a comparação seja falsa, o registrador terá o valor 0

  
Mips 32:

li $T0, 0xAF02      # Carrega o valor 0xAF02 em $T0
li $T1, 0xAF10      # Carrega o valor 0xAF10 em $T1
SLT $T2, $T0, $T1   # Define $T2 com 1 se $T0 < $T1, caso contrário, 0


# li $T0, 0xAF02    # Carrega um valor imediato no registrador $T0, neste caso o 0xAF02 (hexadecimal) 1010 1111 0000 0010 (binário)
# li $T1, 0xAF10    # Carrega um valor imediato no registrador $T1, neste cado o 0xAF10 (hexadecimal) 1010 1111 0001 0000 (binário)
# SLT $T2, $T0, $T1 # SLT (Definir se Menor Que), compara os valores de $T0 e $T1 e define o valor de $T2:
    - Se $T0 for menor que $T1, então $T2 será 1.
    - Se $T0 não for menor que $T1, então $T2 será 0.
# Comparação: 
  - $T0 é 44802 em decimal
  - $T1 é 44816 em decimal
    - Como 0xAF02 (44802) é menor que 0xAF10 (44816), o valor que $T2 irá receber é 1, pois a condição de que $T0 é menor que $T1 é verdadeira.
