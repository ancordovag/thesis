% Define the range of the sudoku grid
range(1..9).

% Each cell in the grid must have exactly one number
1 { sudoku(X,Y,N) : range(N) } 1 :- range(X), range(Y).

% Each number must appear exactly once in each row
1 { sudoku(X,Y,N) : range(Y) } 1 :- range(X), range(N).

% Each number must appear exactly once in each column
1 { sudoku(X,Y,N) : range(X) } 1 :- range(Y), range(N).

% Each number must appear exactly once in each 3x3 sub-grid
1 { sudoku(3*X1+X2,3*Y1+Y2,N) : range(X2), range(Y2) } 1 :- range(X1), range(Y1), range(N).

% The initial values are fixed
sudoku(X,Y,V) :- initial(X,Y,V).

% Show output predicate
#show sudoku/3.