;将一组有符号存储字节数按从大到小的顺序排序，设数据变量为VAR，数组元素个数为N
DATA SEGMENT
VAR	 DW -1,-10,-100,27H,0AH,47H
N EQU ($-VAR)/2
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START: MOV AX,DATA
	   MOV DS,AX
	   MOV CX,N-1
	   
WC	   XOR SI,SI           ;异或清零
	   XOR DI,DI
	   
NC	   MOV AX,[SI];NC内循环
	   MOV BX,[SI+2];DW
	   CMP AX,BX
	   JLE ABC;大于就交换，否则小于等于就不交换
	   MOV [SI],BX
	   MOV [SI+2],AX
ABC	   ADD SI,2;一次比较结束，SI代表元素位置，DI代表已经比较次数
	   INC DI
	   CMP DI,CX;比较SI位置，判断是否跳出内循环
	   JB NC;NC内循环
	   LOOP WC;WC外循环
	   
	   MOV AH,4CH
	   INT 21H
CODE   ENDS
END START
