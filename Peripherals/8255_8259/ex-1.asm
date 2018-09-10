portA EQU 80h
portB EQU portA+1
portC EQU portA+2
control EQU portA+3
pic EQU 40h

#start=8259.exe#

.MODEL SMALL
.STACK
.DATA

myword dw ? 
count dw 0

.CODE
.STARTUP

cli
call init_8255
call init_8259
call init_ivt
sti

block:
    jmp block

.EXIT

init_8255 proc near
    mov dx, control
    mov al, 10110000b ;MODE 1 - GROUP A INPUT
    out dx, al
    
    mov al, 00001001b ;Enabling interrupt for portA
    out dx, al

    ret
init_8255 endp

init_8259 proc near
    mov dx, pic
    mov al, 00011011b ;ICW1
    out dx, al             
    
    mov dx, pic+1
    mov al, 00001000b ;ICW2
    out dx, al
    
    mov al, 00000011b ;ICW4
    out dx, al
    
    mov al, 01101111b ;OCW1
    out dx, al
    
    ret
init_8259 endp  

init_ivt proc
    push ds
    
    mov ax, 0
    mov ds, ax
    mov bx, 00001111b ;number of my peripheral (portA)
    mov cl, 2
    shl bx, cl ;address of ivt in which i have the address of isr
    
    mov ax, offset isr_pa_in
    mov ds:[bx], ax
    mov ax, seg isr_pa_in
    mov ds:[bx+2], ax
    
    pop ds
    
    ret
init_ivt endp

isr_pa_in proc
    push ax
    push bx
    push dx
    
    mov dx, portA
    in al, dx
    
    mov bx, 20 ;dim of count
    cmp count, bx
    jae NEXT
    
    cmp al, 'a'
    jae UPDATE
    cmp al, 'z'
    jbe UPDATE
    cmp al, 'A'
    jae UPDATE
    cmp al, 'Z'
    jbe UPDATE
    
    jmp NEXT
    
    UPDATE:
        lea si, myword
        add si, count
        mov [si], al
        inc count
    
    NEXT:
    pop dx
    pop bx
    pop ax
    
    iret
isr_pa_in endp

END