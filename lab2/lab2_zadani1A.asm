Text    segment
assume  CS: text, DS : data
Begin:  mov AX, data
        mov DS, AX
        mov CX, 10
        mov AH, 9
cicle:  mov DX, offset dog
        int 21h
loop    cicle
        mov AX, 4c00h
        int 21h
text    ends
data    segment
dog     db '@$'
data    ends
end     begin

