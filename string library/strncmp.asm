[org 0x0100]

jmp start_

lenb:
	push bp
	mov bp,sp
	
	xor ax,ax
	xor bx,bx
	xor cx,cx
	
	mov cx,0		;stores the count of string
	mov bx, 0
	mov bx, [bp+4]		;bx stores the initial address of the string
	
	looop:  mov ax,[bx]		;the ascii of the first character stored in ax
	 	cmp al,0h		;the ascci in ah stored with the ascii of NULL
		je end
		
		inc bx			;the address is incremented
		inc cx			;count is incremented 
		jmp looop

	end:
	pop bp 
	ret 2


strncmp:

	push bp
	mov bp,sp
	
	push word [bp+8]		;address of the string1 pushed on stack as parameter	
	call lenb			;function call 	
	mov dx,cx
	
	push word [bp+6]		;address of the string2 pushed on stack as parameter	
	call lenb			;function call 
	mov bx, cx
	
	mov word cx, [bp+4]		;n stored in cx
	
	cmp bx ,dx			;comparing the two string lengths
	jl bx_is_smaller
	jmp bx_is_greater
	
	bx_is_smaller:	
				cmp cx, bx		;compare n length with the length of smaller string..it should be equal to or less than that string
				jle compare
				jmp not_equal
				
	bx_is_greater:		
				cmp cx , dx		;compare n length with the length of smaller string..it should be equal to or less than that string
				jle compare
				jmp not_equal
	
	compare:
			mov di,0			;di is the counter ..it should equal cx in the loop
			
			mov word bx, [bp+8]		;bx has address of string1
			mov word si, [bp+6]		;si has address of string2
				
			looop1:
			mov ax, [bx]
			mov dx, [si]
			
			cmp al ,dl
			jne second_check
			jmp continue
			
			second_check:
					cmp al ,dl
					jl addd
					jmp subb
			
				addd:	add al, 20h
					cmp al,dl
					jne not_equal
					jmp continue
				
				subb: 	sub al, 20h 
					cmp al,dl
					jne not_equal
					
				continue:
				
					add bx,1
					add si,1
					inc di
					cmp di,cx
					jne looop1	
					
					mov ax, 1
					
					mov dx,ax
					add dx,30h
					mov ah,2
					int 21h
					jmp end1
	
					not_equal:
					mov ax,0
					mov dx,ax
					add dx,30h
					mov ah,2
					int 21h
	
					end1:
					pop bp
					ret 6	

start_:

push string1		;[bp+8]
push string2		;[bp+4] 
push 1 		;[bp+4]
call strncmp

mov ax,0x4c00
int 0x21

string1: db 'HERO',0
string2: db 'HERO' ,0
