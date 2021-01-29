; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
msg     db 'Hello, World!'
msg_size 13
f_handle dw ?
fw_smsg db 'SUCCESSFULLY WRITTEN TO THE FILE',10,13, '$'
fw_fmsg db 'FAILED TO WRITE TO THE FILE',10,13, '$'
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far

        ; Write to file
        mov ah,40h
        mov cl,msg_size
        xor ch,ch
        mov bx,f_hndle
        mov dx,offset msg
        int 21h

        jnc file_write_ok

        file_write_nok:
        mov ah,09h
        mov dx,offset fw_fmsg
        int 21h
        jmp exit

        file_write_ok:
        mov ah,09h
        mov dx,offset fw_smsg
        int 21h
exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end     main

