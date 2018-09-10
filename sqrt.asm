.model SMALL
.stack
.data

VAR DW 4

.code
.startup

MOV AX, VAR
PUSH AX
CALL SQRT
POP AX ;IT WILL CONTAIN SQRT(AX)

.exit

SQRT PROC NEAR
    PUSH BP
    MOV BP, SP
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AX, [BP+4]
    MOV BX, 0
    MOV CX, 0
    
    SQRT_LOOP: ADD BX, 2
               INC CX
               SUB AX, BX
               CMP AX, 0
               JGE SQRT_LOOP
    
    MOV [BP+4], CX ;RESULT OF SQRT          
    
    POP DX
    POP CX
    POP BX
    POP AX
    POP BP
    RET
SQRT ENDP

end