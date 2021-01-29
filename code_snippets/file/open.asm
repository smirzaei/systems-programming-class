; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
f_name  db 'file_name.txt,0
f_handle dw ?
fo_smsg db 'FILE OPENED SUCCESSFULLY',10,13, '$'
fo_fmsg db 'FAILED TO OPEN THE FILE',10,13, '$'
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far

        ; Open file
        mov al,02  ; 0 Read 1 Write 2 Read/Write
        mov ah,3dh ; open the file
        mov dx,offset f_name
        int 21h ; Open File AX= file Handle CF= 0 if success CF=1 if Error
        jnc file_open_ok

        file_open_nok:
        mov ah,09h
        mov dx,offset fo_fmsg
        int 21h
        jmp exit

        file_open_ok:
        mov f_hndle,ax
        mov ah,09h
        mov dx,offset fo_smsg
        int 21h

exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end     main



