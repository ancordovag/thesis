% Define the possible values for a cell
value(1). value(2). value(3). value(4). value(5). value(6). value(7). value(8). value(9).

% A cell can have a value if it is not already assigned
sudoku(X,Y,N) :- value(N), not initial(X,Y,_).

% A row can have each value only once
:- sudoku(X,Y,N), sudoku(X,YY,N), Y != YY.

% A column can have each value only once
:- sudoku(X,Y,N), sudoku(XX,Y,N), X != XX.

% A box can have each value only once
:- sudoku(X,Y,N), sudoku(XX,YY,N), X/3 = XX/3, Y/3 = YY/3, X != XX, Y != YY.
% Each cell must have a value between 1 and 9
1 { sudoku(X,Y,N) : N = 1..9 } 1 :- cell(X,Y).

% Each row must have unique values
:- sudoku(X,Y,N), sudoku(X,Y2,N), Y != Y2.

% Each column must have unique values
:- sudoku(X,Y,N), sudoku(X2,Y,N), X != X2.

% Each box must have unique values
:- sudoku(X,Y,N), sudoku(X2,Y2,N), X/3 = X2/3, Y/3 = Y2/3, X != X2, Y != Y2.

% Show the output predicate
#show sudoku/3.