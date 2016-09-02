/*
cqueens.c - solving 8 queens problem in c
CIS*3190 Assignment 4
Geofferson Camp (0658817)
April 7th, 2016
*/

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

//outputs solutions
void print (FILE * out, int * solution) {
    int holder;

    for (int row = 0; row < 8; row++) {
        holder = solution[row];
        for (int col = 0; col < 8; col++) {
            if (col == holder) {
                fprintf(out,"Q");
            } else {
                fprintf(out,".");
            }
        }
        fprintf(out,"\n");
    }
    fprintf(out,"--------\n");

}

//checks for conflicts and places queens
void try (FILE * out, int row, int * solution, bool * vCheck, bool * hCheck, bool * dCheck) {
    int col;

    for (col = 0; col < 8; col++) {
        if (vCheck[col] == true && hCheck[(row+col)-2] == true && dCheck[(row-col)+7] == true) {
            solution[row] = col;
            vCheck[col] = false;
            hCheck[(row+col)-2] = false;
            dCheck[(row-col)+7] = false;
            if (row < 7) {
                try(out,row+1,solution,vCheck,hCheck,dCheck);
            } else {
                print(out,solution);
            }
            vCheck[col] = true;
            hCheck[(row+col)-2] = true;
            dCheck[(row-col)+7] = true;
        }
    }
}

//initilizes board, opens output file, starts main functionality
int main(void) {
    bool vCheck[7],hCheck[14],dCheck[14];
    int solution[7];
    int i;
    FILE * out = NULL;

    out = fopen("queensC.txt", "w+");

    for (i = 0; i < 8; i++) {
        vCheck[i] = true;
    }
    for (i = 0; i < 16; i++) {
        hCheck[i] = true;
    }
    for (i = 0; i < 16; i++) {
        dCheck[i] = true;
    }
    try(out,0,solution,vCheck,hCheck,dCheck);

    printf("Success! solutions printed to queensC.txt\n");

    fclose(out);

    return 1;
}
