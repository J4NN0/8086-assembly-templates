.model SMALL
.stack
.data

VAR DW 2
EXP DW -2

.code
.startup

MOV AX, VAR
MOV BX, EXP
PUSH AX
PUSH BX
CALL POWER
POP BX
POP AX ;IT WILL CONTAIN VAR^EXP, IF EPX<0 TI WILL CONTAIN REST OF DIV

.exit

POWER PROC NEAR
    PUSH BP
    MOV BP, SP
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AX, [BP+6] ;VAR
    MOV CL, [BP+4] ;POWER
    MOV CH, 0
    MOV BX, AX ;COUNT
    
    ;AX^CX
    CMP CL, 1
    JE ONE_P
    
    CMP CL, 0
    JE ZERO_P
    JL SET_NEGATIVE
    JMP POSITIVE
    
    SET_NEGATIVE: NEG CL
                  MOV CH, 1 
    
    POSITIVE: DEC CL
    POSITIVE_P: MUL BX
                DEC CL
                JNZ POSITIVE_P
           
    MOV [BP+6], AX
    CMP CH, 1
    JE NEGATIVE_P
    JMP END_P 
    
    ONE_P: MOV [BP+6], AX
           JMP END_P
           
    
    ZERO_P: MOV [BP+6], 1
            JMP END_P
            
    NEGATIVE_P: MOV BX, AX
                MOV AX, 1
                DIV BX
                MOV [BP+6], DX 
                          
    END_P:
    
    POP DX   
    POP CX
    POP BX
    POP AX
    POP BP
    RET
POWER ENDP

end