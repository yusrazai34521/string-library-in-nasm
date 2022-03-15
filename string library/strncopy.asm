; ========================
; = void strCopy(string a, buffer b) = name of the function
; ========================
; Usage: initial address of the string and buffer passed as parameter and the subroutine copies the string into the bufffer
; Input: push the initial address/label of the string and bufffer onto the stack before calling the function 
; Registers: cx,bx ,ax,si
; Output: the string is copied into the buffer

[org 0x0100]

jmp start_

len:
	push bp
	mov bp,sp
	
	xor ax,ax
	xor bx,bx
	xor cx,cx
	
	inc cx		;stores the count of string
	mov bx, 0
	mov bx, [bp+4]		;bx stores the initial address of the string
	
	looop:  mov  ax,[bx]		;the ascii of the first character stored in ax
	 	cmp ah,0h		;the ascci in ah stored with the ascii of NULL
		je end
		
		inc bx			;the address is incremented
		inc cx			;count is incremented 
		jmp looop

	end:
	pop bp 
	ret 2

print:
	push bp
	mov bp,sp
	
	push word [bp+4]	;to find the length , user defined len function is called and the parameter is passed onto the stack
	call len		;len function called, returns length in cx
	
	mov  dx, [bp+4]	;address moved to dx, cx has length     
	mov  bx, 1		
	mov  ax, 4000h      
	int  0x21
	
	pop bp 
	ret 2
	

strCopy:
	push bp
	mov bp,sp
	sub sp,2
		
	push word [bp+8]
	call len	;length of string return in cx by the user defined function
	
	
	cmp word [bp+4], cx
	jge printall
	
	printn:
	mov cx, [bp+4]
	sub cx,1
	
	mov cx,1
	mov bx , [bp+8]		;address of string in bx
	mov si, [bp+6]			;address of buffer in si
	loooop:	
	
		push word [bx]		;push pop used to copy from bx to si
		pop word [si]
		inc cx
		inc bx			;incrementing the addresses to access the next byte of string and buffer
		inc si
		cmp word cx, [bp+4]         ;loop condition , loop runs for n times, n= number of characters in the string
		jne loooop
	
	
	printall:
	sub cx,1
	mov word [bp-2], cx		;local variable stores the length
	
	mov cx,1
	mov bx , [bp+8]		;address of string in bx
	mov si, [bp+6]			;address of buffer in si
	loooop1:	
	
		push word [bx]		;push pop used to copy from bx to si
		pop word [si]
		inc cx
		inc bx			;incrementing the addresses to access the next byte of string and buffer
		inc si
		cmp cx, [bp-2]		;loop condition , loop runs for n times, n= number of characters in the string
		jne loooop1
	
		
	add sp,2
	pop bp 
	ret 6

start_:	
	push string		;address of the string pushed on stack as parameter [bp+8]
	push buffer		;bp+6
	push 8			;bp+4
	call strCopy		;function call 
	
	push buffer		;to check if buffer prints the same as the string
	call print

mov ax,0x4c00
int 0x21

string: db 'yusra is nice'
buffer: db 255	
db 0
times 255 db 0
