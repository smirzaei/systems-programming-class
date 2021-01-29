
; ا استفاده از روشهای آدرس دهی مشخص شده در موارد زیر برنامه ای بنویسید در دو فایل جدابه صورتهای مورد نظر برای تبدیل یک عدد یک بایتی به رشته و ذخیره آن درسگمنت داده. فایل main.asmحاوی سگمنت استک (256 بایت)، سگمنت داده برای ذخیره flda ( عدد صحیح یک بایتی بدون علامت برای تبدیل) و adadasciiبرای ذخیره عدد تبدیل شده به رشته و سگمنت کد برای main proc far برای فراخوانی proc itoa جهت تبدیل عدد به رشته و دیگر عملیات مورد نظر.
; فایل procs.asmحاوی proc itoa far برای تبدیل عدد ذخیره شده در fldaبه رشته و ذخیره آن در adadascii.
; الف)دسترسی به fldaتوسط proc itoaاز طریق استک با روش آدرس دهی baseو adadasciiبا استفاده از روش آدرس دهی Index. (1)
; ب)دسترسی به fldaو adadasciiدر proc itoaبا روش آدرس دهی direct.(1)
; ج)دسترسی به fldaو adadasciiدر proc itoaبا روش آدرس دهیbase از طریق سگمنت داده. (1)
; د)موقعیت و مراحل تغییر SPو BPو محتویات استک را در الف) نمایش دهید.(1)

;(1)sp->         0100h
;            ah  00ffh
;(2)         al  00FEh <-SP (5)
;(3)         CS  00FDh
;            CS        00FCh
;            IP        00FBh
;(4) bp=sp-> IP  00FAh

;main.asm
extrn itoa:far
stk segment
 dw 80h dup(?) ;(1)
stk ends
dts segment
flda db 178
adadascii db 3 dup(' '),'$' ; XXX
dts ends
cds segment
assume cs:cds,ss:stk
main proc far
mov ax,seg dts
mov ds,ax

mov al,flda
xor ah,ah
push ax ;(2)
call itoa ;(3)
mov ah,09
mov dx,offset adadascii
int 21h
mov ah,4ch
int 21h
main endp
cds ends
end main

;procs.asm
public itoa
prcs segment
assume cs:prcs
itoa proc far
    mov bp,sp ;(4)
    mov ax,[bp+4]
    mov bl,10
    div bl
    or ah,30h ; add ah,30h
     mov byte ptr [si+2],ah
     xor ah,ah
     div bl
     or ax,3030h ;add ax,3030h
mov [si],ax
ret ;(5)
itoa endp
prcs ends
end 
;=============================================(B)


;main.asm
extrn itoa:far
public flda, adadascii
stk segment
 dw 80h dup(?) ;(1)
stk ends
dts segment
flda db 178
adadascii db 3 dup(' '),'$' ; XXX
dts ends
cds segment
assume cs:cds,ss:stk
main proc far
mov ax,seg dts
mov ds,ax
mov si,offset adadascii

call itoa ;(3)
mov ah,09
mov dx,offset adadascii
int 21h
mov ah,4ch
int 21h
main endp
cds ends
end main

;procs.asm
extrn flda:byte; adadascii:word
public itoa
prcs segment
assume cs:prcs
itoa proc far
    mov si,offset adadascii
    mov al,flda
    xor ah,ah
    mov bl,10
    div bl
    or ah,30h ; add ah,30h
     mov byte ptr [si+2],ah
     xor ah,ah
     div bl
     or ax,3030h ;add ax,3030h
mov [si],ax
ret ;(5)
itoa endp
prcs ends
end 
;===================================(C)

;main.asm
extrn itoa:far

stk segment
 dw 80h dup(?) ;(1)
stk ends
dts segment
flda db 178
adadascii db 3 dup(' '),'$' ; XXX
dts ends
cds segment
assume cs:cds,ss:stk
main proc far
mov ax,seg dts
mov ds,ax
mov si,offset adadascii
mov bx,offset flda
call itoa
mov ah,09
mov dx,offset adadascii
int 21h
mov ah,4ch
int 21h
main endp
cds ends
end main

;procs.asm

public itoa
prcs segment
assume cs:prcs
itoa proc far
    mov si,bx+1
    mov al,byte ptr [bx]
    xor ah,ah
    mov cl,10
    div cl
    or ah,30h ; add ah,30h
     mov byte ptr [si+2],ah
     xor ah,ah
     div cl
     or ax,3030h ;add ax,3030h
