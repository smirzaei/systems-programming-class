; Seek/Search
mov     ah,42h
mov     al,0 ; Position: 0 = start, 1 = current pos, 2 = end
mov     bx,filehandle
mov     cx,0 ; Number of bytes to move CX/DX
mov     dx,7 ; 7 bytes
