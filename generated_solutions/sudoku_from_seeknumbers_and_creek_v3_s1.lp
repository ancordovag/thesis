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
% It cannot be that a digit is repeated in the same row
:- sudoku(X,Y,N), sudoku(X,Y,M), N!=M.
% It cannot be that a digit is repeated in the same column
:- sudoku(X,Y,N), sudoku(P,Y,N), X!=P.
% It cannot be that a digit is repeated in the same subgrid
:- sudoku(X,Y,N), sudoku(P,Q,N), map(X,Y,G), map(P,Q,G), (X!=P ; Y!=Q).