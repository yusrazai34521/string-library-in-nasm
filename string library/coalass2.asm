------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
; -----------------------
; name: double sin(double)
; -----------------------
; usage:  This function takes angle (in degree) as an argument and return its sine value. 
; input:  double num is passed as a parameter
; output: sine value will be calculated
[org 0x0100]
jmp start
sinF:                  ; -1 to +1  , floating point values are not appearing on afd
            finit      ; clears to 0
            fld qword[num]
            fsin
            ;fmul qword[f]     ; to check the ans
            fist word[d]
            mov ax, [d]        ; integer value will be stored
            ret
start:

call sinF

mov ax, 0x4c00
int 21h
num: dq 96.6
f: dq 10.04
d: dw 0
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: double acos(double)
; -----------------------
; usage:  This function takes angle (in degree) as an argument and return its acos value. 
; input:  double num is passed as a parameter
; output: arccos value will be calculated
[org 0x0100]

jmp start

; ACOS(x)-      Computes the arccosine of st(0) and leaves the
;                       result in st(0).
;               Allowable range: -1<=x<=+1
;               There must be at least two free registers for
;               this function to operate properly.
;
;       acos(x) = atan(sqrt((1-x*x)/(x*x)))
acosF:
                fld     qword[n]                 ;Duplicate X on tos.
                fmul    qword[n]                 ;Compute X**2.
                fld1                             ;Compute 1-X**2.
                fsub st0, st1
                
                fld     qword[n]                 ;Duplicate X on tos.
                fmul    qword[n]                 ;Compute X**2.
                
                fdiv st1, st0                    ;Compute (1-x**2)/X**2.
                fsqrt                            ;Compute sqrt((1-X**2)/X**2).
                fld1                             ;To compute full arctangent.
                fpatan                           ;Compute atan of the above.
                
                
                fist word[n1]
                mov ax, [n1]
                ret

start:
call acosF

mov ax, 0x4c00
int 21h
n: dq 9.86
n1: dw 0
d: dq 10.02
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


; -----------------------
; name: double tan(double)
; -----------------------
; usage:  This function takes angle (in degree) as an argument and return its tangent  value. 
; input:  double num is passed as a parameter
; output: tangent value will be calculated
[org 0x0100]

jmp start

tanF:
         fptan             
         ;fmul qword[d]  ; the value can be verified mul by 10
         fist word[res] ; it is then converted into int
         mov ax, [res]
         
         ret
start:
         fld qword[deg]
         call tanF

mov ax, 0x4c00
int 21h
deg: dq 60.5   ; tan60.5 = 1.767
d: dq 10.04
res: dw 0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: double atan(double)
; -----------------------
; usage:  This function takes angle (in degree) as an argument and return its atan value. 
; input:  double num is passed as a parameter
; output: arctan value will be calculated
[org 0x0100]

jmp start

atanF:             ; arc tangent of number
                 
                fld qword[n]
                fld1                    
                                         ;st(0) = tan ^-1 ( st(1) / st(0) )
                fpatan                   ;fpatan computes
                
                fist word[n1]
                mov ax, [n1]
                
                ret
                
atan2F:



start:

call atanF

mov ax, 0x4c00
int 21h
n: dq 1.75    ;arctan of 1.75 is 1.05
n1: dw 0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: double acos(double)
; -----------------------
; usage:  This function takes angle (in degree) as an argument and return its acos value. 
; input:  double num is passed as a parameter
; output: arccos value will be calculated
[org 0x0100]

jmp start

; ACOS(x)-      Computes the arccosine of st(0) and leaves the
;                       result in st(0).
;               Allowable range: -1<=x<=+1
;               There must be at least two free registers for
;               this function to operate properly.
;
;       acos(x) = atan(sqrt((1-x*x)/(x*x)))
acosF:
                fld     qword[n]                 ;Duplicate X on tos.
                fmul    qword[n]                 ;Compute X**2.
                fld1                             ;Compute 1-X**2.
                fsub st0, st1
                
                fld     qword[n]                 ;Duplicate X on tos.
                fmul    qword[n]                 ;Compute X**2.
                
                fdiv st1, st0                    ;Compute (1-x**2)/X**2.
                fsqrt                            ;Compute sqrt((1-X**2)/X**2).
                fld1                             ;To compute full arctangent.
                fpatan                           ;Compute atan of the above.
                
                
                fist word[n1]
                mov ax, [n1]
                ret

start:
call acosF

