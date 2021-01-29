; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
msg     db  'Hello, World!', 0dh, 0ah, '$'
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far

        ; Write message
        mov ah,09h
        mov dx, offset msg
        int 21h

exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end     main
