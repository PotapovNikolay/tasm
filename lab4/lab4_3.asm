;Программа выводит на экран прямоугольник, 
;который меняет цвет с периодичностью 3 секунды, 
;выход по F10
delay    macro time
        local zd,cl,cikl,ii,iil;
        push cx
        push bx
        push bp
        push ax
        push dx
        mov cx, time:
zd      push cx
        mov bp,
        mov bx,
ciki:
        inc BP
        mov ah,00h
        int 1Ah
        cmp BP,1
        je ii
        111
ii:     add bx, dx
iil:    cmp bx, dx
        jne cikl
        pop cx
        loop zd
        pop сх
        pop bx
        pop bp
        pop ax
        pop dx
        endm
Text    segment "code"
        assume CS: text, DS: data
Prymoug proc
        mov AL, cvet
        mov BH,0
        mov SI,250
        mov DI,150
        mov CX,y
Pryml:  push cx
        mov CX, x
Prym:   push CX
        mov AH, 0ch
        mov cx,si
        mov DX, DI
        int 10h
        inc SI
        pop cx
        loop Prym
        inc DI
        mov SI, 250
        pop cx
        loop Pryml
        ret
Prymoug endp
Zadergka proc
        mov bp,1
        mov cvetl,1
mig:
        mov bl, cvetl
        mov cvet,bl
        call prymoug
        inc bp
        cmp bp,3
        je changCvet
        mov ah, 06h
        mov dl,0ffh
        int 21h
        cmp al,44h
        jne mig
        jmp ex
changCvet:  inc cvetl
        mov bp, 1
        jmp mig
ex:
        ret
Zadergka endp
Main    proc
        mov AX, data
        mov DS, AX
        int 21h
        mov x, 30
        mov y,30
        mov Ah, 00h
        mov AL,10h
        int 10h
        call Zadergka
        mov AH,00h
        mov AL, 03h
        int 10h
        mov ax,4c00h
        int 21h
main    endp
text    ends
data    segment
x dw 0
y dw 0
cvet db 0
cvetl db 0
data ends
stk segment stack 'stack'
dw 128 dup (0)
ends
end main