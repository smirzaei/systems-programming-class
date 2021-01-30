; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
msg     db 10,13,'time is now  :  ',10,13,'$'
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far
        mov ax,dts
        mov ds,ax

        mov si,offset p1+15 ; Move the cursor after time is now

        ; Read the time
        mov ah,2ch
        int 21h ; CH = hour CL = minute DH = second DL = 1/100 seconds

        ; printing hour
        mov al,ch
        xor ah,ah

        ; converting to ascii for printing
        mov bl,10
        div bl ; al = quotient, ah = remainder
        add ax,3030h ; convert to ascii

        mov [si],ax

        ; printing minute
        mov al,cl
        xor ah,ah

        ; converting to ascii for printing
        mov bl,10
        div bl ; al = quotient, ah = remainder
        add ax,3030h  ; convert to ascii

        mov [si+3],ax

        ; printing
        mov ah,09h
        mov dx,offset p1
        int 21h

exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end     main
