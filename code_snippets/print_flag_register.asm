; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
msg
	    db 10,13,'CF=  '
	    db 10,13,'ZF=  '
    	db 10,13,'SF=  '
	    db 10,13,'OF=   $'
cf      db 0
zf  	db 6
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far
        mov ax,dts
        mov ds,ax
        mov es,ax

        mov si,offset msg + 6 ; set pointer to the place we want to write

        ; extract flag register
        pushf
        pop ax
        mov bx,ax ; keep a copy in bx

        ; Checking CF
        and bx,1 ; set all bits to zero except 0th one
        add bl,30h ; this is used for printing. to convert 0 and 1 to ascii codes

        mov byte ptr [si],bl ; set CF=...

        ; Checking ZF
        mov bx,ax
        shr bx,6 ; shift ZF to 0th position

        and bx,1 ; set all bits to zero except 0th one
        add bl,30h ; this is used for printing. to convert 0 and 1 to ascii codes

        add si,6 ; move the cursor to the next line
        mov byte ptr [si],bl ; set ZF=...


        ; Printing
        mov ah,09h
        mov dx,offset msg
        int 21h

exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end     main
