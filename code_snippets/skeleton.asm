; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far
        mov ax,dts
        mov ds,ax

exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end     main
