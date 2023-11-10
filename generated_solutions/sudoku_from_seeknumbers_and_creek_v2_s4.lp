% Define the possible values for a cell
1 { sudoku(X,Y,N) : initial(X,Y,N) } 1 :- cell(X,Y).

% Define the constraints for rows, columns, and boxes
:- sudoku(X,Y,N), sudoku(X,Y,M), N != M. % Constraint for rows
:- sudoku(X,Y,N), sudoku(P,Y,N), X != P. % Constraint for columns
:- sudoku(X,Y,N), sudoku(X,Y,M), X1 = (X-1)/3, Y1 = (Y-1)/3, X2 = (X-1)%3, Y2 = (Y-1)%3, sudoku(X1*3+X2+1,Y1*3+Y2+1,N), X != X1*3+X2+1, Y != Y1*3+Y2+1. % Constraint for boxes

% Show output predicate sudoku
#show sudoku/3.
% Constraint 1: The same number cannot appear twice in the same row.
:- sudoku(X,Y,N), sudoku(X,YY,N), Y != YY.

% Constraint 2: The same number cannot appear twice in the same column.
:- sudoku(X,Y,N), sudoku(XX,Y,N), X != XX.

% Constraint 3: The same number cannot appear twice in the same 3x3 box.
:- sudoku(X,Y,N), sudoku(XX,YY,N), X/3 = XX/3, Y/3 = YY/3, X != XX, Y != YY.

% Show output predicate
#show sudoku/3.