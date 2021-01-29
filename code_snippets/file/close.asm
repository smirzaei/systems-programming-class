; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
f_handle dw ?
fl_smsg db 'FILE CLOSED SUCCESSFULLY',10,13, '$'
fl_fmsg db 'FAILED TO CLOSE THE FILE',10,13, '$'
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far

        ; Close file
        mov ah,3eh
        mov bx,f_hndle
        int 21h
        jnc file_close_ok

        file_close_nok:
        mov ah,09h
        mov dx,offset fl_fmsg
        int 21h
        jmp exit

        file_close_ok:
        mov ah,09h
        mov dx,offset fl_smsg
        int 21h

exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end main

