portA EQU 80h
portB EQU portA+1
portC EQU portA+2
control EQU portA+3
pic EQU 40h
control EQU 63h

#start=8259.exe#

.MODEL small
.STACK
.DATA

isPrime dw ?
var db 2    
    
.CODE
.STARTUP
    
call init_ivt
call init_8259
;call init_8255
call init_8253 ;enough for (1)

xor ax, ax
LOOP:
    inc ax
    jmp LOOP
    
.EXIT

init_8259 proc near
    mov dx, pic
    mov al, 00011011b ;ICW1
    out dx, al             
    
    mov dx, pic+1
    mov al, 00100000b ;ICW2
    out dx, al
    
    mov al, 00000011b ;ICW4
    out dx, al
    
    mov al, 11111101b ;0CW1
    out dx, al
    
    ret
init_8259 endp  

init_ivt proc
    push ds
    
    mov ax, 0
    mov ds, ax
    mov bx, 00100011b
    mov cl, 2
    shl bx, cl
    
    
    mov ax, offset isr_set
    mov ds:[bx], ax
    mov ax, seg isr_set
    mov ds:[bx+2], ax
    
    pop ds
    
    ret
init_ivt endp

init_8253 proc
    push ax
    push dx
    
    mov al, 00110000b ;control register
    mov dx, control
    out dx, al
    
    mov al, 70h ;LSB
    out 60h, al     
    mov al, 17h ;MSB
    out 60h, al
     
    pop dx
    pop ax
    ret
init_8253 endp

isr_set proc near 
    push dx

SEARCH_PRIME:    
    mov dx, ax ;backup ax
    div var
    cmp ah, 0
    je NOTPRIME
    inc var
    mov ax, dx
    cmp WORD PTR var, ax
    jne SEARCH_PRIME

    ;is prime
    mov dx, 1
    mov isPrime, dx

jmp NEXT
NOTPRIME:
    mov dx, 0
    mov isPrime, dx    
        
NEXT:
    pop dx
    
    iret        
isr_set endp

END