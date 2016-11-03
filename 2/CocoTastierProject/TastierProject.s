	AREA	TastierProject, CODE, READONLY

    IMPORT  TastierDiv
	IMPORT	TastierMod
	IMPORT	TastierReadInt
	IMPORT	TastierPrintInt
	IMPORT	TastierPrintTrue
	IMPORT	TastierPrintFalse
    
; Entry point called from C runtime __main
	EXPORT	main

; Preserve 8-byte stack alignment for external routines
	PRESERVE8

; Register names
BP  RN 10	; pointer to stack base
TOP RN 11	; pointer to top of stack

main
; Initialization
	LDR		R4, =globals
	LDR 	BP, =stack		; address of stack base
	LDR 	TOP, =stack+16	; address of top of stack frame
	B		mainline
; Procedure Subtract
Subtract
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       SubtractBody
SubtractBody
    LDR     R5, [R4]        ; i
    MOV     R6, #1
    SUB     R5, R5, R6
    STR     R5, [R4]        ; i
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from Subtract
; Procedure Add
Add
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       AddBody
AddBody
    LDR     R5, [R4]        ; i
    MOV     R6, #0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    BEQ     L1              ; jump on condition false
    MOV     R0, BP          ; load current base pointer
    LDR     R0, [R0,#8]
    LDR     R5, [R0,#16]    ; sum
    LDR     R6, [R4]        ; i
    ADD     R5, R5, R6
    MOV     R0, BP          ; load current base pointer
    LDR     R0, [R0,#8]
    STR     R5, [R0,#16]    ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Subtract
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
L1
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from Add
; Procedure SumUp
SumUp
    LDR     R0, =1          ; current lexic level
    LDR     R1, =1          ; number of local variables
    BL      enter           ; build new stack frame
    B       SumUpBody
SumUpBody
    MOV     R5, #0
    STR     R5, [BP,#16]    ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    LDR     R5, [BP,#16]    ; sum
    MOV     R0, R5
    BL      TastierPrintInt
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from SumUp
                             ;ADR: 0 KIND: VAR    TYPE: INT    NAME: sum LEVEL: 1
                             ;ADR: 0 KIND: PROC   TYPE: UNDEF  NAME: Subtract LEVEL: 1
                             ;ADR: 0 KIND: PROC   TYPE: UNDEF  NAME: Add LEVEL: 1
mainline
    BL      TastierReadInt
    STR     R0, [R4]        ; i
L2
    LDR     R5, [R4]        ; i
    MOV     R6, #0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    BEQ     L3              ; jump on condition false
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       SumUp
    BL      TastierReadInt
    STR     R0, [R4]        ; i
    B       L2
L3
stopTest
    B       stopTest
                             ;ADR: 0 KIND: VAR    TYPE: INT    NAME: i LEVEL: 0
                             ;ADR: 1 KIND: VAR    TYPE: INT    NAME: j LEVEL: 0
                             ;ADR: 0 KIND: PROC   TYPE: UNDEF  NAME: SumUp LEVEL: 0
                             ;ADR: 0 KIND: PROC   TYPE: UNDEF  NAME: main LEVEL: 0

; Subroutine enter
; Construct stack frame for procedure
; Input: R0 - lexic level (LL)
;		 R1 - number of local variables
; Output: new stack frame

enter
	STR		R0, [TOP,#4]			; set lexic level
	STR		BP, [TOP,#12]			; and dynamic link
	; if called procedure is at the same lexic level as
	; calling procedure then its static link is a copy of
	; the calling procedure's static link, otherwise called
 	; procedure's static link is a copy of the static link 
	; found LL delta levels down the static link chain
    LDR		R2, [BP,#4]				; check if called LL (R0) and
	SUBS	R0, R2					; calling LL (R2) are the same
	BGT		enter1
	LDR		R0, [BP,#8]				; store calling procedure's static
	STR		R0, [TOP,#8]			; link in called procedure's frame
	B		enter2
enter1
	MOV		R3, BP					; load current base pointer
	SUBS	R0, R0, #1				; and step down static link chain
    BEQ     enter2-4                ; until LL delta has been reduced
	LDR		R3, [R3,#8]				; to zero
	B		enter1+4				;
	STR		R3, [TOP,#8]			; store computed static link
enter2
	MOV		BP, TOP					; reset base and top registers to
	ADD		TOP, TOP, #16			; point to new stack frame adding
	ADD		TOP, TOP, R1, LSL #2	; four bytes per local variable
	BX		LR						; return

	AREA	StaticData, DATA, READWRITE
input		EQU	5					; value for i
	
	AREA	Memory, DATA, READWRITE
globals     SPACE 4096
stack      	SPACE 16384

	END