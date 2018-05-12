;实验2内容1
;用汇编语言编写一个加法程序:1325+9839，用ASCII码的形式将加数与被加数存放在数据区DATA1和DATA2中，并将相加结果显示输出。
DATA	SEGMENT
;DATA1	DB '5231'
;N 		EQU $-DATA1;N位数
DATA1 	DB 255 DUP('0')   
;定义了一个变量名为DATA1  长度为255个字 的字符串  
DATA2 	DB 255 DUP('0') 
N		DB	255	DUP('0')
;几位数
STR0  	DB 'PLEASE INPUT JI WEI SHU: $'  
STR1  	DB 'PLEASE INPUT FIRST NUMBER: $'  
;定义字 准备要输出的字符串先定义好  
STR2  	DB 'PLEASE INPUT SECOND NUMBER: $'   
STR3 	DB 255 DUP('$')  
KONG  	DB  0DH,0AH ,'$' 
;DATA2	DB '9389','0';以0结尾，方便最后进位
DATA	ENDS 

CODE	SEGMENT 
		ASSUME CS:CODE,DS:DATA
START:	MOV AX,DATA 
		MOV DS,AX 
		
		;显示几位数
		LEA DX,STR0 
		MOV AH,09H  
		INT 21H 
		;输入几位数  
		LEA DX,N  
		MOV AH,0AH  
		INT 21H
		;换行
		LEA DX,KONG  
		MOV AH,09H  
		INT 21H
		
		;显示第一个字符串
		LEA DX,STR1  
		MOV AH,09H  
		INT 21H 
		;输入第一个多位数  
		LEA DX,DATA1  
		MOV AH,0AH  
		INT 21H  
		;换行
		LEA DX,KONG  
		MOV AH,09H  
		INT 21H 

		;显示第二个字符串
		LEA DX,STR2  
		MOV AH,09H  
		INT 21H 
		;输入第二个多位数  
		LEA DX,DATA2  
		MOV AH,0AH  
		INT 21H  
		;换行
		LEA DX,KONG  
		MOV AH,09H  
		INT 21H
		
		LEA SI,N+2
		MOV CX,[SI]
		LEA SI,DATA1+2
		LEA DI,DATA2+2
		;MOV CX,4
		MOV AH,0
	  
NEXT1: 	MOV BL,[SI] ;数字的ASCII码
		MOV AL,[DI];数字的ASCII码
		ADD AL,BL
		AAA ;进位存在AH，加数和存在AL
		ADD AL,30H ;转换为ASCII码，用于字符显示字符显示
		MOV [DI],AL;MOV DL,AH ;DL存进位
		ADD [DI+1],AH ;进位直接加在下一位数
		INC SI 
		INC DI
		MOV AH,0;AH每次清零，用于AAA进位
		LOOP NEXT1
	  
		MOV CX,5
NEXT2:	MOV AH,02H  
		MOV DL,[DI]
		INT 21H
		DEC DI
		LOOP NEXT2
	  
		MOV AH,4CH
		INT 21H 
CODE	ENDS 
		END START
