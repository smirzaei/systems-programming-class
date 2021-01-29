; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
f_handle dw ?
buffer  db 20 dup(?)
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far

        ; Read file
        mov ah,3fh
        mov bx,f_handle
        mov dx,offset buffer
        mov cx,20 ; number of bytes to read from the file
        int 21h ; CF = 0 if everything is ok. CF = 1 if error (AX = err code)

        jnc file_read_ok

exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end     main






