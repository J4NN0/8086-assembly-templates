DIM EQU 5

.model SMALL
.stack
.data

ARRAY DB DUP 4, 2, 1, 5, 8
N DW ?
MAX DB ? 

.code
.startup

LEA SI, ARRAY
MOV N, DIM
CALL MAXIMUM

.exit

MAXIMUM PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR AX, AX
    MOV CX, N
    MOV AL, [SI]
    MOV MAX, AL
    INC SI
    
    SEARCH_MAX: XOR AX, AX
                MOV AL, [SI]
                CMP AL, MAX
                JA CHANGE_MAX
                
    CONTINUE_MAX: INC SI
                  DEC CX
                  JNZ SEARCH_MAX
                  JMP EXIT_MAX
    
    CHANGE_MAX: MOV MAX, AL
                JMP CONTINUE_MAX
    
    EXIT_MAX:
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
MAXIMUM ENDP

end