TITLE CLASS ASSIGNMENT 6
        .model  small
        .stack  64
        .data
f_name  db      'fl.txt',0
f_hndle dw      ?
msg     db      'Hello, World!'
msg_sz  db      13

fc_smsg db 'FILE CREATED SUCCESSFULLY',10,13, '$'
fc_fmsg db 'FAILED TO CREATE THE FILE',10,13, '$'

fo_smsg db 'FILE OPENED SUCCESSFULLY',10,13, '$'
fo_fmsg db 'FAILED TO OPEN THE FILE',10,13, '$'

fw_smsg db 'SUCCESSFULLY WRITTEN TO THE FILE',10,13, '$'
fw_fmsg db 'FAILED TO WRITE TO THE FILE',10,13, '$'

fl_smsg db 'FILE CLOSED SUCCESSFULLY',10,13, '$'
fl_fmsg db 'FAILED TO CLOSE THE FILE',10,13, '$'
        .code
; ------------------------------------------------------------------------------
main    proc
        mov     ax,@data
        mov     ds,ax

        ; Create File
        mov     ah,3ch
        mov     cx,0
        mov     dx,offset f_name
        int     21h

        jnc file_create_ok

file_create_nok:
        mov     ah,09h
        mov     dx,offset fc_fmsg
        int     21h
        jmp     exit

file_create_ok:
        mov     f_hndle,ax
        mov     ah,09h
        mov     dx,offset fc_smsg
        int     21h

;--- Open file
        mov     al,02  ; read/write
        mov     ah,3dh ; open the file
        mov     dx,offset f_name
        int     21h
        jnc     file_open_ok

file_open_nok:
        mov     ah,09h
        mov     dx,offset fo_fmsg
        int     21h
        jmp     exit

file_open_ok:
        mov     f_hndle,ax
        mov     ah,09h
        mov     dx,offset fo_smsg
        int     21h

;--- Write to file
        mov     ah,40h
        mov     cl,msg_sz
        xor     ch,ch
        mov     bx,f_hndle
        mov     dx,offset msg
        int     21h

        jnc     file_write_ok

file_write_nok:
        mov     ah,09h
        mov     dx,offset fw_fmsg
        int     21h
        jmp     exit

file_write_ok:
        mov     ah,09h
        mov     dx,offset fw_smsg
        int     21h

;--- Close the file
        mov     ah,3eh
        mov     bx,f_hndle
        int     21h
        jnc     file_close_ok

file_close_nok:
        mov     ah,09h
        mov     dx,offset fl_fmsg
        int     21h
        jmp     exit

file_close_ok:
        mov     ah,09h
        mov     dx,offset fl_smsg
        int     21h

exit:   mov     ah,4ch
        int     21h
main    endp
        end     main

