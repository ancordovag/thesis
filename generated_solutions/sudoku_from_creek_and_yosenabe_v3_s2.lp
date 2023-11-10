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
% Each cell can only have one value
1 { sudoku(X,Y,N) : dim(N) } 1 :- dim(X), dim(Y).
% Each row must have all the digits from 1 to S*S
:- dim(X), dim(N), not sudoku(X,Y,N).
% Each column must have all the digits from 1 to S*S
:- dim(Y), dim(N), not sudoku(X,Y,N).
% Each subgrid must have all the digits from 1 to S*S
:- subgrid(D), dim(N), not sudoku(X,Y,N), map(X,Y,D).
% Each cell must have a unique value
:- sudoku(X,Y,N), sudoku(X,Y,N'), N != N'.