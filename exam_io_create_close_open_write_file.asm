; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
f_name  db  'c:\exam.txt',0
f_hndl  dw  ?
p1      db  'Enter a message', 0dh, 0ah, $
e_msg   db 'ERROR`, 0dh, 0ah', $
max     db  80
len     db  ?
msg     db  80 dup('$')

buffer  db  80 dup(?)
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far
        ; write message
        mov ah,09h
        mov dx, offset p1
        int 21h

        ; get user input
        mov ah,0ah
        mov dx, offset max
        int 21h

        call crf
        jc error

        mov f_hndl,ax

        call wf
        jc error

        call cf

        jc error

        call of

        jc error
        mov f_hndl,ax

        call rf

        jc error

        ; write buffer
        mov ah,09h
        mov dx,offset buffer
        int 21h

        jmp exit

error:
        mov ah,09h
        mov dx, offset e_msg
        int 21h
exit:
        mov ah,4ch
        int 21h
main    endp
cds     ends
procs   segment
crf     proc near
        ; create file
        mov ah,3ch
        mov cx,0
        mov dx,offset f_name
        int 21h ; CF=0 if OK, AX= File Handle CF=1 Error AX=Error code
        ret
crf     endp
of      proc near
        ; open file
        mov al,0
        mov ah,3dh
        mov dx,offset f_name
        int 21h
        ret
of      endp
cf      proc near
        ; close file
        mov ah,3eh
        int 21h
        ret
cf      endp
rf      proc near
        ; read file
        mov ah,3fh
        mov bx,f_hndl
        mov dx,offset buffer
        mov cl,len
        mov ch,0
        int 21h
        ret
rf      endp
wf      proc near
        ;write to file
        mov ah,40h
        mov cl,len
        mov ch,0
        mov bx,f_hndl
        mov dx,offset msg
        ret
wf      endp
procs   ends

        end     main
