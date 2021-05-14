Text	segment			    
		assume CS:text,DS:data	
Begin:	mov AX,data			
		mov DS,AX			
contrl:	mov AH,09h			
		mov DX,offset string	
		int 21h			
		mov CX,0			
qqq:	loop qqq			
		mov AH,06h			
		mov DL,0FFh			
		int 21h			
		jnz symb			
		jmp contrl			
symb:	cmp AL,0			
		jne contrl			
		mov AH,06h			
		mov DL,0FFh			
		int 21h			
		cmp AL,10h			
		je  exit			
		jmp contrl			
exit:						
	
text		ends			
data		segment			
string	db 'vipolnyaetsya cycle $'         	
data	ends				
stk		segment stack "stack"
		dw 128 dup (0)		
stk		ends				
		end begin			


        