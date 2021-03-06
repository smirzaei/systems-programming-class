# systems-programming-class


How to compile in VDOS:
===

```
masm [filename].asm /L
link [filename],,,,,
[filename]
```


### DOS INT 21H functions

http://spike.scu.edu.au/~barry/interrupts.html


### File Manipulation

#### Create file

```asm
; Create File
        mov     ah,3ch
        mov     cx,0
        mov     dx,offset f_name
        int     21h ; CF=0 if OK, AX= File Handle CF=1 Error AX=Error code

        jnc file_create_ok

file_create_nok:
        mov     ah,09h
        mov     dx,offset fc_fmsg
        int     21h
        jmp     exit

file_create_ok:
        mov     f_hndle,ax
        mov     ah,09h
        mov     dx,offset fc_smsg
        int     21h
```

#### Open file

```asm
; Open file
        mov     al,02  ; 0 Read 1 Write 2 Read/Write
        mov     ah,3dh ; open the file
        mov     dx,offset f_name
        int     21h ; Open File AX= file Handle CF= 0 if success CF=1 if Error
        jnc     file_open_ok

file_open_nok:
        mov     ah,09h
        mov     dx,offset fo_fmsg
        int     21h
        jmp     exit

file_open_ok:
        mov     f_hndle,ax
        mov     ah,09h
        mov     dx,offset fo_smsg
        int     21h
```

#### Write to file

```asm
; Write to file
        mov     ah,40h
        mov     cl,msg_sz
        xor     ch,ch
        mov     bx,f_hndle
        mov     dx,offset msg
        int     21h

        jnc     file_write_ok

file_write_nok:
        mov     ah,09h
        mov     dx,offset fw_fmsg
        int     21h
        jmp     exit

file_write_ok:
        mov     ah,09h
        mov     dx,offset fw_smsg
        int     21h
```

#### Read file

```asm
; Read file
        mov     ah,3fh
        mov     bx,handle
        mov     dx,offset buffer
        mov     cx,20 ; number of bytes to read from the file
        int     21h ; CF = 0 if everything is ok. CF = 1 if error (AX = err code)

        jnc     file_read_ok
```


#### Search file

```asm
; Seek/Search
        mov     ah,42h
        mov     al,0 ; Position: 0 = start, 1 = current pos, 2 = end
        mov     bx,filehandle
        mov     cx,0 ; Number of bytes to move CX/DX
        mov     dx,7 ; 7 bytes
```

#### Close file

```asm
; Close file
        mov     ah,3eh
        mov     bx,f_hndle
        int     21h
        jnc     file_close_ok

file_close_nok:
        mov     ah,09h
        mov     dx,offset fl_fmsg
        int     21h
        jmp     exit

file_close_ok:
        mov     ah,09h
        mov     dx,offset fl_smsg
        int     21h
```