mov ax, 0x4c00
int 21h
n: dq 9.86
n1: dw 0
d: dq 10.02

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: double asin(double)
; -----------------------
; usage:  This function takes angle (in degree) as an argument and return its asin value. 
; input:  double num is passed as a parameter
; output: arcsin value will be calculated
[org 0x0100]

jmp start

; ASIN(x)-      Computes the arcsine of st(0) and leaves the result in st(0).
;               Allowable range: -1<=x<=+1
;               There must be at least two free registers for this function
;               to operate properly.
;
;       asin(x) = atan(sqrt(x*x/(1-x*x)))

asinF:
                fld    qword[n]         ;Duplicate X on tos.
                fmul                    ;Compute X**2.
                fld     st0             ;Duplicate X**2 on tos.
                fld1                    ;Compute 1-X**2.
                fsubr
                fdiv                    ;Compute X**2/(1-X**2).
                fsqrt                   ;Compute sqrt(x**2/(1-X**2)).
                fld1                    ;To compute full arctangent.
                fpatan                  ;Compute atan of the above.
                
                fist word[d]
                mov ax, [d]
                ret

start:

call asinF

mov ax, 0x4c00
int 21h
n: dq 6.66
d: dw 0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: double atan2(double)
; -----------------------
; usage:  This function returns the arc tangent of (double a)/(double b). 
; input:  2 double num is passed as a parameter
; output: arctan2 value will be calculated
[org 0x0100]

jmp start

atan2F:
                fld qword[n1]
                fld qword[n2]                    
                                         ;st(0) = tan ^-1 ( st(1) / st(0) )
                fpatan                   ;fpatan computes  
                                         ;76.6/12.3 = 6.22  = 1.411
                
                fmul qword[p1]           ; it will become 14.11=E
                fist word[n1] 
                mov ax, [n1]
                
                ret
start:

call atan2F

mov ax, 0x4c00
int 21h
n1: dq 76.6
n2: dq 12.3
w: dw 0
p1: dq 10.02

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; -----------------------
; name: int abs(int num)
; -----------------------
; -----------------------
; usage: to find the absolute of given number
; input: num is passed as a parameter in the func
; output: absolute will be returned of that num
[org 0x0100]

jmp start

absolute_:
          
          push bp
          mov bp, sp
          sub sp, 4             ; space for 2 local vars
          pusha
          
          mov word[bp-2], 0     ; 1st local var
          mov ax, [bp+4]
          cmp ax, [bp-2]
          jl l1
          
          l2:
          mov cx, ax             ; num is already pos
          jmp end
          
          l1:
          mov word[bp-4], -1     ; if neg then multiply with minus to get 
          mul word[bp-4]         ; positive value
          mov cx, ax
          
          end:
          mov word[bp+4], cx     ; abs num stored in num var
          pop bp
          popa

ret 2


start:
          
          push word[num]
          call absolute_

mov ax, 0x4c00
int 21h
num: dw -5

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: double ceil(double) 
; -----------------------
; usage:  This function returns the smallest integer as double not less than the  argument provided.
; input:  double num is passed as a parameter
; output: ceil will be calculated
[org 0x0100]

jmp start

ceilF:
     push bp
     mov bp, sp
     sub sp, 6
     mov word[bp-2], 40h  ;0.25
     mov word[bp-4], 80h  ;0.5
     mov word[bp-6], 0xC0 ;0.75
     mov ax, [bp+4]       ;9.75
     
     cmp al, [bp-2]
     je l1
     cmp al, [bp-4]
     je l2
     cmp al, [bp-6]
     je l3
     
     l1:
     add ax, [bp-6]
     jmp end
     
     l2:
     add ax, [bp-4]
     jmp end
     
     l3:
     add ax, [bp-2]     ; it will return 9
     
     
     end:
     add sp, 6
     pop bp
     ret 
     

start:

push word 09C0h   ; int in ah=09, fraction in al=32 which represents 0.75(256/12) 
;9.75
call ceilF

mov ax, 0x4c00
int 21h
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: double fabs(double) 
; -----------------------
; usage: This function returns the absolute value of any number.
; input:  double num is passed as a parameter
; output: absolute will be calculated of the num
[org 0x0100]
jmp start
fabs_num:
       push bp
       mov bp,sp
       sub sp, 2
       
       mov word[bp-2], -1   ; local variable
       mov ax, [bp+4]       ; num of which the abs has to find
       
       cmp ax, 0            ; if lower then multiply with -1
       jl l1
       jmp end              ; already positive
       
       l1:
       mul word[bp-2]
       
       end:
       add sp, 2
       pop bp
       ret
start:

push word -1140h           ;-11.5
call fabs_num

