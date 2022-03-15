; -----------------------
; name: void read(variable a, length l)
; -----------------------
; usage:  To read from STDIN where variable to print is in eax, length in ebx
; input:  var and length are passed as parameters in fuction
; output: the user input STDIN will be printed on console5
[org 0x0100]

jmp start

inputString:
           push bp
           mov bp,sp
           
           mov si, [bp+6]
           mov bx, [bp+4]
           
           l1:
           mov ah, 1                ; code for input
           int 21h
           cmp al, 13               ; 13 is ascii of 'enter key' until the user enter , the enter key
           je pend                  ; it will be store in array
           mov [si], al             ; if user is still inputting, move it in si
           inc si                   ; mov to next
           inc bx                   ; calculating length
           jmp l1
           
           pend:
           mov dx, [bp+6]             ; print the array
           mov cx, bx
           mov bx,1
           mov ah, 40h                
           int 21h
           
           pop bp
           ret 4

start:

            push word string
            push word len-1
            call inputString

mov ax, 0x4c00
int 21h

string: db 0
len: equ ($-string)
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: string int2str(int i, buffer b)
; -----------------------
; usage: convert an integer into a string
; input: int and buffer are passed as a parameter in the func
; output: integer will be converted into string
[org 0x0100]

jmp start

stringconv:
        push bp
        mov bp, sp
        pusha
        
        mov si, [bp+6]
        mov di, [bp+4]

        add byte[si], 48
        mov al, [si]
        mov [di], al

        pop bp
        popa
        ret
start:
        push word arr+3
        push word buffer
        
        call stringconv
        
mov ax, 0x4c00
int 21h
        
arr: db 3, 9, 5, 6, 8
buffer: db 0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: int str2int(string s)
; -----------------------
; usage: To convert a string into an integer
; input: string pass as a parameter in the func
; output: string will be converted into integer array
[org 0x0100]

jmp start

convertInt:

        push bp
        mov bp, sp
        pusha
        
        mov si, [bp+4]
        
l:      
        sub byte[si], 48
        inc si
        cmp byte[si], 0x00
        jne l
end:    
        pop bp
        popa
        ret
start:
       
       push word str1
       call convertInt

       mov ax, 0x4c00
       int 21h
       
str1: db '123456', 0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
; -----------------------
; name: int isEqual(string a, string b): To check if a and b are equal to each other
; -----------------------
; usage:  To check if a and b are equal to each other
; input:  2 strings are passed as a parameter in the func
; output: if they are equal then 1 will be mov in dx otherwise -1
[org 0x0100]

jmp start

isEqual:
       
       push bp 
       mov bp, sp
       pusha
       
       mov si, [bp+6]
       mov di, [bp+4]
       
l:     
       mov al, [di]
       cmp byte[si], al          ; compare each char
       jne end1                  ; if not equal jmp to end1
       
       else:                     ; else
       inc si                    ; mov to next char of 1st string
       inc di                    ; mov to next char of 2nd string     
       cmp byte[si], 0x00
       jne l2
       l2: cmp byte[di], 0x00
       jne l
       jmp end2
        
       end1: 
       mov dx, -1         ; -1 to indicate not equal
       jmp end
       
       end2:
       mov dx, 1         ; 1 to indicate equal
       
       end:
       pop bp
       popa
       ret
start:
        
        push word str1
        push word str3
        call isEqual
        
mov ax, 0x4c00
int 21h
        
str1: db 'yusra nadeem',0
str2: db 'yusra nadeem',0
str3: db 'yusra nadeem!!',0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; -----------------------
; name: int len(string s)
; -----------------------
; -----------------------
; usage: to find the length of given string
; input: string pass as a parameter in the func
; output: length will be return into len variable
[org 0x0100]
jmp start

length_string:
           
           push bp
           mov bp,sp
           sub sp, 2
           mov si, [bp+4]       ; string parameter
           mov word[bp-2], 0    ; local variable for length
           
           l:
     
           inc si
           inc word[bp-2]       ; inc the var until string comes to null char
           cmp byte[si], 0x00   ;cmp the string to null char
           jne l
           jmp end
           
           end:
           mov cx, [bp-2]       
           mov word[len], cx          ; savig into memory var
           add sp, 2            ; destroying the local variable
           pop bp
           ret
           

