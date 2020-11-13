TITLE CLASS ASSIGNMENT 3
        .model      small
        .stack      64
        .data
max     db  80
len     db  ?
str1    db  80 dup(?)
        .code
; ---------------------------------------------------------------------
mac1    macro
        mov     ah,07
        int     21h
endm
; ---------------------------------------------------------------------
mac2    macro   char
        mov     ah,02
        mov     dl,char
        int     21h
endm
; ---------------------------------------------------------------------
mac3    macro   max
        mov     ah,0ah
        mov     dx,offset max
        int     21h

        ; Add $ at the end of the string
        mov     si, offset max + 1
        mov     cl,[si]
        xor     ch,ch
        inc     cx
        add     si,cx
        mov     al,'$'
        mov     [si],al
endm
; ---------------------------------------------------------------------
mac4    macro   resh
        mov     ah,09h
        mov     dx,resh
        int     21h
endm
; ---------------------------------------------------------------------
newLine macro
; Print a new line
        mov     ah,02

        mov     dl,0dh ; CR
        int     21h

        mov     dl,0ah ; LF
        int     21h
endm
; ---------------------------------------------------------------------
main    proc
        mov     ax,@data
        mov     ds,ax

        mac1
        mac2    al
        newLine
        mac3    max
        newLine

        mov dx, offset str1
        mac4    dx


        ; exit
        mov     ah,4ch
        int     21h
main    endp
        end     main
