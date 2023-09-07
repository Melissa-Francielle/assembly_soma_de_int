segment .data ;Uma biblioteca para facilitar o acesso aos comandos do assembly
  LF        equ 0xA  ; Line Feed
  NULL      equ 0xD  ; Final da String
  SYS_CALL  equ 0x80 ; Envia informacao ao SO
  ; EAX
  SYS_EXIT  equ 0x1  ; Codigo de chamada para finalizar
  SYS_READ  equ 0x3  ; Operacao de leitura
  SYS_WRITE equ 0x4  ; Operacao de escrita
  ; EBX
  RET_EXIT  equ 0x0  ; Operacao realizada com Sucesso
  STD_IN    equ 0x0  ; Entrada padrao
  STD_OUT   equ 0x1  ; Saida padrao
  STD_ERR   equ 0x2    ; System.err
  
section .data ;aqui foi utilizado para somente as mensagens que irão surgir na saída 
    mensagem1 db " | Digite o valor do primeiro numero: " ;o ponteiro que irá apontar para a variavel str
    tam equ $- mensagem1 ; pega o tamanho da primeira mensagem e vai ate seu final
    mensagem2 db " | Digite o valor do segundo numero: " 
    tam2 equ $- mensagem2 ; a mesma coisa ocorre com a mensagem 2
    mensagem3 db " | A soma de "
    tamResultado equ $- mensagem3 ; mensagem 3, ficou desta forma para atender os padrões do formato C
    mensagem4 db " e "
    tamResultado1 equ $- mensagem4
    mensagem5 db " eh: "
    tamResultado2 equ $- mensagem5
    ; o mesmo ocorre para 4 e 5 para atenderem o formato da saída do codigo em C

section .bss ; inicializamos "variaveis" com o tamanho que elas conseguem ler
    num1 resb 3
    num2 resb 3
    resultado resb 4 ;o resultado deveria devolver saídas com mais de 2 casas

section .text ;começamos nosso código 

global _start 

_start:
    ; a impressao da mensagem 1 para o usuario colocar o primeiro valor
    mov EAX, SYS_WRITE ;o valor de SYS será colocado no registrado
    mov EBX, STD_OUT ; acessa a memoria da op efetuada por eax, e é colocado no registrador ebx
    mov ECX, mensagem1 ; colocado no registrado ecx contendo um texto para saida
    mov EDX, tam ;armazena um valor contido em na variavel, represeentando o tamanho da nossa mensagem  
    int SYS_CALL   ; finaliza o programa para ele executar a op
    
    mov EAX, SYS_READ ; a mesma coisa irá ocorrer nesse eax, o valor de SYS será colocado no registrado no eax, porém com a chamada de leitura
    mov EBX, STD_IN ;acessa a memoria para entrada, carregado no ebx, identificando a origem de entrada
    mov ECX, num1 ; entrada do numero
    mov EDX, 3 ; o tamanho dado para poder colocar valores de 2 casas
    int SYS_CALL ;finaliza para o programa poder executar

    ; mesma operação de mensagem que ocorreu em mensagem 1,  ;o valor de SYS será colocado no registrado
    ; acessa a memoria da op efetuada por eax, e é colocado no registrador ebx
    ;colocado no registrado ecx contendo um texto para saida
    ;armazena um valor contido em na variavel, represeentando o tamanho da nossa mensagem  
    ;finaliza o programa para ele executar
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, mensagem2
    mov EDX, tam2
    int SYS_CALL
    
    ;Mesma operação irá ocorrer em num1, a mesma coisa irá ocorrer nesse eax, o valor de SYS será colocado no registrado no eax, porém com a chamada de leitura
    ;;acessa a memoria para entrada, carregado no ebx, identificando a origem de entrada
    ; acessa a memoria, para poder ter a entrada
    ; le o valor atribuido ao num2,  o tamanho dado para poder colocar valores de 2 casas
    ;finaliza para o programa poder executar
    mov EAX, SYS_READ
    mov EBX, STD_IN
    mov ECX, num2
    mov EDX, 3
    int SYS_CALL
    ;ambos terminam com SYS CALL para poderem finalizar o programa e ele executar 
    
    
    mov al, [num1] ; mov o valor armazenado na memoria da referencia de num1
    sub al, '0' ; apos isso é subtraido o valor de 0 em al, para conversão dos caractere numerico
    mov bl, [num2] ; a mesma coisa vai ocorrer em num2
    sub bl, '0'; e o mesmo tbm ocorre para bl
    
    add al, bl ;aqui é feita a soma dos valores
    add al, '0';aqui o codigo estará fazendo o inverso de sub al '0' irá converter um valor inteiro em seu caractere equivalente na tabela do assembly
    mov [resultado], al ; e armazena em resultado
    
    ;aqui será o mesmo processo visto em Mensagem1 e mensagem2
    mov eax, SYS_WRITE
    mov ebx, STD_OUT
    mov ecx, mensagem3
    mov edx, tamResultado
    int SYS_CALL
    
    ;para seguir a ordem do printf em C do código dado, foi colocado novamente a referencia do valor 1
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, num1
    mov EDX, 1
    int SYS_CALL ;ao finalizar a instrução com sys call o valor dado para 1 será colocado na frase 
    
    ;Aqui fará a mesma op de mensagem3 onde trás/chama a mensagem 4
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, mensagem4
    mov EDX, tamResultado1
    int SYS_CALL
    
    ;para gerar a mensagem semelhante chama o segundo valor para que ele também apareça na mensagem final
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, num2
    mov EDX, 1
    int SYS_CALL
    
    ;faz a chamada da mensagem 5 da mesma forma que as mensagens anteriores.
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, mensagem5
    mov EDX, tamResultado2
    int SYS_CALL
    
    ;Traz o resultado por fim
    mov EAX, SYS_WRITE
    mov EBX, STD_OUT
    mov ECX, resultado
    mov EDX, 1
    int SYS_CALL
    
    ;Sai do programa finalizando ele
    mov EAX, SYS_EXIT
    mov EBX, RET_EXIT
    INT SYS_CALL
