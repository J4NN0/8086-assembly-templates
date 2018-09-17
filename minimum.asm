DIM EQU 5

.model SMALL
.stack
.data

ARRAY DB DUP 4, 2, 1, 5, 8
N DW ?
MIN DB ? 

.code
.startup

LEA SI, ARRAY
MOV N, DIM
CALL MINIMUM

.exit

MINIMUM PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR AX, AX
    MOV CX, N
    MOV AL, [SI]
    MOV MIN, AL
    INC SI
    
    SEARCH_MIN: XOR AX, AX
                MOV AL, [SI]
                CMP AL, MIN
                JB CHANGE_MIN
                
    CONTINUE_MIN: INC SI
                  DEC CX
                  JNZ SEARCH_MIN
                  JMP EXIT_MIN
    
    CHANGE_MIN: MOV MIN, AL
                JMP CONTINUE_MIN
    
    EXIT_MIN:
    
    POP DX
    POP CX
    POP BX
    POP AX
    RET
MINIMUM ENDP

end