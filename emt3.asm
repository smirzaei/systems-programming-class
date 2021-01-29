STK     SEGMENT
        DW 64 DUP(?)
STK     ENDS
DTS     SEGMENT
        msg db '  :  ','$'
CDS     SEGMENT
        ASSUME CS:CDS,SS:STK,DS:DTS
MAIN    PROC    FAR
        MOV AX,SEG DTS
        MOV DS,AX

        MOV di,offset saat
        MOV ah,2ch
        INT 21h
        MOV al,ch
        call CHANGE
        add di,03
        MOV al,cl
        call CHANGE
        MOV dx,offset saat
        MOV ah,09h
        INT 21h
        MOV ah,4ch
        INT 21h

exit:   ; Terminate the program
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CHANGE proc far
        mov bl,10
        xor ah,ah
        div bl
        or ax,3030h
        mov[di],ax
        ret
CHANGE endp
CDS     ENDS
        END     MAIN
