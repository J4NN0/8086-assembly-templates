.model SMALL
.stack
.data

OVERFLOW_STR DB 10, 13, 'OVERFLOW!', '$'

ARRAY DB 1, 2, 3
N DB 3
AVG DB ?

.code
.startup

LEA DI, ARRAY
CALL AVERAGE

.exit

AVERAGE PROC NEAR 
    PUSH AX 
    PUSH BX 
    PUSH CX 
    PUSH DX
    PUSH DI 

    MOV SI, WORD PTR N 
    XOR CX, CX 
    
    SCROLL_ELEM_AVG: MOV DX, CX 
                     MOV AL, [DI] 
                     MOV AH, 0 
                     ADD CX, AX 
                     
                     CMP CX, DX ;OVERFLOW CONTROL 
                     JL OVERFLOW_AVG 
                     
                     INC DI
                     DEC SI 
                     JNZ SCROLL_ELEM_AVG 
                     
                     MOV AX, CX ;PERFORM DIVISION 
                     MOV BL, BYTE PTR N 
                     DIV BL 
                     MOV AVG, AL 
                     JMP EXIT_AVG 
    
    OVERFLOW_AVG: MOV AH, 09h ;PRINT ALERT
                  MOV DX, OFFSET OVERFLOW_STR 
                  INT 21H 
     
    EXIT_AVG: 
    
    POP DI
    POP DX 
    POP CX
    POP BX 
    POP AX 
    RET 
AVERAGE ENDP

end