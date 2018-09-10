                                  portA EQU 80h
portB EQU portA+1
portC EQU portA+2
control8255 EQU portA+3
pic EQU 40h
control EQU 63h

#start=8259.exe#

.MODEL small
.STACK
.DATA

fib db 0
prev_fib db ?   
    
.CODE
.STARTUP
    
call init_ivt
call init_8259
call init_8255
call init_8253

LOOP:
    jmp LOOP
    
.EXIT

init_8255 proc near
    mov dx, control8255
    mov al, 10000000b ;MODE 0 - GROUP A OUTPUT
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
    
    mov al, 11111011b ;0CW1
    out dx, al
    
    ret
init_8259 endp  

init_ivt proc
    push ds
    
    mov ax, 0
    mov ds, ax
    mov bx, 00100010b
    mov cl, 2
    shl bx, cl
    
    
    mov ax, offset isr_fibonacci
    mov ds:[bx], ax
    mov ax, seg isr_fibonacci
    mov ds:[bx+2], ax
    
    pop ds
    
    ret
init_ivt endp

init_8253 proc
    push ax
    push dx
    
    mov al, 74h ;control register
    mov dx, control
    out dx, al
    
    mov al, 94h
    out dx, al
    
    mov dx, 60h ;counter 1
    mov ax, 5000 ;LSB
    out dx, al
    mov al, ah
    out dx, al ;MSB
    
    inc dx ;counter 2
    mov al, 200 ;LSB
    out dx, al
     
    pop dx
    pop ax
    ret
init_8253 endp

isr_fibonacci near 
    push ax
    push dx
    
    mov al, fib
    cmp al, 0
    jmp STANDARD
    
    cmp al, 233
    je END_FIBONACCI    
    
    add al, prev_fib ;al->new fibonacci
    mov ah, fib
    mov prev_fib, ah ;update previus fibonacci
    mov fib, al ;update new fibonacci
    
    mov dx, portA
    out dx, al
    
    call init_8253
    
    jmp END_FIBONACCI
    STANDARD: ;executed only ones, when fib=0
        mov dx, portA
        out dx, al
        call init_8253 
        inc fib 
        mov prev_fib, al ;al=0
        
    END_FIBONACCI:            
    
    pop dx
    pop ax
    
    iret       
isr_fibonacci endp

END