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
arrayTest
    LDR     R0, =1          ; current lexic level
    LDR     R1, =4          ; number of local variables
    BL      enter           ; build new stack frame
    B       arrayTestBody
arrayTestBody
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L5
    DCB     "------------------------------\n", 0
    ALIGN
L5
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L6
    DCB     "----------Array Test----------\n", 0
    ALIGN
L6
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L7
    DCB     "------------------------------\n", 0
    ALIGN
L7
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; arr
    LDR     R5, =10
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; arr
    ADD     R2, BP, #16
    LDR     R1, =1
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; arr
    ADD     R2, BP, #16
    LDR     R1, =3
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; temp
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L8
    DCB     "temp should be 10 \n", 0
    ALIGN
L8
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L9
    DCB     "temp is ", 0
    ALIGN
L9
    ADD     R2, BP, #16
    LDR     R1, =3
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; temp
    MOV     R0, R5
    BL      TastierPrintIntLf
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from arrayTest
;ADR: 0 | KIND: ARRAY  | TYPE: INT    | LEVEL: 1 | NAME: arr | SetVal: 0 | size2d: 1 | size1d: 3
;ADR: 3 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: temp | SetVal: 0 | size2d: 1 | size1d: 1
array2DTest
    LDR     R0, =1          ; current lexic level
    LDR     R1, =9          ; number of local variables
    BL      enter           ; build new stack frame
    B       array2DTestBody
array2DTestBody
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L10
    DCB     "------------------------------\n", 0
    ALIGN
L10
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L11
    DCB     "-----Start 2D Array Test------\n", 0
    ALIGN
L11
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L12
    DCB     "------------------------------\n", 0
    ALIGN
L12
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; lolarray
    LDR     R5, =9
    ADD     R2, BP, #16
    LDR     R1, =8
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; lolarray
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L13
    DCB     "Should be 9 \n", 0
    ALIGN
L13
    ADD     R2, BP, #16
    LDR     R1, =8
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; lolarray
    MOV     R0, R5
    BL      TastierPrintIntLf
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from array2DTest
;ADR: 0 | KIND: ARRAY  | TYPE: INT    | LEVEL: 1 | NAME: lolarray | SetVal: 0 | size2d: 3 | size1d: 3
testConditionalAssignment
    LDR     R0, =1          ; current lexic level
    LDR     R1, =1          ; number of local variables
    BL      enter           ; build new stack frame
    B       testConditionalAssignmentBody
testConditionalAssignmentBody
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L14
    DCB     "------------------------------\n", 0
    ALIGN
L14
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L15
    DCB     "--Conditional Assigment Test--\n", 0
    ALIGN
L15
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L16
    DCB     "------------------------------\n", 0
    ALIGN
L16
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
    BEQ     L17              ; jump on condition false
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    LDR     R6, =10
    ADD     R5, R5, R6
    B       L18
L17
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
L18
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L19
    DCB     "a should be 40:", 0
    ALIGN
L19
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L20
    DCB     "\n", 0
    ALIGN
L20
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
    BEQ     L21              ; jump on condition false
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    LDR     R6, =10
    ADD     R5, R5, R6
    B       L22
L21
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
L22
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L23
    DCB     "a should be 10:", 0
    ALIGN
L23
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    MOV     R0, R5
    BL      TastierPrintIntLf
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from testConditionalAssignment
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: a | SetVal: 0 | size2d: 1 | size1d: 1
testForLoop
    LDR     R0, =1          ; current lexic level
    LDR     R1, =1          ; number of local variables
    BL      enter           ; build new stack frame
    B       testForLoopBody
testForLoopBody
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L24
    DCB     "------------------------------\n", 0
    ALIGN
L24
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L25
    DCB     "--------For Loop Test---------\n", 0
    ALIGN
L25
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L26
    DCB     "------------------------------\n", 0
    ALIGN
L26
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L27
    DCB     "Loop from 0-4 \n", 0
    ALIGN
L27
    LDR     R5, =0
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    STR     R5, [R2]        ; a
    B       L29
L28
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
L29
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    LDR     R6, =5
    CMP     R5, R6
    MOVLT   R5, #1
    MOVGE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L30              ; jump on condition false
    ADD     R2, BP, #16
    LDR     R1, =0
    ADD     R2, R2, R1, LSL #2
    LDR     R5, [R2]        ; a
    MOV     R0, R5
    BL      TastierPrintInt
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L31
    DCB     " ", 0
    ALIGN
L31
    B       L28
L30
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L32
    DCB     "\n", 0
    ALIGN
L32
    MOV     TOP, BP         ; reset top of stack
    LDR     BP, [TOP,#12]   ; and stack base pointers
    LDR     PC, [TOP]       ; return from testForLoop
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 1 | NAME: a | SetVal: 0 | size2d: 1 | size1d: 1
mainline
    LDR     R5, =1
    LDR     R2, =0
    STR     R5, [R4, R2, LSL #2] ; i
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       arrayTest
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       array2DTest
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       testConditionalAssignment
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       testForLoop
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L33
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L33
    BL      TastierReadInt
    LDR     R2, =0
    STR     R0, [R4, R2, LSL #2] ; i
L34
    LDR     R2, =0
    LDR     R5, [R4, R2, LSL #2] ; i
    LDR     R6, =0
    CMP     R5, R6
    MOVGT   R5, #1
    MOVLE   R5, #0
    MOVS    R5, R5          ; reset Z flag in CPSR
    BEQ     L35              ; jump on condition false
    ADD     R0, PC, #4      ; store return address
    STR     R0, [TOP]       ; in new stack frame
    B       SumUp
    ADD     R0, PC, #4      ; string address
    BL      TastierPrintString
    B       L36
    DCB     "Enter value for i (or 0 to stop): ", 0
    ALIGN
L36
    BL      TastierReadInt
    LDR     R2, =0
    STR     R0, [R4, R2, LSL #2] ; i
    B       L34
L35
StopTest
    B       StopTest
;ADR: 0 | KIND: VAR    | TYPE: INT    | LEVEL: 0 | NAME: i | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: SumUp | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: arrayTest | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: array2DTest | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: testConditionalAssignment | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: testForLoop | SetVal: 0 | size2d: 1 | size1d: 1
;ADR: 0 | KIND: PROC   | TYPE: UNDEF  | LEVEL: 0 | NAME: main | SetVal: 0 | size2d: 1 | size1d: 1
