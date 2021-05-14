Text	segment			        
		assume CS:text,DS:data	        
Begin:	mov AX,data			
		mov DS,AX			
cikl:	mov AH,08h; функция ввода с клавиатуры без эха, возвращает в AL код нажатой клавиши			
		int 21h 
        cmp AL,3Bh        ;сравниваем содержимое AL с кодом клавиши F1
        je  zvezd            	 ;если результат сравнения положительный(если нажата F10, то переход на метку zvezd	        
		cmp AL,3Ch	 ;сравниваем содержимое AL с кодом клавиши F2		
		je  dublZvezd        ;если результат сравнения положительный(если нажата F10, то переход на метку dublzvezd	        
        cmp AL,44h         ;сравниваем содержимое AL с кодом клавиши F10	
        je  exit		  ;если результат сравнения положительный(если нажата F10, то переход на метку exit	
		jmp cikl		  ;безусловный переход – бесконечный цикл	
zvezd:  mov AH,09h;	  ;водим звёздочку посредством функции 09h
        mov DX,offset messege1
        int 21h;
        jmp cikl                 ;продолжаем цикл
dublZvezd:  mov AH,09h;	
        mov DX,offset messege2
        int 21h;
        jmp cikl
exit:   mov AH,09h;	   ;выводим сообщение об окончании программы
        mov DX,offset conec
        int 21h;
        mov AX,4C00h     ;завершаем работу программы
        int 21h
Text    ends;	        

data            segment;
messege1        db 10,13,'*$'
messege2        db 10,13,'**$'
conec           db 10,13,'The end$'
data ends
		
stk		segment stack 'stack'	        ;(23)Начало сегмента стека
		dw 128 dup (0)		        ;(24)Стек
stk		ends				;(25)Конец сегмента стека
		end begin			;(26)Конец текста программы
