mov bx,offset string
mov al,len
xor ah,ah ; equal to mov ah,0
add bx,ax
mov byte ptr [bx], '$'
