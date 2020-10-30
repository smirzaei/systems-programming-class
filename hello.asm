; Display Hello world!
STK     SEGMENT
        DW 32 DUP(?)
STK     ENDS
DTS     SEGMENT
P1      DB 'Hello, World!$'
DTS     ENDS
CDS     SEGMENT
        ASSUME CS:CDS,SS:STK,DS:DTS
MAIN    PROC    FAR
        MOV AX,SEG DTS
        MOV DS,AX
        MOV AH,09
        MOV DX,OFFSET P1
        INT 21H
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CDS     ENDS
        END     MAIN
