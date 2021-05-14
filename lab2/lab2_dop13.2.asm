Text	segment			    
		assume CS:text,DS:data	
Begin:	mov AX,data			
		mov DS,AX
        mov AH,9
        mov DX, offset clear
        int 21h			
contrl:	mov AH,09h			;Будем в цикле
		mov DX,offset string	;выводить на экран
		int 21h			;строку string
		mov CX,0			;Программная
qqq:		loop qqq			;задержка
		mov AH,06h			;Функция прямого ввода
		mov DL,0FFh			;Режим ввода
		int 21h			;Вызов DOS
		jnz symb			;Если символ есть, переход
		jmp contrl			;Символа нет, продолжить цикл
symb:		cmp AL,0			;Расширенный код ASCII ?
		jne contrl			;Нет, продолжить цикл
		mov AH,06h			;Да, надо ввести второй байт
		mov DL,0FFh			;Режим ввода
		int 21h			;Вызов DOS
		cmp AL,10h			;Нажато <Alt>/<Q> ?
		je  exit			;Да, на выход
		jmp contrl			;Нет, продолжить цикл
exit:   mov AX, 4c00h
        int 21h
;Поля данных
string	db 'vipolnyaetsa circle $'		
text	ends
data	segment
clear	db 27,'[2j'						
message	db 27,'['						
color	db '00'						
		db 'm',27,'[12;35H',201,11 dup (205),187	
		db 27,'[13;35H',186,'Attention !',186	
		db 27,'[14;35H',200,11 dup (205),188		
        db 27,'[O',27,'[25;1H$'

data ends		
stk		segment stack "stack"
		dw 128 dup (0)		
stk		ends				
end begin			





        