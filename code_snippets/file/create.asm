; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
f_name  db 'file_name.txt,0
f_handle dw ?
fc_smsg db 'FILE CREATED SUCCESSFULLY',10,13, '$'
fc_fmsg db 'FAILED TO CREATE THE FILE',10,13, '$'
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far

        ; Create File
        mov ah,3ch
        mov cx,0
        mov dx,offset f_name
        int 21h ; CF=0 if OK, AX= File Handle CF=1 Error AX=Error code

        jnc file_create_ok

        file_create_nok:
        mov ah,09h
        mov dx,offset fc_fmsg
        int 21h
        jmp     exit

        file_create_ok:
        mov f_hndle,ax
        mov ah,09h
        mov dx,offset fc_smsg
        int 21h

exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end     main
