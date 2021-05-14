Text	segment			    
		assume CS:text,DS:data	
Begin:	mov AX,data			
		mov DS,AX
        mov AH,9
        mov DX, offset clear
        int 21h			
again:	mov AH,01h			
		int 21h			
		cmp AL,'4'			
		ja  again			
		cmp AL,'3'			
		jb  again			
		mov color,AL		
symb2:	mov AH,01h			
		int 21h			
		cmp AL,'7'			
		ja  symb2			
		cmp AL,'0'			
		jb  symb2			
		mov color+1,AL		 
		mov AH,9			
		mov DX,offset message	
		int 21h			
		jmp again			
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





        