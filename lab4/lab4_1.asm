Text        segment 'code'
            assume CS:text,DS:data
new_65h     proc
            mov AH, 06h
            mov AL,0
            mov BH,1Bh
            mov CX,0
            mov DH,24
            mov DL,79
            int 10h
            iret
new_65h     endp
main        proc
            mov AX, data
            mov DS, AX
            mov AH,25h
            mov AL, 65h
            mov DX, offset new_65h
            push DS
            push cs
            pop DS
            int 21h
            pop DS
gogo:       int 65h
            mov Ah,02h
            mov BH,0
            mov DH, line
            mov DL, coloumn
            int 10h
            mov AH, 0Ah
            mov AL, sym
            mov BH, 0
            mov CX, 60
            int 10h
            inc sym
            inc line
            mov AH,08h
            int 21h
            jmp gogo
main        endp
text        ends
data        segment
line        db 2
coloumn     db 10
sym         db 01h
data        ends
; обработка прерываний пользователя.
; выводятся строки симовлом. 
; при нажатии на ctrl c все завершается
end main