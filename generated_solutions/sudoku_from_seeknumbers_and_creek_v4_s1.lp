% Define the possible values for a cell
1 { sudoku(X,Y,N) : initial(X,Y,N) } 1 :- cell(X,Y).

% Define the constraints for each row, column and sub-grid
:- sudoku(X,Y,N), sudoku(X,Y,M), N!=M. % no repeated values in the same cell
:- sudoku(X,Y,N), sudoku(X,Z,N), Y!=Z. % no repeated values in the same column
:- sudoku(X,Y,N), sudoku(Z,Y,N), X!=Z. % no repeated values in the same row
:- sudoku(X,Y,N), sudoku(X1,Y1,N), X!=X1, Y!=Y1, (X-1)//3 = (X1-1)//3, (Y-1)//3 = (Y1-1)//3. % no repeated values in the same sub-grid

% Show output predicate sudoku
#show sudoku/3.