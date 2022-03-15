[org 0x0100]
jmp start



strrchar:
	push bp
	mov bp,sp
	sub sp,2
	mov bx,[bp+4]		;string
	mov cl,[bp+6]		;char to be searched
		
		outer:
		
		mov al,[bx]
		add bx,1
		inc dx
		cmp al,cl
		je next
		cmp al,0
		jne outer
		jmp exit2
		
		next:
		mov [bp-2],dx
		cmp al,0
		jne outer
exit2:
	pop ax
	pop bp 
	ret
	
print:				;for printing
	push bp
	mov bp,sp
	push ax
	
	
	mov dx, [bp+4]		; print msg
	mov cx,[bp+6]
	mov bx,1
	mov ah,0x40
	int 21h
	
	pop ax
	xor cx,cx
	xor bx,bx
	
	
	outer3:
		xor dx,dx	;print last occurence
		mov bx,10
		div bx
		push dx
		inc cx
		cmp ax,0
		jne outer3
	
	
		
		outer4:
		pop dx
		add dx,48
		mov bx,1
		mov ah,2
		int 21h
		dec cx
		cmp cx,0
		jg outer4	

	pop bp 
	ret

start:
	xor bx,bx
	xor dx,dx
	
	push word[char]
	push string
	call strrchar
	
	
	push len
	push msg
	call print
	

exit:
mov ax,0x4c00
int 21h

string: db "my name is fiza maqsood",0
char: dw "a"
msg: db "last occurence is: "
len equ $-msg

