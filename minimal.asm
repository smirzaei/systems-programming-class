        .model  small
        .stack  64
        .data
        .code
main    proc

exit:   mov     ah,4ch
        int     21h
main    endp
        end     main

