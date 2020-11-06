; first, display a message to user.
; second, receive an input from the user.
; third, capitalize the word if it's not in capitalize format.
; fourth, display the new string using vram.
; BUG: it doesn't change the case of the first word.
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
        call        setCursor
        call        showMsg
        call        readInput

        mov         di,offset input
        mov         cl,len
        xor         ch,ch            ; zero out ch
compare:
        mov         al,' '           ; what to look for
        repne       scasb            ; repeat until you find the character
        jne         over             ; jump if we've looked for every character
        mov         si,di            ; di contains the offset of the character that we were looking for
        lodsb                        ;   we set it to si, because this is how lodsb works
        
        ; Checking if it's lower case
        cmp         al,60h           ; 61h is the ascii code for fist lower case character
        jbe         compare          ; jump back to compare if the ascii code of AL (the letter after space)
                                     ; is lower or equal to 60h. it means it is already upper case.
        ; it is lower case
        xor         al,20h           ; change the case of character
        mov         byte ptr[di], al ; move the changed character back to its original position
        cmp         cx,0             ; checking if we have checked every word.
        jnz         compare

over:   call        vidMode
        mov         di,4*160         ; set line to 5
        call        showInput
exit:   mov         ah,4ch
        int         21h
main    endp
; ---------------------------------------------------------------------
; Enable video mode
vidMode  proc
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
vidMode  endp
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
; set cursor
setCursor proc
        mov         ah,02
        mov         bh,00
        mov         dl,00 ; column
        mov         dh,00 ; row
        int         10h
        ret
setCursor endp
; ---------------------------------------------------------------------
; show msg prompt
showMsg proc
        mov         ah,09h
        mov         dx,offset msg
        int         21h
        ret
showMsg endp
; ---------------------------------------------------------------------
; read user input
readInput proc
        mov         ah,0ah
        mov         dx,offset max
        int         21h
        ret
readInput endp
; ---------------------------------------------------------------------
; show user input
showInput proc
        mov         si,offset input
        mov         cl,len
        xor         ch,ch
        mov         ah,75h

l2:     lodsb
        stosw
        loop        l2
        ret
showInput endp
; ---------------------------------------------------------------------
        end        main
