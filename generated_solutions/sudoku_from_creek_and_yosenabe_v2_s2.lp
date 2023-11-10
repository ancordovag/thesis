% Define the possible values for each cell
digit(1). digit(2). digit(3). digit(4). digit(5). digit(6). digit(7). digit(8). digit(9).

% Each cell must have a value between 1 and 9
sudoku(X,Y,N) :- digit(N), initial(X,Y,N).
% Each row must have unique values
:- sudoku(X,Y,N), sudoku(X,Y',N), Y != Y'.
% Each column must have unique values
:- sudoku(X,Y,N), sudoku(X',Y,N), X != X'.
% Each 3x3 sub-grid must have unique values
:- sudoku(X,Y,N), sudoku(X',Y',N), X != X', Y != Y', (X-1)//3 = (X'-1)//3, (Y-1)//3 = (Y'-1)//3.

#show sudoku/3.
% Each cell must have a value between 1 and 9
1 { sudoku(X,Y,N) : initial(X,Y,V) } 1 :- cell(X,Y), V != 0.
sudoku(X,Y,N) :- cell(X,Y), N = 1..9.

% Each row must have unique values
:- sudoku(X,Y,N1), sudoku(X,Y,N2), Y != Y2, N1 = N2.

% Each column must have unique values
:- sudoku(X,Y,N1), sudoku(X2,Y,N2), X != X2, N1 = N2.

% Each 3x3 sub-grid must have unique values
:- sudoku(X,Y,N1), sudoku(X2,Y2,N2), X != X2, Y != Y2, (X-1)//3 = (X2-1)//3, (Y-1)//3 = (Y2-1)//3, N1 = N2.