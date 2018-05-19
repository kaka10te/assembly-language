;实验2内容1,键盘输入
;用汇编语言编写一个加法程序:1325+9839，用ASCII码的形式将加数与被加数存放在数据区DATA1和DATA2中，并将相加结果显示输出。
DATA	SEGMENT 
DATA1   DB 0
STRING0 DB'PLEASE INPUT THE VALUE:',0DH,0AH,'$'
STRING1 DB'Y=+1 ',0DH,0AH,'$'
STRING2 DB'Y=0 ',0DH,0AH,'$' 
STRING3 DB'Y=-1',0DH,0AH,'$'
DATA    ENDS 
STACK   SEGMENT
        DB 200 DUP(?) 
STACK   ENDS 
CODE    SEGMENT 
        ASSUME CS:CODE,DS:DATA,SS:STACK 
START:  MOV AX,DATA 
        MOV DS,AX 
        LEA DX,STRING0
        MOV AH,9
        INT 21H
        LEA SI,DATA1
        MOV AL,0
INPUT1: MOV AH,1 
        INT 21H
        MOV [SI],AL
        INC SI
        CMP AL,'$'
        LOOPNE INPUT1
        LEA SI,DATA1
        MOV AL,[SI] 
        CMP AL,'-'
        JE  NEXT3
        LEA SI,DATA1
        MOV AL,[SI]
        CMP AL,'0'
        JE  NEXT2
NEXT1:  LEA DX,STRING1 
        MOV AH,09H 
        INT 21H 
        JMP NEXT4 
NEXT2:  LEA DX,STRING2
        MOV AH,09H 
        INT 21H 
        JMP NEXT4 
NEXT3:  LEA DX,STRING3 
        MOV AH,09H 
        INT 21H
NEXT4:  MOV AH,07H
        INT 21H
        MOV AH,4CH
        INT 21H
CODE    ENDS
        END START
