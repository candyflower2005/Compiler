#include <stdio.h>
#include "string.h"
#include <stdlib.h>


extern void fun_printInt(int n) {
    printf("%d\n", n);
}

extern void fun_printString(const char *str) {
    printf("%s\n", str);
}

extern int fun_readInt() {
    int i;
    scanf("%d\n", &i);
    return i;
}

extern char *fun_readString() {
    char *line = calloc(2048, 1);

    int n;
    getline(&line, &n, stdin);

    if (line[strlen(line)-1] == '\n') {
        line[strlen(line)-1] = '\0';
    } else {
        line[strlen(line)] = '\0';
    }

    char *str = malloc(strlen(line));
    strcpy(str, line);
    free(line);
    return str;
}

extern void fun_error() {
    fprintf(stderr, "runtime error\n");
    exit(1);
}

extern char *fun_concatStrings(const char *str1, const char *str2) {
    char *newStr = malloc(strlen(str1) + strlen(str2) + 1);
    strcpy(newStr, str1);
    strcat(newStr, str2);
    return newStr;
}

extern char *fun_allocString(size_t len) {
    return calloc(len, 1);
}

extern void fun_runTimeError(char *msg) {
    printf("Run time error: %s\n", msg);
    exit(-1);
}