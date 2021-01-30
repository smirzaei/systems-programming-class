; Stack
stk     segment
        dw 64 dup(?)
stk     ends

; Data
dts     segment
max     db 80 ; maximum number of characters than can be entered
len     db ?  ; the actual number of entered characters
string  db 80 dup(?)
msg     db 'please enter up to 80 characters', 0ah, 0dh, '$' ; 0dh = \r - 0ah = \n
dts     ends

; Code
cds     segment
        assume cs:cds,ss:stk,ds:dts
main    proc    far

        mov ax,dts
        mov ds,ax

        ; Enable VRAM
        mov ax,0b800h
        mov es,ax

        ; display the message
        mov ah,09h
        mov dx,offset msg
        int 21h

        ; read user input
        mov ah,0ah
        mov dx,offset max ; don't take more than 80 bytes
        int 21h

        mov si,offset string
        mov cl, len
        xor ch,ch ; mov ch,0
        mov di,3*160 ; write at line 4
        mov ah,80h ; set color

        cld

l1:     lodsb
        stosw
        loop l1

exit:   ; terminate the program
        mov ah,4ch
        int 21h
main    endp
cds     ends
        end     main
