TITLE Program Template     (template.asm)

; Author: 
; Last Modified:
; OSU email address: yeeja@oregonstate.edu
; Course number/section:   CS271 Section 001
; Project Number: project #3              Due Date: 5/1
; Description: Implementing data validation, Implementing an accumulator ,Integer arithmetic
				;Defining variables (integer and string), Using constants (integer), Using library procedures for I/O, Implementing control structures (decision, loop)

INCLUDE Irvine32.inc

; (insert macro definitions here)

; (insert constant definitions here)

.data
Open		BYTE	"------------Integer Accumulator by Jameson yee------------", 0
Prompt1		BYTE	"What is your name? ",0
UserName	BYTE	33 DUP(0) ;32 characters
byteCount	DWORD	?
Greeting	BYTE	"Hello there, ",0
Instruct	BYTE	"Please enter numbers in [-200, -100] or [-50, -1].",0
NumPrompt	BYTE	"Enter a non-negative number when you are finished to see results."
numEnter	BYTE    "Enter a number: ",0	
Invalid		BYTE	"Number Invalid!",0
noNumsMsg	BYTE	"You didn't enter any valid numbers!!", 0
numCount	BYTE	"Valid numbers entered: ",0
maxMsg		BYTE	"The maximum valid number is ",0
minMsg		BYTE	"The minimum valid number is ",0
avgMsg		BYTE	"The rounded average is ",0
totalMsg	BYTE	"The sum of your valid numbers is ",0
goodbyeMsg	BYTE	"Farewell, ",0
userNum		DWORD	?
total		DWORD	0
count		DWORD	0
maxNum		DWORD	0
minNum		DWORD	0
avg			DWORD	0

;constants [-200,-100]
UPPERLIMIT = -1
UPPERLIMIT2 = -50
LOWERLIMIT = -100
LOWERLIMIT2 = -200


.code
main PROC
	;---welcome---
	MOV		EDX, OFFSET Open
	CALL 	WriteString
	CALL 	CrLf

	;---get name from user / store in variable---
	MOV		EDX, OFFSET Prompt1
	CALL	WriteString
	MOV		EDX, OFFSET UserName
	MOV		ECX, SIZEOF UserName
	CALL	ReadString
	MOV		byteCount, EAX

	;---print username---
	MOV		EDX, OFFSET Greeting
	CALL	WriteString
	MOV		EDX, OFFSET UserName
	CALL	WriteString
	CALL	CrLf
	CALL	CrLf

	;---how to use---
	MOV		EDX, OFFSET Instruct
	CALL	WriteString
	CALL	CrLf
	CALL	CrLf
		
	;---get numbers---
	numLoop:
		MOV		EDX, OFFSET numEnter
		CALL	WriteString
		CALL	ReadInt
		MOV		userNum, EAX

		;---check in number is in range---
		MOV		EAX, userNum
		CMP		EAX, 0
		JNS		noNums
		CMP		EAX, LOWERLIMIT2
		JL		invalid_msg ;less than -200
		CMP		EAX, UPPERLIMIT
		JG		invalid_msg ;greater than -1

		;add new number to total
		MOV		EBX, total
		ADD		EAX, EBX
		MOV		total, EAX

		;incriment the number of valid nums
		inc		count

		JMP		numLoop

		
	
	;---print invalid message---
	invalid_msg:
		MOV		EDX, OFFSET invalid
		CALL	WriteString
		CALL	CrLf
		CALL	CrLf
		JMP		numLoop

	noNums:
		MOV		EAX, count
		CMP		EAX, 0
		JNE		math

		CALL	CrLf
		MOV		EDX, OFFSET noNumsMsg
		CALL	WriteString
		CALL	CrLf
		JMP		goodbye



	math:
		MOV		EAX, 0
		MOV		EAX, total 
		CDQ		;convert DWORD TO QWORD
		MOV		EBX, count
		IDIV	EBX  ;divide total value by the valid numbers entered
		MOV		avg, EAX
		CALL	CrLf

		;display number of valid numbers
		MOV		EDX, OFFSET numCount
		CALL	WriteString
		MOV		EAX, count
		CALL	WriteDec
		CALL	CrLf

		;display sum of valid numbers
		MOV		EDX, OFFSET totalMsg
		CALL	WriteString
		MOV		EAX, total
		CALL	WriteInt
		CALL	CrLf


		;calculate average using the sum and count of valid numbers
		MOV		EDX, OFFSET avgMsg
		CALL	WriteString
		MOV		EAX, avg
		CALL	WriteInt
		CALL	CrLf

	goodbye:
		MOV		EDX, OFFSET goodbyeMsg
		CALL	WriteString
		MOV		EDX, OFFSET UserName
		CALL	WriteString
		CALL	CrLf
		CALL	CrLf

	Invoke ExitProcess,0	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
