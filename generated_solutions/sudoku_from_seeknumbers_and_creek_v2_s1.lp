% Define the possible values for a cell
1 { sudoku(X,Y,N) : initial(X,Y,N) } 1 :- cell(X,Y).
% Define the possible values for a cell that is not initially filled
1 { sudoku(X,Y,N) : cell(X,Y), not initial(X,Y,_) } 1 :- cell(X,Y).

% Define the constraints for each row
:- sudoku(X,Y,N), sudoku(X,Y,M), Y!=Y, N=M.

% Define the constraints for each column
:- sudoku(X,Y,N), sudoku(P,Y,N), X!=P.

% Define the constraints for each 3x3 sub-grid
:- sudoku(X,Y,N), sudoku(P,Q,N), X/3=P/3, Y/3=Q/3, X!=P, Y!=Q.

% Show output predicate sudoku
#show sudoku/3.
% It cannot be that a cell is not filled with a number
:- cell(X,Y), not sudoku(X,Y,_).

% It cannot be that a cell is filled with two different numbers
:- sudoku(X,Y,N), sudoku(X,Y,M), N != M.

% It cannot be that a row contains two cells with the same number
:- sudoku(X,Y,N), sudoku(X,YY,N), Y != YY.

% It cannot be that a column contains two cells with the same number
:- sudoku(X,Y,N), sudoku(XX,Y,N), X != XX.

% It cannot be that a 3x3 sub-grid contains two cells with the same number
:- sudoku(X,Y,N), sudoku(XX,YY,N), X/3 = XX/3, Y/3 = YY/3, X != XX, Y != YY.

% The initial values of the cells must be preserved
:- initial(X,Y,V), sudoku(X,Y,N), V != N.