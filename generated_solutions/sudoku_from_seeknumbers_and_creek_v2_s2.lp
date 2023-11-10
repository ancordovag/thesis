% Define the possible values for a cell
1 { sudoku(X,Y,N) : initial(X,Y,N) } 1 :- cell(X,Y).
% Define the possible values for a cell that is not initially filled
1 { sudoku(X,Y,N) : cell(X,Y), not initial(X,Y,_) } 1 :- cell(X,Y).

% Define the constraints for each row, column, and sub-grid
:- sudoku(X,Y,N), sudoku(X,Y,M), N != M. % no two cells in the same row can have the same value
:- sudoku(X,Y,N), sudoku(Z,Y,N), X != Z. % no two cells in the same column can have the same value
:- sudoku(X,Y,N), sudoku(X,Z,N), Y != Z. % no two cells in the same sub-grid can have the same value

% Show output predicate sudoku
#show sudoku/3.
% It cannot be the case that a cell is not filled with a number
:- cell(X,Y), not filled(X,Y,_).
% It cannot be the case that a cell is filled with a number that is not between 1 and 9
:- filled(X,Y,N), not between(N,1,9).
% It cannot be the case that a row contains the same number twice
:- filled(X,Y,N), filled(X,YY,N), Y != YY.
% It cannot be the case that a column contains the same number twice
:- filled(X,Y,N), filled(XX,Y,N), X != XX.
% It cannot be the case that a 3x3 sub-grid contains the same number twice
:- filled(X,Y,N), filled(XX,YY,N), subgrid(X,Y,XX,YY).
% It cannot be the case that a cell is not initially filled with a number
:- cell(X,Y), initial(X,Y,_), not filled(X,Y,_).
% It cannot be the case that a cell is initially filled with a number that is not between 1 and 9
:- initial(X,Y,N), not between(N,1,9).