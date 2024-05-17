section .data
    num1 dd 8           ; Dividendo
    num2 dd 4           ; Divisor
    Resultado dd 0      ; Variable para el resultado
    Residuo dd 0        ; Variable para el residuo
    msg_result db "El resultado de la división es: "
    len_msg_result equ $ - msg_result
    msg_residue db "Su residuo es: "
    len_msg_residue equ $ - msg_residue
    newline db 10       ; Nueva línea

section .text
    global _start

_start:
    ; Dividir eax entre num2 (divisor), el resultado se almacena en eax y el residuo en edx
    mov eax, dword [num1]
    xor edx, edx         ; Limpiamos edx (registro para el residuo)
    div dword [num2]     ; Divide eax (dividendo) por num2 (divisor)

    ; Convertir el resultado de la división en ASCII y almacenar en el buffer Resultado
    add eax, '0'         ; Convertir el resultado a ASCII
    mov [Resultado], eax ; Almacenar el resultado en Resultado

    ; Convertir el residuo en ASCII y almacenar en el buffer Residuo
    add edx, '0'         ; Convertir el residuo a ASCII
    mov [Residuo], edx   ; Almacenar el residuo en Residuo

    ; Mostrar mensaje de resultado de la división
    mov eax, 4           ; syscall número para sys_write
    mov ebx, 1           ; file descriptor 1 es stdout
    mov ecx, msg_result  ; puntero al mensaje de resultado
    mov edx, len_msg_result ; longitud del mensaje de resultado
    int 0x80             ; interrupción para llamada al sistema

    ; Mostrar el resultado de la división
    mov eax, 4           ; syscall número para sys_write
    mov ebx, 1           ; file descriptor 1 es stdout
    mov ecx, Resultado   ; puntero al resultado
    mov edx, 1           ; longitud del resultado (1 byte)
    int 0x80             ; interrupción para llamada al sistema

    ; Mostrar nueva línea
    mov eax, 4           ; syscall número para sys_write
    mov ebx, 1           ; file descriptor 1 es stdout
    mov ecx, newline     ; puntero a la nueva línea
    mov edx, 1           ; longitud de la nueva línea (1 byte)
    int 0x80             ; interrupción para llamada al sistema

    ; Mostrar mensaje de residuo
    mov eax, 4           ; syscall número para sys_write
    mov ebx, 1           ; file descriptor 1 es stdout
    mov ecx, msg_residue ; puntero al mensaje de residuo
    mov edx, len_msg_residue ; longitud del mensaje de residuo
    int 0x80             ; interrupción para llamada al sistema

    ; Mostrar el residuo de la división
    mov eax, 4           ; syscall número para sys_write
    mov ebx, 1           ; file descriptor 1 es stdout
    mov ecx, Residuo     ; puntero al residuo
    mov edx, 1           ; longitud del residuo (1 byte)
    int 0x80             ; interrupción para llamada al sistema

    ; Mostrar nueva línea
    mov eax, 4           ; syscall número para sys_write
    mov ebx, 1           ; file descriptor 1 es stdout
    mov ecx, newline     ; puntero a la nueva línea
    mov edx, 1           ; longitud de la nueva línea (1 byte)
    int 0x80             ; interrupción para llamada al sistema

    ; Llamada al sistema para salir del programa
    mov eax, 1           ; syscall número para sys_exit
    xor ebx, ebx         ; estado de salida 0
    int 0x80             ; interrupción para llamada al sistema

