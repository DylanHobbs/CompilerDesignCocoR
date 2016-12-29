Subtract
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       SubtractBody
SubtractBody
    LDR     R2, =0
    LDR     R5, [R4, R2, LSL #2] ; i
    LDR     R6, =1
    SUB     R5, R5, R6
    LDR     R2, =0
    STR     R5, [R4, R2, LSL #2] ; i
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from Subtract
Add
    LDR     R0, =2          ; current lexic level
    LDR     R1, =0          ; number of local variables
    BL      enter           ; build new stack frame
    B       AddBody
AddBody
    LDR     R2, =0
    LDR     R5, [R4, R2, LSL #2] ; i
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L1              ; jump on condition false
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; sum
    LDR     R2, =0
    LDR     R6, [R4, R2, LSL #2] ; i
    ADD     R5, R5, R6
    MOV     R2, BP          ; load current base pointer
    LDR     R2, [R2,#8]
    ADD     R2, R2, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; sum
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
SumUp
    LDR     R0, =1          ; current lexic level
    LDR     R1, =2          ; number of local variables
    BL      enter           ; build new stack frame
    B       SumUpBody
SumUpBody
    LDR     R2, =0
    LDR     R5, [R4, R2, LSL #2] ; i
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; j
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; sum
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       Add
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L3
    DCB     "The sum of the values from 1 to ", 0
    ALIGN
L3
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; j
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L4
    DCB     " is ", 0
    ALIGN
L4
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; sum
    MOV     R0, R5
    BL      TastierPrintIntLf
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from SumUp
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: j | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 1 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: sum | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 1 | NAME: Subtract | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 1 | NAME: Add | SetVal: 0 | size2d: 1 | size1d: 1
test
    LDR     R0, =1          ; current lexic level
    LDR     R1, =12          ; number of local variables
    BL      enter           ; build new stack frame
    B       testBody
testBody
    LDR     R5, =1
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    LDR     R5, =1
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; b
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =2
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; lol
    LDR     R5, =9
    ADD     R2, BP, #16
    LDR     R1, =10
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; lol
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L5
    DCB     "Should be 9", 0
    ALIGN
L5
    ADD     R2, BP, #16
    LDR     R1, =10
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; lol
    MOV     R0, R5
    BL      TastierPrintIntLf
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from test
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: a | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 1 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: b | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 2 | KIND: ARRAY  | TYPE: INT    | LEVEL: 1 | NAME: lol | SetVal: 0 | size2d: 3 | size1d: 3
;ADR: 11 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: c | SetVal: 0 | size2d: 1 | size1d: 1
mainline
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       test
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    LDR     R5, =1
    LDR     R6, =0
    CMP     R5, R6
    MOVLT   R5, #1
    MOVGE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L6              ; jump on condition false
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    LDR     R6, =10
    ADD     R5, R5, R6
    B       L7
L6
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    LDR     R6, =40
    ADD     R5, R5, R6
L7
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L8
    DCB     "a should be 40:", 0
    ALIGN
L8
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L9
    DCB     "\n", 0
    ALIGN
L9
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    LDR     R5, =1
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L10              ; jump on condition false
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    LDR     R6, =10
    ADD     R5, R5, R6
    B       L11
L10
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    LDR     R6, =40
    ADD     R5, R5, R6
L11
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L12
    DCB     "a should be 10:", 0
    ALIGN
L12
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L13
    DCB     "\n", 0
    ALIGN
L13
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L14
    DCB     "Loop from 0-4 \n", 0
    ALIGN
L14
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    B       L16
L15
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    LDR     R6, =1
    ADD     R5, R5, R6
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
L16
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    LDR     R6, =5
    CMP     R5, R6
    MOVLT   R5, #1
    MOVGE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L17              ; jump on condition false
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L18
    DCB     " ", 0
    ALIGN
L18
    B       L15
L17
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L19
    DCB     "\n", 0
    ALIGN
L19
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L20
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L20
    BL      TastierReadInt
    LDR     R2, =0
    STR     R0, [R4, R2, LSL #2] ; i
L21
    LDR     R2, =0
    LDR     R5, [R4, R2, LSL #2] ; i
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L22              ; jump on condition false
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       SumUp
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L23
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L23
    BL      TastierReadInt
    LDR     R2, =0
    STR     R0, [R4, R2, LSL #2] ; i
    B       L21
L22
StopTest
    B       StopTest
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: a | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 1 | KIND: ARRAY  | TYPE: INT    | LEVEL: 1 | NAME: arr | SetVal: 0 | size2d: 1 | size1d: 3
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 0 | NAME: i | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: SumUp | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: test | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: main | SetVal: 0 | size2d: 1 | size1d: 1
