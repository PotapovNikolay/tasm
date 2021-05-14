Text    segment
        assume CS: text, DS: data
Begin:  mov AX, data
        mov DS, AX
        mov CX, 10
        mov AX, 5
cycle:  cmp CX, AX
        jb exit
        inc count
        dec CX
        jmp cycle
exit:   mov DX, offset count
        mov AH, 9
        int 21h
        mov AX, 4C00h
text    ends
data    segment
count   db '0$'
data ends
end begin

