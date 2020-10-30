; This is incomplete
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

        MOV AH,02H
        ; \t
        MOV DL,09H
        INT 21H

        ; \t
        MOV DL,09H
        INT 21H

        ; Display STRING variable (user input)
        MOV AH,09H
        MOV DX, OFFSET STRING
        INT 21H

        MOV AH,02H
        ; \N
        MOV DL,0AH
        INT 21H

        ; \R
        MOV DL,0DH
        INT 21H


;         MOV AH,02H
;         MOV CX, [LEN]
;         MOV DL,'*'

; L1:     INT 21H
;         LOOP L1


        ; Terminate the program
        MOV AH,4CH
        INT 21H
        RET
MAIN    ENDP
CDS     ENDS
        END     MAIN
