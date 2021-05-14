Text	segment			    
		assume CS:text,DS:data	
Begin:	mov AX,data			
		mov DS,AX
        mov BX,offset txt	;Инициализация базового
		mov SI,0			;и индексного регистров
inpt:	mov AH,01h			;Функция ввода символа с эхом
		int 21h			    ;Вызов DOS
		cmp AL,0			;Расширенный ASCII - код ?
		je  ex_ascii		;Да, на анализ
		mov [BX][SI],AL		;Нет, символ в буфер
		inc SI			    ;Инкремент индекса
		jmp inpt			;И бесконечно повторять
ex_ascii:	mov AH,08h		;Ввод символа без эха
		int 21h			    ;Вызов DOS
		cmp AL,44h			;<F10> ?
		je  exit			;Да, на выход
		jmp inpt			;Нет, на продолжение ввода
exit:	mov AX, 4C00h
        int 21h			        ;Завершение программы		
text		ends			
data		segment			
prompt	db '>>$'
txt		db 80 dup (?)        	
data	ends	
end begin						