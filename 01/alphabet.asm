STK     SEGMENT
        DW 32 DUP(?)
STK     ENDS
DTSEG   SEGMENT
DTSEG   ENDS
CDS     SEGMENT
        ASSUME CS:CDS,SS:STK,DS:DTSEG
MAIN    PROC    FAR
        MOV CX,27
        CLD
        MOV AX,0B800H
        MOV ES,AX
        MOV DI,0
        MOV AL,'A'
        MOV AH,50H
L1:     STOSW
        INC AL
        INC AH
        LOOP L1
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CDS     ENDS
        END     MAIN
