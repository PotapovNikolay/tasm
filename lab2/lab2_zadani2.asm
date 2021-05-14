Text    segment
        assume cs:text,DS:data
Begin:  mov AX, data
        mov DS, AX
        mov ah, 3fh
        mov bx,0h
        mov Cx, 128
        mov dx, offset message
        int 21h
        mov buf, ax
        mov si, buf
        sub si, 2
        mov ah, 02h
cickl:  cmp si, 0
        jnge endl
        mov dl, message (si)
        int 21h
        dec si
        jmp cickl
endl:   mov ax, 4c00h
        int 21h
text    ends
data    segment
buf dw 0
message db 128 dup('*')
data ends
end begin