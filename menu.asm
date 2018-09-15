.model SMALL
.stack
.data

STR1 DB '1) Item 1 ', 10, 13, '$'
STR2 DB '2) Item 2 ', 10, 13, '$' 
STR3 DB '3) Item 3 ', 10, 13, '$'
STR4 DB '4) Item 4 ', 10, 13, '$'
MSG_CHOICE DB 'Enter your choice: ', '$'  
MSG_ERR DB 10, 13, 'This choice doesnt exist! ', 10, 13, '$'  
       
1C DB 10, 13, '-> First part...', 10, 13, '$' 
2C DB 10, 13, '-> Second part...', 10, 13, '$'
3C DB 10, 13, '-> Third part...', 10, 13, '$'
4C DB 10, 13, '-> Forth part...', 10, 13, '$' 

.code
.startup

MOV DX, OFFSET STR1
MOV AH, 09
INT 21H
MOV DX, OFFSET STR2
MOV AH, 09
INT 21H
MOV DX, OFFSET STR3
MOV AH, 09
INT 21H
MOV DX, OFFSET STR4
MOV AH, 09
INT 21H
MOV DX, OFFSET MSG_CHOICE
MOV AH, 09
INT 21H

MOV AH, 01
INT 21H
SUB AL, '0'

CMP AL, 1
JE FIRST
CMP AL, 2
JE SECOND
CMP AL, 3
JE THIRD
CMP AL, 4
JE FORTH

FIRST: MOV DX, OFFSET 1C
       MOV AH, 09
       INT 21H
       
       ;CODE ...
       
       JMP END_MENU
       
SECOND: MOV DX, OFFSET 2C
        MOV AH, 09
        INT 21H
       
        ;CODE ...
       
        JMP END_MENU

THIRD: MOV DX, OFFSET 3C
       MOV AH, 09
       INT 21H
       
       ;CODE ...
       
       JMP END_MENU
       
FORTH: MOV DX, OFFSET 4C
       MOV AH, 09
       INT 21H
       
       ;CODE ...
       
       JMP END_MENU 

END_MENU:

.exit
end
