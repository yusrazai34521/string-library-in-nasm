[org 0x0100]
jmp start



strcat:
	push bp
	mov bp,sp
	mov bx,[bp+6]
		
		outer:
		
		mov al,[bx]
		add bx,1
		inc dx
		cmp al,0
		jne outer
		
		mov cx,[bp+6]
		dec dx
		add cx,dx
		mov si,cx
		mov bx,[bp+4]
		
		outer2:
		mov al,[bx]
		mov word[si],ax
		inc si
		add bx,1
		cmp al,0
		jne outer2

	pop bp 
	ret
	
print:
	push bp
	mov bp,sp
	mov si,[bp+4]
		
		outer3:
		mov dx,[si]
		mov bx,1
		mov ah,2
		int 21h
		mov cx,[si]
		inc si
		cmp cl,0
		jne outer3
		


	pop bp 
	ret

start:
	xor bx,bx
	xor dx,dx
	
	push des
	push src
	call strcat
	
	push des
	call print
	

exit:
mov ax,0x4c00
int 21h

des: db "my name is ",0
extra: db "not",0
src: db "fiza maqsood",0
