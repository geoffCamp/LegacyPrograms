- All programs will compile if you "make"

Ada:
 - run with: ./adaqueens
 - gnatmake -Wall adaqueens.adb
 - queensA.txt must pre-exist

Fortran:
 - run with: ./forqueens
 - gfortran -Wall forqueens.f95 -o forqueens
 - queensF.txt must pre-exist

C:
 - run with: ./cqueens
 - gcc -Wall -std=c99 cqueens.c -o cqueens
