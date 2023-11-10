% Define the possible values for a cell
value(1). value(2). value(3). value(4). value(5). value(6). value(7). value(8). value(9).

% A cell is valid if it contains a value between 1 and 9
valid(X,Y,N) :- value(N), initial(X,Y,N).

% A cell is valid if it contains a value between 1 and 9 and is not already assigned
valid(X,Y,N) :- value(N), not sudoku(X,Y,_).

% A cell is valid if it contains a value between 1 and 9 and is not already assigned and is not in the same row as another assigned cell with the same value
valid(X,Y,N) :- value(N), not sudoku(X,Y,_), not sudoku(X,_,N).

% A cell is valid if it contains a value between 1 and 9 and is not already assigned and is not in the same column as another assigned cell with the same value
valid(X,Y,N) :- value(N), not sudoku(X,Y,_), not sudoku(_,Y,N).

% A cell is valid if it contains a value between 1 and 9 and is not already assigned and is not in the same box as another assigned cell with the same value
valid(X,Y,N) :- value(N), not sudoku(X,Y,_), not sudoku(X1,Y1,N), X//3 = X1//3, Y//3 = Y1//3.

% Assign a valid value to a cell
sudoku(X,Y,N) :- valid(X,Y,N).
% Constraint 1: Each cell can only contain one number
:- sudoku(X,Y,N1), sudoku(X,Y,N2), N1 != N2.

% Constraint 2: Each row can only contain one of each number
:- sudoku(X,Y,N), sudoku(X2,Y,N), X != X2.

% Constraint 3: Each column can only contain one of each number
:- sudoku(X,Y,N), sudoku(X,Y2,N), Y != Y2.

% Constraint 4: Each 3x3 box can only contain one of each number
:- sudoku(X,Y,N), sudoku(X2,Y2,N), X/3 = X2/3, Y/3 = Y2/3, (X != X2 ; Y != Y2).

% Show output predicate sudoku
#show sudoku/3.