section .data
    num1 db 5      ; Primer número a multiplicar
    num2 db 5      ; Segundo número a multiplicar
    msg db 'Resultado: ', 0
    result db 0, 0 ; Variable para almacenar el resultado (dos bytes para dos dígitos)

section .text
    global _start

_start:
    ; Cargamos el primer número en AL
    mov al, [num1]
    
    ; Multiplicamos el segundo número
    mul byte [num2]

    ; Convertir el resultado a ASCII
    mov bh, 10       ; Cargamos 10 en bh
    mov bl, 0        ; Limpiamos bl
    div bh           ; Dividimos el resultado por 10 (ah = cociente, al = resto)
    add al, '0'      ; Convertimos el resto a ASCII
    mov [result], al ; Almacenamos el dígito de las unidades
    
    mov al, ah       ; Movemos el cociente a al para dividirlo nuevamente
    add al, '0'      ; Convertimos el cociente a ASCII
    mov [result+1], al ; Almacenamos el dígito de las decenas

    ; Llamada al sistema para escribir en la salida estándar
    mov eax, 4        ; syscall número para sys_write
    mov ebx, 1        ; file descriptor 1 es stdout
    mov ecx, msg      ; puntero al mensaje
    mov edx, 11       ; longitud del mensaje
    int 0x80          ; interrupción para llamada al sistema

    ; Escribir el resultado
    mov eax, 4        ; syscall número para sys_write
    mov ebx, 1        ; file descriptor 1 es stdout
    mov ecx, result   ; puntero al resultado
    mov edx, 2        ; longitud del resultado (2 bytes)
    int 0x80          ; interrupción para llamada al sistema

    ; Llamada al sistema para salir del programa
    mov eax, 1        ; syscall número para sys_exit
    xor ebx, ebx      ; estado de salida 0
    int 0x80          ; interrupción para llamada al sistema