mov [si],ax
ret ;(5)
itoa endp
prcs ends
end 



;(1)sp->         0100h
;            ah  00ffh
;(2)         al  00FEh <-SP (5)
;(3)         CS  00FDh
;            CS        00FCh
;            IP        00FBh
;(4) bp=sp-> IP  00FAh

;main.asm
extrn itoa:far
stk segment
 dw 80h dup(?) ;(1)
stk ends
dts segment
flda db 178
adadascii db 3 dup(' '),'$' ; XXX
dts ends
cds segment
assume cs:cds,ss:stk
main proc far
mov ax,seg dts
mov ds,ax

mov al,flda
xor ah,ah
push ax ;(2)
call itoa ;(3)
mov ah,09
mov dx,offset adadascii
int 21h
mov ah,4ch
int 21h
main endp
cds ends
end main

;procs.asm
public itoa
prcs segment
assume cs:prcs
itoa proc far
    mov bp,sp ;(4)
    mov ax,[bp+4]
    mov bl,10
    div bl
    or ah,30h ; add ah,30h
     mov byte ptr [si+2],ah
     xor ah,ah
     div bl
     or ax,3030h ;add ax,3030h
mov [si],ax
ret ;(5)
itoa endp
prcs ends
end 
;=============================================(B)


;main.asm
extrn itoa:far
public flda, adadascii
stk segment
 dw 80h dup(?) ;(1)
stk ends
dts segment
flda db 178
adadascii db 3 dup(' '),'$' ; XXX
dts ends
cds segment
assume cs:cds,ss:stk
main proc far
mov ax,seg dts
mov ds,ax
mov si,offset adadascii

call itoa ;(3)
mov ah,09
mov dx,offset adadascii
int 21h
mov ah,4ch
int 21h
main endp
cds ends
end main

;procs.asm
extrn flda:byte; adadascii:word
public itoa
prcs segment
assume cs:prcs
itoa proc far
    mov si,offset adadascii
    mov al,flda
    xor ah,ah
    mov bl,10
    div bl
    or ah,30h ; add ah,30h
     mov byte ptr [si+2],ah
     xor ah,ah
     div bl
     or ax,3030h ;add ax,3030h
mov [si],ax
ret ;(5)
itoa endp
prcs ends
end 
;===================================(C)

;main.asm
extrn itoa:far

stk segment
 dw 80h dup(?) ;(1)
stk ends
dts segment
flda db 178
adadascii db 3 dup(' '),'$' ; XXX
dts ends
cds segment
assume cs:cds,ss:stk
main proc far
mov ax,seg dts
mov ds,ax
mov si,offset adadascii
mov bx,offset flda
call itoa
mov ah,09
mov dx,offset adadascii
int 21h
mov ah,4ch
int 21h
main endp
cds ends
end main

;procs.asm

public itoa
prcs segment
assume cs:prcs
itoa proc far
    mov si,bx+1
    mov al,byte ptr [bx]
    xor ah,ah
    mov cl,10
    div cl
    or ah,30h ; add ah,30h
     mov byte ptr [si+2],ah
     xor ah,ah
     div cl
     or ax,3030h ;add ax,3030h
mov [si],ax
ret ;(5)
itoa endp
prcs ends
end 





;1- activate video graphic mode 12h using function 0 of int 10h
;2- draw line form 100,160 to 200,260 color 12 using function 0ch int 10h
;3- wait for a key to be pressed using function 01 int 21h
;4- activate text mode using function 0 int 21h mode AL=3
;5- exit

stk segment stack 'stack'
    dw 32 dup(?)
stk ends
cds segment
    assume cs:cds, ss:stk
main proc far
            mov al, 12h
            mov ah, 0
            int 10h ; set graphics video mode.
            mov ah, 0Ch
            mov al, 12 ;  Color 
            mov bh, 0 ;  Page Number
            mov dx, 100 ; Y Position
            mov cx, 160 ; X Position
  l1:  int 10h
        inc dx
        inc cx
        inc al
        cmp dx,200
        jne l1
        mov ah,01
        int 21h
        mov ah,0
        mov al,3
        int 10h
            mov ah,4ch
            int 21h
        
main endp
cds ends
end main


