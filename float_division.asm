;==========================================================
; ; Float division

; ##CUSTOMIZE: this procedure assume a dvision between 2
; 8 bit operands. If you want to use word operands you have
; to make sure no overflow condition will show up.
; ##NOTE: This procedure calculates at max 2 fractional
; digits for sake of simplicity.
;==========================================================

.model SMALL
.stack
.data

DIVIDEND DB ? ;DIVIDEND OF THE DIVISION
DIVISOR DB ? ;DIVISOR OF THE DIVISION
Q_INTEGER DB ? ;INTEGER PART OF THE QUOTIENT
Q_FRACTIONAL DB ? ;FRACTIONAL PART OF THE QUOTIENT

.code
.startup

CALL FLOAT_DIVISION

.exit

FLOAT_DIVISION PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH SI
    
    XOR AX, AX
    MOV AL, DIVIDEND
    XOR BX, BX
    MOV BL, DIVISOR
    DIV BL
    MOV Q_INTEGER, AL ;STORES THE INTEGER PART
    MOV SI, 0
    
    FRACTIONAL_PART: MOV AL, AH ;MOVES THE REST OF DIV IN AL
                     XOR AH, AH ;RESET AH
                                ;NOW AX CONTAINS REST
                     MOV BL, 10
                     MUL BL
                     MOV BL, DIVISOR ;EXECUTING DIVISION OF REST
                     DIV BL
                     PUSH AX
                     CMP SI, 0
                     JNE INCREMENT_FRACTIONAL
                     XOR AH, AH
                     MOV BL, 10
                     MUL BL
                     
    INCREMENT_FRACTIONAL: ADD Q_FRACTIONAL, AL
                          POP AX
                          CMP AH, 0 ;STOP WHEN REST IS 0
                          JE END_FRACTIONAL_PART
                          INC SI
                          CMP SI, 1 ;OR WHEN 2 FLOAT DIGITS
                          JBE FRACTIONAL_PART
    
    END_FRACTIONAL_PART:
    
    POP SI
    POP CX
    POP BX
    POP AX
FLOAT_DIVISION ENDP

end