start: 
           push word strr      ; pass the string as a parameter
           call length_string  ; func call
           
mov ax, 0x4c00
int 21h
strr: db 'This is yusra!!',0
len: dw 0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


; -----------------------
; -----------------------
; name: void strCopy(string a, buffer b)
; -----------------------
; -----------------------
; usage:  Copies string a into buffer b
; input:  string and buffer are passed as a parameter in the func
; output: string will be copied into buffer
[org 0x0100]
jmp start

copyString:
           push bp
           mov bp,sp
           pusha
           
           mov di, [bp+6]
           mov si, [bp+4]
           
l:
           mov al, [di]
           mov byte[si], al
           inc si
           inc di
       
           cmp byte[di], 0x00
           jne l
           
           
           pop bp
           popa
           ret 4
start:
           push word str1
           push word buffer
           call copyString
mov ax, 0x4c00
int 21h
str1: db 'hello there',0
buffer:db 255
 db 0
 times 255 db 0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; -----------------------
; name: void uppercase(string s)
; -----------------------
; -----------------------
; usage: to convert the lowercase letters into uppercase of the given string
; input: string pass as a parameter in the func
; output: string in all uppercase letters will be printed on console
[org 0x0100]

jmp start

uppercase:
            push bp
            mov bp,sp
            sub sp, 2
            
            mov si, [bp+4]
            mov word[bp-2], 0   ; var for length
            
            l:
            cmp byte[si], 90    ; A=65, Z=90
            jle else            ; its already uppercase
          
            sub byte[si], 32    ; 97-32=65=A, 98-32=66=B and so on
            jmp else
            
            else:
            inc si              ; mov to next char
            inc word[bp-2]      ; calculating length
            cmp byte[si], 0x00  ; cmp with null
            jne l
            
            print:              ; printing the result
            
            mov dx, [bp+4]
            mov cx, [bp-2]
            mov bx,1
            mov ah,40h
            int 21h
            
            end:
            add sp,2
            pop bp
            ret

start:
          push word arr 
          call uppercase
mov ax,0x4c00
int 21h
_data:
arr: db 'asAdggjDsjhKfh', 0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; -----------------------
; name: void lowercase(string s)
; -----------------------
; -----------------------
; usage: to convert the uppercase letters into lowercase of the given string
; input: string pass as a parameter in the func
; output: string in all uppercase letters will be printed on console
[org 0x0100]

jmp start

lowercase:
            push bp
            mov bp,sp
            sub sp, 2
          
            mov si, [bp+4]
            mov word[bp-2], 0
            
            l:
            cmp byte[si], 97    ; A=65, Z=90
            jge else            ; its already lowercase
          
            add byte[si], 32    ; 65+32=97=a, 66+32=98=b and so on
            jmp else
            
            else:
            inc si
            inc word[bp-2]
            cmp byte[si], 0x00
            jne l
            
            print:
            
            mov dx, [bp+4]
            mov cx, [bp-2]
            mov bx,1
            mov ah,40h
            int 21h
            
            add sp, 2
            pop bp
            ret

start:
          push word arr
          call lowercase
          
mov ax,0x4c00
int 21h

arr: db 'SskHKSsjHKSlE', 0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; -----------------------
; name: void print(string s)
; -----------------------
; -----------------------
; usage: to print the given string
; input: string pass as a parameter in the func
; output: string will be printed on console
[org 0x0100]

jmp start

printString:
          push bp
          mov bp, sp
          sub sp, 2
          mov dx, [bp+4]
          mov ax, len
          mov word[bp-2], ax
          
          mov dx, [bp+4]
          mov cx, [bp-2]
          mov bx, 1
          mov ah, 40h
          int 21h
          
          pop bp 
          ret
          
start:
          push word strr1
          call printString

mov ax, 0x4c00
int 21h
strr1: db 'yusra nadeem 342153',0
len: equ ($-strr1)

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
