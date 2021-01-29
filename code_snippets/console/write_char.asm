; Write a character
mov dl, 'x' ; character to write
mov ah,02h
int 21h

; AL now contains the character
