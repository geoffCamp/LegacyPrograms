#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

//outputs solutions
void print (FILE * out, int * solution) {
    int holder;

    for (int i = 0; i < 8; i++) {
        holder = solution[i];
        for (int j = 0; j < 8; j++) {
            if (j == holder) {
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
void try (FILE * out, int i, int * solution, bool * a, bool * b, bool * c) {
    int j;

    for (j = 0; j < 8; j++) {
        if (a[j] == true && b[(i+j)-2] == true && c[(i-j)+7] == true) {
            solution[i] = j;
            a[j] = false;
            b[(i+j)-2] = false;
            c[(i-j)+7] = false;
            if (i < 7) {
                try(out,i+1,solution,a,b,c);
            } else {
                print(out,solution);
            }
            a[j] = true;
            b[(i+j)-2] = true;
            c[(i-j)+7] = true;
        }
    }
}

//initilizes board, opens output file, starts main functionality
int main(void) {
    bool a[7],b[14],c[14];
    int solution[7];
    int i;
    FILE * out = NULL;

    out = fopen("queensC.txt", "w+");

    for (i = 0; i < 8; i++) {
        a[i] = true;
    }
    for (i = 0; i < 15; i++) {
        b[i] = true;
    }
    for (i = 0; i < 16; i++) {
        c[i] = true;
    }
    try(out,0,solution,a,b,c);

    fclose(out);

    return 1;
}
