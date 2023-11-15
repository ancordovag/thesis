% Define the range of numbers, rows and columns
num(1..9).
row(1..9).
col(1..9).

% Define the initial values
sudoku(X,Y,N) :- initial(X,Y,N).

% Each cell must have exactly one number
1 { sudoku(X,Y,N) : num(N) } 1 :- row(X), col(Y).

% Each number must appear exactly once in each row
1 { sudoku(X,Y,N) : col(Y) } 1 :- row(X), num(N).

% Each number must appear exactly once in each column
1 { sudoku(X,Y,N) : row(X) } 1 :- col(Y), num(N).

% Each number must appear exactly once in each 3x3 sub-grid
1 { sudoku(X,Y,N) : row(X), col(Y) } 1 :- num(N), row(I), col(J), X = (I-1)*3 + 1..I*3, Y = (J-1)*3 + 1..J*3.

% Show output predicate
#show sudoku/3.
                    % For each cell, there is exactly one digit
1 { sudoku(X,Y,N) : poss(X,Y,N) } 1 :- dim(X), dim(Y).

% No two cells in the same row have the same digit
:- sudoku(X,Y1,N), sudoku(X,Y2,N), Y1 != Y2.

% No two cells in the same column have the same digit
:- sudoku(X1,Y,N), sudoku(X2,Y,N), X1 != X2.

% No two cells in the same subgrid have the same digit
:- sudoku(X1,Y1,N), sudoku(X2,Y2,N), map(X1,Y1,S), map(X2,Y2,S), X1 != X2, Y1 != Y2.