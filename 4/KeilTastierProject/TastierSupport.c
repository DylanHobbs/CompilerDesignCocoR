#include <stdio.h>
#include <stdlib.h>

// div function

extern int TastierDiv(int, int);

int TastierDiv(int i, int j) {
    div_t result;
    result=div(i,j);
    return result.quot;
}

// mod function

extern int TastierMod(int, int);

int TastierMod(int i, int j) {
    div_t result;
    result=div(i,j);
    return result.rem;
}

// print integer value

extern void TastierPrintInt(int);

void TastierPrintInt(int i) {
    printf("%d", i);
}

// print integer value with new line

extern void TastierPrintIntLf(int);

void TastierPrintIntLf(int i) {
    printf("%d\n", i);
}

// print true

extern void TastierPrintTrue(void);

void TastierPrintTrue(void) {
    printf("true");
}

// print true with new line

extern void TastierPrintTrueLf(void);

void TastierPrintTrueLf(void) {
    printf("true\n");
}

// print false

extern void TastierPrintFalse(void);

void TastierPrintFalse(void) {
    printf("false");
}

// print false with new line

extern void TastierPrintFalseLf(void);

void TastierPrintFalseLf(void) {
    printf("false\n");
}

// print string

extern void TastierPrintString(int text) {
    // text - address of zero terminated string
    // note - use \n in string to get new line
    printf("%s", text);
}

// read integer value

extern int TastierReadInt(void);

int TastierReadInt(void) {
    int i;
    scanf("%d", &i);
    return i;
}
