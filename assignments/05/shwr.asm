public  showresh
prcs    segment
        assume cs:prcs
showresh proc far
        mov     ah,09h
        int     21h
        ret
showresh endp
prcs    ends
        end

