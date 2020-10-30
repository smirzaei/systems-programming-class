STK     SEGMENT
        DW 32 DUP(?)
STK     ENDS
DTS     SEGMENT
MAX     DB 80 ; maximum number of characters than can be entered
LEN     DB ?  ; the actual number of entered characters
STRING  DB 80 DUP(?)
MSG     DB 'Please enter up to 80 characters', 0AH, 0DH, '$' ; 0DH = \r - 0AH = \n
DTS     ENDS
CDS     SEGMENT
        ASSUME CS:CDS,SS:STK,DS:DTS
MAIN    PROC    FAR
        MOV AX,SEG DTS
        MOV DS,AX

        MOV AX,0B800H
        MOV ES,AX

        ;SET VIDEO MODE
        MOV AX, 3
        INT 10H

        ; CANCEL BLINKING AND ENABLE 16 COLORS
        MOV AX, 1003H
        MOV BX,0
        INT 10H

        ; Display the message
        MOV AH,09H
        MOV DX,OFFSET MSG
        INT 21H

        ; Read user input
        MOV AH,0AH
        MOV DX,OFFSET MAX ; Don't take more than 80 bytes
        INT 21H

        MOV BX,OFFSET STRING
        MOV AL,LEN
        MOV AH,0
        ADD BX,AX
        MOV BYTE PTR [BX], '$'

        MOV CX,80
        
        MOV BP,OFFSET STRING
        MOV BH,0
        MOV BL,80H
        MOV DL,0
        MOV DH,5
        INT 10H


        ; Terminate the program
        MOV AH,4CH
        INT 21H
        RET
MAIN    ENDP
CDS     ENDS
        END     MAIN
