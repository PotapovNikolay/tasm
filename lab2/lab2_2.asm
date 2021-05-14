Text	segment			    
		assume CS:text,DS:data	
Begin:	mov AX,data			
		mov DS,AX			
		mov CX,10			
cycle:	push CX			    
		mov AH,09h			
		mov DX,offset string
		int 21h			    
                            
		mov CX,100			
outer:	push CX			    
		mov CX,65535		
inner:	loop inner			
		pop CX			    
		loop outer			
		pop CX			    
		loop cycle			
text		ends			
data		segment			
string	db '<>$'         	
data	ends				
stk		segment stack "stack"
		dw 128 dup (0)		
stk		ends				
		end begin			





        