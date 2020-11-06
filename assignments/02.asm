; first, display a message to user.
; second, receive an input from the user.
; third, capitalize each word.
; fourth, dispay the new output using vram.
; It's bug is that it doesn't capitilize the first word.
TITLE CLASS ASSIGNMENT 2
        .model      small
        .stack      64
        .data
msg     db          'Please enter up to 80 characters', CR, LF, '$'
max     db          80
len     db          ?
input   db          80 dup(?)
CR      equ         0dh
LF      equ         0ah
        .code
; ---------------------------------------------------------------------
main    proc
        mov         ax,@data
        mov         ds,ax
        mov         es,ax

        cld
        call        clear
        call        showmsg
        call        readinput

        mov         di,offset input
        mov         cl,len
        xor         ch,ch            ; zero out ch
compare:
        mov         al,' '           ; what to look for
        repne       scasb            ; repeat until you find the character
        jne         over             ; jump if we've looked for every character
        mov         si,di            ; di contains the offset of the character that we were looking for
        lodsb                        ;   we set it to si, because this is how lodsb works
        xor         al,20h           ; change the case of character
        mov         byte ptr[di], al ; move the changed character back to its original position
        cmp         cx,0
        jnz         compare


over:   call        vidmod
        mov         di,4*160         ; set line to 5
        call        showinput
exit:   mov         ah,4ch
        int         21h
main    endp
; ---------------------------------------------------------------------
; Enable video mode
vidmod  proc
        mov         ax,0b800h
        mov         es,ax

        ; set video mode
        mov         ax,3
        int         10h

        ; cancel blinking and enable 16 colors
        mov         ax,1003h
        mov         bx,0
        int         10h
        ret
vidmod  endp
; ---------------------------------------------------------------------
; Clear the screen
clear   proc
        mov         ax,0600h
        mov         bh,07
        mov         cx,0000
        mov         dx,184fh
        int         10h
        ret
clear   endp
; ---------------------------------------------------------------------
; show msg prompt
showmsg proc
        mov         ah,09h
        mov         dx,offset msg
        int         21h
        ret
showmsg endp
; ---------------------------------------------------------------------
; read user input
readinput proc
        mov         ah,0ah
        mov         dx,offset max
        int         21h
        ret
readinput endp
; ---------------------------------------------------------------------
; show user input
showinput proc
        mov         si,offset input
        mov         cl,len
        xor         ch,ch
        mov         ah,75h

l2:     lodsb
        stosw
        loop        l2
        ret
showinput endp
; ---------------------------------------------------------------------
        end        main
