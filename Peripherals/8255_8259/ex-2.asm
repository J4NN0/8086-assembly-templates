portA EQU 80h
portB EQU portA+1
portC EQU portA+2
control EQU portA+3
pic EQU 40h

#start=8259.exe#

.MODEL SMALL
.STACK
.DATA

myword dd 0CAF45K9DH 
count dw 3

.CODE
.STARTUP

cli
call init_8255
call init_8259
call init_ivt
sti

INT 26H

block:
    jmp block

.EXIT

init_8255 proc near
    mov dx, control
    mov al, 10100000b ;MODE 1 - GROUP A OUTPUT
    out dx, al
    
    mov al, 00001101b ;Enabling interrupt for portA
    out dx, al

    ret
init_8255 endp

init_8259 proc near
    mov dx, pic
    mov al, 00011011b ;ICW1
    out dx, al             
    
    mov dx, pic+1
    mov al, 00100000b ;ICW2
    out dx, al
    
    mov al, 00000011b ;ICW4
    out dx, al
    
    mov al, 10111111b ;0CW1
    out dx, al
    
    ret
init_8259 endp  

init_ivt proc
    push ds
    
    mov ax, 0
    mov ds, ax
    mov bx, 00100110b
    mov cl, 2
    shl bx, cl
    
    
    mov ax, offset isr_pa_out
    mov ds:[bx], ax
    mov ax, seg isr_pa_out
    mov ds:[bx+2], ax
    
    pop ds
    
    ret
init_ivt endp

isr_pa_out proc
    push si
    push bx
    push dx
    
    lea si, myword
    mov bx, count
    
    mov dx, portA
    mov al, [si+bx] ;highest part
    out dx, al      ;print
    
    dec count
    
    pop dx
    pop bx
    pop si
    
    iret
isr_pa_out endp

END