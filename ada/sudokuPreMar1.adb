with Ada.Text_IO; use Ada.Text_IO;
with Ada.strings.unbounded; use Ada.strings.unbounded;
with Ada.strings.unbounded.text_io; use Ada.strings.unbounded.text_io;
procedure sudoku is

type boardType is array(1..9,1..9) of integer;

inputPath: unbounded_string;
inputFile: File_Type;
rowBuff: string(1..9);
tempNum: integer;
board: boardType;
boardRow: integer;
solvedChecker: integer;

--print a util row
procedure printUtilRow is 
begin
    put_line("+-----+-----+-----+");
end printUtilRow;

--print a board row
procedure printBoardRow(board: in boardType; row: in integer) is
begin
    put("|");
    for i in 1..3 loop
        put(Integer'image(board(row,i))(2));
        if i /= 3 then
            put(" ");
        end if;
    end loop;
    put("|");
    for j in 4..6 loop
        put(Integer'image(board(row,j))(2));
        if j /= 6 then
            put(" ");
        end if;
    end loop;
    put("|");
    for k in 7..9 loop
        put(Integer'image(board(row,k))(2));
        if k /= 9 then
            put(" ");
        end if;
    end loop; 
    put_line("|");
end printBoardRow;

--Check if move is safe to make
function isSafe(board: boardType; row: integer; col: integer; numToCheck: integer) return integer is
    rowStart: integer;
    colStart: integer;
begin
    rowStart := (((row-1)/3) * 3);
    colStart := (((col-1)/3) * 3);
    for i in 0..8 loop
        if board(row,i+1) = numToCheck then
            return 0;
        elsif board(i+1,col) = numToCheck then
            return 0;
        elsif board((rowStart+(i mod 3))+1,(colStart+(i/3))+1) = numToCheck then 
            return 0;
        end if;
    end loop;

    return 1;
end isSafe;

--Fill in sudoku board
procedure solve(board: in out boardType; row: in integer; col: in integer; returnVal: in out integer) is
begin
    if row < 10 and col < 10 then 
        if board(row,col) /= 0 then
            if (col+1) < 10 then
                solve(board,row,col+1,returnVal);
                return;
            elsif (row+1) < 10 then
                solve(board,row+1,1,returnVal);
                return;
            else
                returnVal := 1;
                return;
            end if;
        else
            for i in 1..9 loop
                if isSafe(board,row,col,i+1) = 1 then
                    board(row,col) := i+1;
                    if (col+1) < 10 then
                        solve(board,row,col+1,returnVal);
                        if returnVal = 1 then
                            returnVal := 1;
                            return; 
                        else
                            board(row,col) := 0;
                        end if; 
                    elsif (row+1) < 10 then
                        solve(board,row+1,1,returnVal);
                        if  returnVal = 1 then
                            returnVal := 1; 
                            return;
                        else
                            board(row,col) := 0;
                        end if;
                    else
                        returnVal := 1;
                        return;
                    end if;
                end if;
            end loop;
            returnVal := 0;
            return;
        end if;
    else
        returnVal := 1;
        return;
    end if;
end solve;

begin
    --file input
    put_line("Enter file path:");
    Get_Line(inputPath);
    Open(inputFile,in_file,To_String(inputPath));
    --Ada.Text_IO.Open (File => inputFile, Mode => Ada.Text_IO.In_File, Name => inputPath);    

    --Building the game board
    boardRow := 1;
    while not End_Of_File (inputFile) loop
        Ada.Text_IO.Get (File => inputFile, Item => rowBuff);
        for i in 1..9 loop
            tempNum := Character'Pos(rowBuff(i)) - 48; --Subtract 0 ASCII value 
            board(boardRow,i) := tempNum;     
        end loop;
        boardRow := boardRow + 1;
    end loop;

    --Solve. algorithm from (codereviewer.stackexchange.com/questions/37430/sudoku-solver-in-c)
    solvedChecker := 0;
    solve(board,1,1,solvedChecker);
    if solvedChecker = 1 then
        put_line("solved er up");
    else
        put_line("didnt solve er up");
    end if; 

    --Outputting game board
    boardRow := 1;
    for j in 1..13 loop
        if j = 1 or j = 5 or j = 9 or j = 13 then
            printUtilRow;
        else
            printBoardRow(board,boardRow);
            boardRow := boardRow + 1;
        end if; 
    end loop;

    close (inputFile);
end sudoku;
