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
