;вывод таймера
text            segment 'code'
                include mac.mac
                assume CS: text, DS: data
main            proc
                mov AX, data
                mov DS, AX
                mov AX,351ch
                int 21h
                mov word ptr old_lch,bx
                mov word ptr old_lch+2,ES
                mov AX, 251Ch
                mov dx,offset new_lch
                push ds
                push cs
                pop DS
                int 21h
                pop DS
inf:            jmp inf
                lds dx, old_lch
                mov AX,251Ch
                int 21h
                outprog
main            endp
new_lch         proc
                inc CS: count
                cmp byte ptr CS:count,18
                jne exit
                mov count,0
                cmp string+4, '9'
                je secl
                inc string+4
                jmp w_s
secl:           mov string+4,'0'
                cmp string+3, '5'
                je sec2
seci:          
                mov string+4, "U"
                cmp string+3, '5'
                je sec2
                inc string+3
                jmp w_s
sec2:           mov string+3,'0'
                cmp string+1,'9'
                je mini
                inc string+1
                jmp w_s
mini:           mov string+1,'0'
                cmp string, '9'
                je zer
                inc string
                jmp w_s
zer:            mov string,'0'
                jmp exit
w_s:            write_string
exit:           iret
count           db 0
new_lch         endp
text            ends
data            segment
    old_lch dd 0
    string db '00:00',10,13,'$'
data            ends
end main