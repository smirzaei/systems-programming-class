; Read a character
mov ah,01h ; use 08h for no echo
int 21h

; AL now contains the character