mov ax, 0x4c00
int 21h


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: double pow(double, double)
; -----------------------
; usage:  This function takes one argument as base and other as exponent. 
; input:  string and buffer are passed as a parameter in the func
; output: string will be copied into buffer
[org 0x0100]
jmp start

power:
                finit              ;clears to 0
                fld qword[exp]     ; 1st parameter
                fist word[ex]      ; converted into int
                mov ax, [ex]       
                fld qword[base]    ;  2nd parameter
                
                l:
                fmul qword[base]   ;  mul the base, exp times
                inc word[c]
                cmp word[c],ax
                jne l

                fist word[res]     ; ans converted into int
                mov bx, [res]

                ret
start:

                call power
                mov ax, 0x4c00
                int 21h
base: dq 2.09
exp: dq 4.01
c: dw 1
ex: dw 0
res: dw 0

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
; -----------------------
; name: double hypot(double, double) 
; -----------------------
; usage:  This function requires two sides of the right angled triangle to  give output as its hypotenuse. 
; input:  base and perpendicular are pushed on top of stack of fpu as parameters
; output: hypotenuse of the traingle will be calculated
[org 0x0100]
jmp start

hypotenuse:

            fld qword[base]      ; base on top of stack
            fmul qword[base]     ; base^2

            fld qword[perp]      ; perp on top of stack
            fmul qword[perp]     ; perp^2

            fadd st0,st1         ; base^2+perp^2
            fsqrt                ; sqrt of base^2+perp^2
            fist word[hyp]       ; converted into int form
            mov ax, [hyp]        ; hyp is calculated

            ret
start:

            call hypotenuse
mov ax, 0x4c00
int 21h

base: dq 4.8
perp: dq 3.9
hyp: dw 0    
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

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
; name: int rand(int)
; -----------------------
; usage: This function takes a number and returns a random number int the range 0→a
; input: digit is passed as a parameter in the function
; output: random number will be printed in console
[org 0x0100]
jmp start

rand:              ; generate a rand no using the system time
   push bp
   mov bp, sp
   mov bx, [bp+4]  ; range as parameter
  
   mov ah, 00h     ; interrupts to get system time        
   int 1ah         ; CX:DX now hold number of clock ticks since midnight      
l:                 ; loop for generating random number in the range
   mov  ax, dx
   xor  dx, dx
   mov  cx, 10    
   div  cx         ; here dx contains the remainder of the division - from 0 to 9
   
   add  dl, '0'    ; to ascii from '0' to '9'
   mov ah, 2h      ; call interrupt to display a value in DL
   int 21h
   dec bx
   cmp bx, 0
   jne l
   
   pop bp 
   ret  
start:
push word 2         ; digit range(2=100)
call rand

mov ax,0x4c00
int 21h

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

; -----------------------
; name: double sqrt(double)
; -----------------------
; usage:  This function takes number as an argument and return its square 
; root value.  Number cannot be negative value.
; input:  num is passed as a parameter
; output: sqrt will be calculated of the num
[org 0x0100]

jmp start

squareRoot:
          fsqrt                ; 59.8sqrt=7.733
          fist dword[res]      ; round off to 8
          mov ax, [res]        ; i tried different fpu instructions but the floating points are not 
                               ; appearing in afd so i convert the floating points in int
ret           
start:
          fld qword[num]
          call squareRoot

mov ax, 0x4c00
int 21h
num:dq 59.8
res: dw 0

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

; -----------------------
; name: double ceil(double) 
; -----------------------
; usage:  This function returns the smallest integer as double not less than the  argument provided.
; input:  double num is passed as a parameter
; output: ceil will be calculated
[org 0x0100]

jmp start

ceilF:
     push bp
     mov bp, sp
     sub sp, 6
     mov word[bp-2], 40h  ;0.25
     mov word[bp-4], 80h  ;0.5
     mov word[bp-6], 0xC0 ;0.75
     mov ax, [bp+4]       ;9.75
     
     cmp al, [bp-2]
     je l1
     cmp al, [bp-4]
     je l2
     cmp al, [bp-6]
     je l3
     
     l1:
     sub ax, [bp-2]
     jmp end
     
     l2:
     add ax, [bp-4]
     jmp end
     
     l3:
     sub ax, [bp-6]     ; it will return 9
     
     
     end:
     add sp, 6
     pop bp
     ret 
     

start:

push word 09C0h   ; int in ah=09, fraction in al=32 which represents 0.75(256/12) 
;9.75
call ceilF

mov ax, 0x4c00
int 21h

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
