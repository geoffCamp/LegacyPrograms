-- adaqueens.adb - 8queens in ada
-- CIS*3190 Assignment 4
-- Geofferson Camp 0658817
-- April 8, 2016

with Ada.Text_IO; use Ada.Text_IO;

procedure adaqueens is

type aType is array(1..8) of boolean;
type bType is array(2..16) of boolean;
type cType is array(-7..7) of boolean;
type solType is array(1..8) of integer;
a: aType;
b: bType;
c: cType;
solution: solType;
outputFile: File_Type;

--outputs solution
procedure print is
holder: integer;
begin
    for k in 1..8 loop
        holder := solution(k);
        for n in 1..8 loop
            if n = holder then
                Ada.Text_IO.Put(File => outputFile, Item => "Q"); 
            else
                Ada.Text_IO.Put(File => outputFile, Item => "."); 
            end if;
        end loop;
        Ada.Text_IO.Put_Line(File => outputFile, Item => "");
    end loop;
    Ada.Text_IO.Put_Line(File => outputFile, Item => "--------");
end print;

--checks for conflicts and places queens
procedure try(i: in integer) is 
begin
    for j in 1..8 loop
        if a(j) and b(i+j) and c(i-j) then
            solution(i) := j;
            a(j) := false;
            b(i+j) := false;
            c(i-j) := false;
            if i < 8 then
                try(i+1);
            else
                print;
            end if;
            a(j) := true;
            b(i+j) := true;
            c(i-j) := true;
        end if;
    end loop;
end try;

--initilizes board and opens output file
begin
    Open(outputFile,out_file,"queensA.txt"); 
    for i in 1..8 loop
        a(i) := true;
    end loop;
     for i in 2..16 loop
        b(i) := true;
    end loop;
    for i in -7..7 loop
        c(i) := true;
    end loop; 
    try(1);
    close(outputFile);
end adaqueens;
