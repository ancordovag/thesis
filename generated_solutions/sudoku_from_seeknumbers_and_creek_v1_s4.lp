% Generate all possible numbers for each cell
1 { initial(X,Y,N) : N=1..9 } 1 :- cell(X,Y).

% Generate all possible numbers for each cell in the solution
1 { sudoku(X,Y,N) : N=1..9 } 1 :- cell(X,Y).

% Each row should contain all numbers from 1 to 9
:- cell(X,Y), not sudoku(X,Y,N), {N=1..9} != 9.

% Each column should contain all numbers from 1 to 9
:- cell(X,Y), not sudoku(X,Y,N), {N=1..9} != 9.

% Each box should contain all numbers from 1 to 9
:- cell(X,Y), not sudoku(X,Y,N), {N=1..9} != 9.

% Two cells in the same box should not have the same number
:- same_box(X1,Y1,X2,Y2), sudoku(X1,Y1,N), sudoku(X2,Y2,N), (X1,Y1) != (X2,Y2).

% Two cells in the same row should not have the same number
:- cell(X1,Y1), cell(X2,Y2), X1=Y1, X2=Y2, sudoku(X1,Y1,N), sudoku(X2,Y2,N), (X1,Y1) != (X2,Y2).

% Two cells in the same column should not have the same number
:- cell(X1,Y1), cell(X2,Y2), X1=Y1, X2=Y2, sudoku(X1,Y1,N), sudoku(X2,Y2,N), (X1,Y1) != (X2,Y2).

% Define the boxes
same_box(X1,Y1,X2,Y2) :- X1=X2, Y1=Y2, cell(X1,Y1).
same_box(X1,Y1,X2,Y2) :- X1=X2, Y1=Y2, cell(X1,Y1+1).
same_box(X1,Y1,X2,Y2) :- X1=X2, Y1=Y2, cell(X1,Y1+2).
same_box(X1,Y1,X2,Y2) :- X1=X2, Y1=Y2, cell(X1+1,Y1).
same_box(X1,Y1,X2,Y2) :- X1=X2, Y1=Y2, cell(X1+1,Y1+1).
same_box(X1,Y1,X2,Y2) :- X1=X2, Y1=Y2, cell(X1+1,Y1+2).
same_box(X1,Y1,X2,Y2) :- X1=X2, Y1=Y2, cell(X1+2,Y1).
same_box(X1,Y1,X2,Y2) :- X1=X2, Y1=Y2, cell(X1+2,Y1+1).
same_box(X1,Y1,X2,Y2) :- X1=X2, Y1=Y2, cell(X1+2,Y1+2).

% Show output predicate sudoku
#show sudoku/3.
% Constraint 1: The same number cannot appear twice in the same row.
:- sudoku(X,Y,N), sudoku(X,YY,N), Y != YY.

% Constraint 2: The same number cannot appear twice in the same column.
:- sudoku(X,Y,N), sudoku(XX,Y,N), X != XX.

% Constraint 3: The same number cannot appear twice in the same 3x3 box.
:- sudoku(X,Y,N), sudoku(XX,YY,N), same_box(X,Y,XX,YY), (X != XX ; Y != YY).

% Constraint 4: The initial state of the grid must be satisfied.
:- initial(X,Y,N), not sudoku(X,Y,N).

% Constraint 5: The solution must be a valid Sudoku grid.
:- sudoku(X,Y,N), not initial(X,Y,N).

% Show output predicate
#show sudoku/3.