.model SMALL
.stack
.data

.code
.startup

MOV CL, 112
MOV DX, 4

PUSH CX ;1) PUSH NUMBER
PUSH DX ;2) PUSH BIT TO SHIFT
CALL SHIFT_BIT
POP DX ;IT WILL CONTAIN THE RESULT
POP CX ;IT WILL CONTAIN THE SHIFTED NUMBER

.exit    

SHIFT_BIT PROC NEAR ;AL NUMBER - BL NUMBER OF BIT TO SHIFT - CL RESULT
    PUSH BP
    MOV BP, SP
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AL, [BP+6]
    MOV BL, [BP+4]
    MOV CL, 0
    
    SHIFT_LOOP: SHL AL, 1
                JC MUL_BIT
                DEC BL
                JNZ SHIFT_LOOP
                JMP END_SHIFT
         
    MUL_BIT: MOV DH, BL
             MOV DL, 2
             CALL POWER ;DL WILL CONTAIN DL^DH
             ADD CL, DL
             DEC BL
             JNZ SHIFT_LOOP
               
    END_SHIFT: MOV [BP+4], CL
    
    POP DX
    POP CX
    POP BX
    POP AX
    POP BP    
    RET
SHIFT_BIT ENDP

POWER PROC NEAR ;DL^DH
    PUSH AX
    PUSH BX
    PUSH CX
    
    MOV AL, 1
    
    DEC DH
    CMP DH, 0
    JBE END_CYCLE
    
    CYCLE: MUL DL
           DEC DH
           JNZ CYCLE
           
    END_CYCLE: MOV DL, AL 
       
    POP CX
    POP BX
    POP AX
    RET
POWER ENDP

end