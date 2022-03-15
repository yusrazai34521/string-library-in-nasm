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
	
	push word [bp+6]		;address of the string1 pushed on stack as parameter	
	call lenb			;function call 	
	mov dx,cx
	
	push word [bp+4]		;address of the string2 pushed on stack as parameter	
	call lenb			;function call 
	mov bx, cx
	
	cmp bx ,dx			;cmparing the lengths of string1 and string2
	jne not_equal
	jmp compare

	compare:
			mov cx, dx			;length of strings in cx
			mov di,0
			
			mov word bx, [bp+6]		;bx has address of string1
			mov word si, [bp+4]		;si has address of string2
			
			
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
					ret 4	

start_:

push string1		;[bp+6]
push string2		;[bp+4]
call strncmp

mov ax,0x4c00
int 0x21

string1: db 'HeRo',0
string2: db 'HERO' ,0
