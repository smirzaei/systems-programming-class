; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
max     db  80
len     db  ?
string  db  80 dup('$')
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far

        ; Read user input
        mov ah,0ah
        mov dx, offset max
        int 21h

        ; now "len" contains the number of entered characters
        ; "string" contains the actual characters

exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end     main
