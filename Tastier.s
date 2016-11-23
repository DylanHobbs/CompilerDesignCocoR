; Procedure Subtract
Subtract
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       SubtractBody
SubtractBody
    LDR     R5, [R4]        ; i
    LDR     R6, =1
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
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L1              ; jump on condition false
    MOV     R0, BP          ; load current base pointer
    LDR     R0, [R0,#8]
    ADD     R0, R0, #16
    LDR     R1, =1
    LDR     R5, [R0, R1, LSL #2]        ; sum
    LDR     R6, [R4]        ; i
    ADD     R5, R5, R6
    MOV     R0, BP          ; load current base pointer
    LDR     R0, [R0,#8]
    ADD     R0, R0, #16
    LDR     R1, =1
    STR     R5, [R0, R1, LSL #2]        ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Subtract
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    B       L2
L1
L2
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from Add
; Procedure SumUp
SumUp
    LDR     R0, =1          ; current lexic level
    LDR     R1, =2          ; number of local variables
    BL      enter           ; build new stack frame
    B       SumUpBody
SumUpBody
    LDR     R5, [R4]        ; i
    STR     R5, [BP,#16]    ; j
    LDR     R5, =0
    ADD     R0, BP, #16
    LDR     R1, =1
    STR     R5, [R0, R1, LSL #2]        ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L3
    DCB     "The sum of the values from 1 to ", 0
    ALIGN
L3
    LDR     R5, [BP,#16]    ; j
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L4
    DCB     " is ", 0
    ALIGN
L4
    ADD     R0, BP, #16
    LDR     R1, =1
    LDR     R5, [R0, R1, LSL #2]        ; sum
    MOV     R0, R5
    BL      TastierPrintIntLf
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from SumUp
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: j | SetVal: 0
;ADR: 1 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: sum | SetVal: 0
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 1 | NAME: Subtract | SetVal: 0
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 1 | NAME: Add | SetVal: 0
mainline
    LDR     R5, =0
    STR     R5, [BP,#16]    ; a
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L5
    DCB     "a := ", 0
    ALIGN
L5
    LDR     R5, [BP,#16]    ; a
    MOV     R0, R5
    BL      TastierPrintInt
    LDR     R5, =0
    STR     R5, [BP,#16]    ; a
L6
    LDR     R5, [BP,#16]    ; a
    LDR     R6, =1
    ADD     R5, R5, R6
    STR     R5, [BP,#16]    ; a
    LDR     R5, [BP,#16]    ; a
    LDR     R6, =5
    CMP     R5, R6
    MOVLT   R5, #1
    MOVGE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L8              ; jump on condition false
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L9
    DCB     "a is ", 0
    ALIGN
L9
    LDR     R5, [BP,#16]    ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L10
    DCB     " ", 0
    ALIGN
L10
    B       L6
L8
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L11
    DCB     "a := ", 0
    ALIGN
L11
    LDR     R5, [BP,#16]    ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L12
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L12
    BL      TastierReadInt
    STR     R0, [R4]        ; i
L13
    LDR     R5, [R4]        ; i
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L14              ; jump on condition false
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       SumUp
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L15
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L15
    BL      TastierReadInt
    STR     R0, [R4]        ; i
    B       L13
L14
stopTest
    B       stopTest
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: a | SetVal: 0
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 0 | NAME: i | SetVal: 0
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: SumUp | SetVal: 0
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: main | SetVal: 0
