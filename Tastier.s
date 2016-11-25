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
    ADD     R0, BP, #16
    LDR     R1, =1
    STR     R5, [R0, R1, LSL #2]        ; arr
    LDR     R5, =10
    ADD     R0, BP, #16
    LDR     R1, =2
    STR     R5, [R0, R1, LSL #2]        ; arr
    ADD     R0, BP, #16
    LDR     R1, =2
    LDR     R5, [R0, R1, LSL #2]        ; arr
    STR     R5, [BP,#16]    ; a
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L5
    DCB     "a should be 10 \n", 0
    ALIGN
L5
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L6
    DCB     "a is ", 0
    ALIGN
L6
    LDR     R5, [BP,#16]    ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L7
    DCB     "\n", 0
    ALIGN
L7
    LDR     R5, =0
    STR     R5, [BP,#16]    ; a
    LDR     R5, =1
    LDR     R6, =0
    CMP     R5, R6
    MOVLT   R5, #1
    MOVGE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L8              ; jump on condition false
    LDR     R5, [BP,#16]    ; a
    LDR     R6, =10
    ADD     R5, R5, R6
    B       L9
L8
    STR     R5, [BP,#16]    ; a
    LDR     R5, [BP,#16]    ; a
    LDR     R6, =40
    ADD     R5, R5, R6
L9
    STR     R5, [BP,#16]    ; a
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L10
    DCB     "a should be 40:", 0
    ALIGN
L10
    LDR     R5, [BP,#16]    ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L11
    DCB     "\n", 0
    ALIGN
L11
    LDR     R5, =0
    STR     R5, [BP,#16]    ; a
    LDR     R5, =1
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L12              ; jump on condition false
    LDR     R5, [BP,#16]    ; a
    LDR     R6, =10
    ADD     R5, R5, R6
    B       L13
L12
    STR     R5, [BP,#16]    ; a
    LDR     R5, [BP,#16]    ; a
    LDR     R6, =40
    ADD     R5, R5, R6
L13
    STR     R5, [BP,#16]    ; a
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L14
    DCB     "a should be 10:", 0
    ALIGN
L14
    LDR     R5, [BP,#16]    ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L15
    DCB     "\n", 0
    ALIGN
L15
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L16
    DCB     "Loop from 0-4 \n", 0
    ALIGN
L16
    LDR     R5, =0
    STR     R5, [BP,#16]    ; a
    B       L18
L17
    LDR     R5, [BP,#16]    ; a
    LDR     R6, =1
    ADD     R5, R5, R6
    STR     R5, [BP,#16]    ; a
L18
    LDR     R5, [BP,#16]    ; a
    LDR     R6, =5
    CMP     R5, R6
    MOVLT   R5, #1
    MOVGE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L19              ; jump on condition false
    LDR     R5, [BP,#16]    ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L20
    DCB     " ", 0
    ALIGN
L20
    B       L17
L19
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L21
    DCB     "\n", 0
    ALIGN
L21
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L22
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L22
    BL      TastierReadInt
    STR     R0, [R4]        ; i
L23
    LDR     R5, [R4]        ; i
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L24              ; jump on condition false
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       SumUp
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L25
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L25
    BL      TastierReadInt
    STR     R0, [R4]        ; i
    B       L23
L24
stopTest
    B       stopTest
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: a | SetVal: 0
;ADR: 1 | KIND: ARRAY  | TYPE: INT    | LEVEL: 1 | NAME: arr | SetVal: 0
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 0 | NAME: i | SetVal: 0
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: SumUp | SetVal: 0
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: main | SetVal: 0
