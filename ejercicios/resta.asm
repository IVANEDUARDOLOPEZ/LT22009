section .data
    num1 dw 10
    num2 dw 4
    num3 dw 2
    msg db 'Resultado: ', 0
    result db 0

section .text
    global _start

_start:
    ; Cargamos el primer número en AX
    mov ax, [num1]
    
    ; Restamos el segundo número
    sub ax, [num2]

    ; Restamos el tercer número
    sub ax, [num3]

    ; En este punto, AX contiene el resultado de (num1 - num2 - num3)
    ; Convertimos el resultado a ASCII
    add ax, '0'          ; Convertir a carácter ASCII
    mov [result], al     ; Guardar en result (solo el byte bajo de AX)

    ; Llamada al sistema para escribir en la salida estándar
    mov eax, 4           ; syscall número para sys_write
    mov ebx, 1           ; file descriptor 1 es stdout
    mov ecx, msg         ; puntero al mensaje
    mov edx, 11          ; longitud del mensaje
    int 0x80             ; interrupción para llamada al sistema

    ; Escribir el resultado
    mov eax, 4           ; syscall número para sys_write
    mov ebx, 1           ; file descriptor 1 es stdout
    mov ecx, result      ; puntero al resultado
    mov edx, 1           ; longitud del resultado (1 byte)
    int 0x80             ; interrupción para llamada al sistema

    ; Llamada al sistema para salir del programa
    mov eax, 1           ; syscall número para sys_exit
    xor ebx, ebx         ; estado de salida 0
    int 0x80             ; interrupción para llamada al sistema

