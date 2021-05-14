Text    segment
assume  CS: text, DS: data
Begin:  mov AX, data
        mov DS, AX
inpt:   mov AH, 07h
        int 21h
        cmp AL, 0
        je ex_ascii
        mov CX, 0
        mov CL,AL
        mov DX, offset message
        mov AH, 09h
        int 21h
        mov DX, offset star
outpt:  cmp CL,'0'
        jbe inpt
        dec CL
        mov AH, 09h
        int 21h
        jmp outpt
ex_ascii: mov AH, 08h
        int 21h
        cmp AL, 44h
        je exit
        jmp inpt
exit:   mov AX, 4c00h
        int 21h
text    ends
data    segment
message db 10, 13,'$'
star    db '*$'
data    ends
end begin

