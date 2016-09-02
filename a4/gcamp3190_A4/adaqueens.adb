-- adaqueens.adb - solving 8 queens in ada
-- CIS*3190 Assignment 4
-- Geofferson Camp (0658817)
-- April 8, 2016

with Ada.Text_IO; use Ada.Text_IO;

procedure adaqueens is

type vType is array(1..8) of boolean;
type hType is array(2..16) of boolean;
type dType is array(-7..7) of boolean;
type solType is array(1..8) of integer;
vCheck: vType;
hCheck: hType;
dCheck: dType;
solution: solType;
outputFile: File_Type;

--outputs solution
procedure print is
holder: integer;
begin
    for row in 1..8 loop
        holder := solution(row);
        for col in 1..8 loop
            if col = holder then
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
procedure try(row: in integer) is 
begin
    for col in 1..8 loop
        if vCheck(col) and hCheck(row+col) and dCheck(row-col) then
            solution(row) := col;
            vCheck(col) := false;
            hCheck(row+col) := false;
            dCheck(row-col) := false;
            if row < 8 then
                try(row+1);
            else
                print;
            end if;
            vCheck(col) := true;
            hCheck(row+col) := true;
            dCheck(row-col) := true;
        end if;
    end loop;
end try;

--initilizes board and opens output file
begin
    Open(outputFile,out_file,"queensA.txt"); 
    for i in 1..8 loop
        vCheck(i) := true;
    end loop;
     for i in 2..16 loop
        hCheck(i) := true;
    end loop;
    for i in -7..7 loop
        dCheck(i) := true;
    end loop; 
    try(1);
    Put_Line("Success! solutions printed to queensA.txt");
    close(outputFile);
end adaqueens;
