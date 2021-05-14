Text    segment
        assume CS: text, DS: data
begin:  mov AX, data
        mov DS, AX
        mov CH, 10
cycle:  cmp s, CH
        ja exit
        add s, 2
        mov DX, offset message
        mov AH, 9
        int 21h
        jmp cycle
exit:   mov ax,4c00h
        int 21h
text    ends
data    segment
message db '00$'
s       db 5
data    ends
end begin


