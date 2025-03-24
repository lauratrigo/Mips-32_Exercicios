C:

#include <stdio.h>

int main() {

    prinf("Hello World");

    return 0;
}


MIPS 32:

.data 
	# área para dados na memória principal
	msg: .asciiz "Hello World!" # mensagem a ser exibida para o usuário

.text 
	# área para as instruções do programa

	li $v0, 4 	# intrução para impressão de string: li $v0, 4
	la $a0, msg 	# indica o endereço que está a mensagem
	syscall 	# faz a impressão
