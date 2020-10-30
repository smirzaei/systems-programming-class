STK     SEGMENT
        DW 32 DUP(?)
STK     ENDS
CDS     SEGMENT
        ASSUME CS:CDS,SS:STK
MAIN    PROC    FAR
        ;SET VIDEO MODE
        MOV AX, 3
        INT 10H

        ; CANCEL BLINKING AND ENABLE 16 COLORS
        MOV AX, 1003H
        MOV BX,0
        INT 10H

        MOV CX,26
        CLD ; DF=0
        MOV AX,0B800H
        MOV ES,AX
        MOV DI,0
        MOV AL,'A'
        MOV AH,80H
L1:     STOSW ; Move AX to ES:DI
        INC AL
        INC AH
        LOOP L1

        MOV AH,4CH
        INT 21H
MAIN    ENDP
CDS     ENDS
        END     MAIN
