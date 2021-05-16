            include mac.mac
text        segment 'code'
            assume CS: text, DS: data
horizontal  proc
h:
            push cx
            mov AH, 0ch
            mov AL, CS: color
            mov BH, 0
            mov CX, SI
            int 10h
            inc SI
            pop cx
            loop h
            ret
horizontal  endp
triangle    proc
            mov AH, 00h
            mov AL, 10h
            int 10h
            mov SI, 200
            mov DX, 100
            mov BL, 70
            mov cx,1
cycle_hor:
            push si
            push cx
            push cx
            call horizontal
            inc DX
            mov si, 200
            pop cx
            add cx,1
            pop si
            add CX, 2
            pop si
            dec si
            dec BL
            cmp BL, 0
            jge cycle_hor
            ret
triangle    endp
main        proc
            mov AX, data
            mov DS, AX
input:      mov AH,08h
            int 21h
            cmp AL, '1'
            jge next
            jmp input
next:       cmp AL,'9'
            jle draw
            jmp input
draw:       mov period, AL
            mov AX,351ch
            int 21h
            mov word ptr old_lch, bx
            mov word ptr old_lch+2,ES
            mov ax,251Ch
            mov dx, offset new_lch
            push ds
            push cs
            pop ds
            int 21h
            pop ds
            call triangle
            mov al,period
inf:        jmp inf
            lds dx, old_lch
            mov AX,251Ch
            int 21h
            outprog
main        endp
new_lch     proc
            inc CS: sec
            push AX
            cmp CS: sec, 18
            jne exit
            mov CS: sec,0
            inc CS: count
            cmp CS: count,al
            jne exit
            mov count, '0'
            cmp CS: color, 4
            je change
            mov CS: color, 4
            call triangle
            jmp exit
change:     mov CS: color, 0
            call triangle
exit:       pop AX
            iret
sec         db 0
count       db '0'
color       db 4
new_lch     endp
text        ends
data        segment
old_lch     dd 0
period      db 0
data        ends
end main