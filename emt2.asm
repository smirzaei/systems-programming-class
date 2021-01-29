STK     SEGMENT
        DW 64 DUP(?)
STK     ENDS
DTS     SEGMENT
p1      db 10,13,'ZF=  '
        db 10,13,'OF=   $'
zf      dw 6
OF      dw 11
DTS     ENDS
CDS     SEGMENT
        ASSUME CS:CDS,SS:STK,DS:DTS
MAIN    PROC    FAR
        MOV AX,SEG DTS
        MOV DS,AX

        mov ds,ax
        mov es,ax

        mov si,offset p1+6
        mov di,offset zf

        mov cl,0
        mov ch,4

        mov al,80h
        neg al

        pushf
        pop ax

        l1:
        mov bx,ax
        shr bx,cl
        and bl,1
        add bl,30h
        mov byte ptr [si],bl
        add si,7
        mov cl,byte ptr [di]
        inc di
        dec ch
        jne l1

        mov ah,09
        mov dx,offset p1
        int 21h

exit:   ; Terminate the program
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CDS     ENDS
        END     MAIN
