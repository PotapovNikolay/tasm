text        segment 'code'
            assume cs: text, ds: data
dely proc
            push cx
            push bx
            push bp
            push ax
            push dx
            mov cx, time
            zd:
                push cx
                mov bp,0
                mov bx, 1
                cikl:
                    inc bp
                    mov ah,00h
                    int 1Ah
                    cmp bp,1
                    je ii
                    jmp iil
                ii:
                    add bx, dx
                iil:
                    cmp bx, dx
                    jne cikl
                    pop cx
            loop zd
            pop cx
            pop bx
            pop bp
            pop ax
            pop dx
            ret
dely endp
cube_front proc
            mov ah, 0ch
            mov bh, 0
            mov al, color
            mov al, color
            mov si, 50
            push dx
            front_width:
                push cx
                mov bl,50
                front_line:
                    int 10h
                    inc cx
                    dec bl
                    cmp bl,0
                jne front_line
            cmp si,0        
            je front_exit
            dec si
            pop cx
            inc dx
            jmp front_width
            front_exit:
                pop cx
                pop dx
                ret
cube_front endp
main proc
            mov ax, data
            mov ds, ax
            mov ah, 00h
            mov al, 10h
            int 10h
            mov cx, 300
            mov dx, 50
            call cube_front
            mov time, 36
            call dely
            mov color, 14
            mov cx, 300
            mov dx, 110
            call cube_front
            call cube_front
            mov time, 54
            call dely
            mov color, 0
            mov cx, 300
            mov dx, 50
            call cube_front
            mov cx, 300
            mov dx, 110
            call cube_front
            mov color, 2
            mov cx, 300
            mov dx, 170
            call cube_front
            mov time, 80
            call dely
            mov color, 14
            mov cx, 300
            mov dx, 110
            call cube_front
            mov time, 40
            call dely
            mov color, 0
            mov cx, 300
            mov dx, 110
            call cube_front
            mov time, 10
            mov color, 0
            mov cx, 300
            mov dx, 170
            call cube_front
            mov cx, 300
            mov dx, 50
            mov color, 4
            call cube_front
            mov ah, 08h
            int 21h
            mov ah, 00h
            mov al, 03h
            int 10h
            mov ax, 4c00h
            int 21h
main endp
text ends
data segment 'data'
            color db 4
            time dw 54
data ends
end main