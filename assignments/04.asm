TITLE CLASS ASSIGNMENT 4
        .model  small
        .stack  64
        .data
CR      equ     0dh
LF      equ     0ah
msg1    db      'Please enter maximum 80 characters.', CR, LF, '$'
msg2    db      'Received:', CR, LF, '$'
max     db      80
len     db      ?
str1    db      80 dup('$')
        .code
; ------------------------------------------------------------------------------
getstr  macro
        mov     ah,0ah
        mov     dx,offset max
        int     21h
endm
; ------------------------------------------------------------------------------
shwstr  macro
        mov     ah,09h
        int     21h
endm
; ------------------------------------------------------------------------------
newLine macro
; Print a new line
        mov     ah,02

        mov     dl,CR ; CR
        int     21h

        mov     dl,LF ; LF
        int     21h
endm
; ------------------------------------------------------------------------------
main    proc
        mov     ax,@data
        mov     ds,ax

        mov     dx,offset msg1
        shwstr
        getstr

        newLine
        mov     dx,offset msg2
        shwstr

        mov     dx,offset str1
        shwstr

        mov     ah,4ch
        int     21h
main    endp
        end     main

