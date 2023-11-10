% Define the possible values for each cell
1 { sudoku(X,Y,N) : N = 1..9 } 1 :- initial(X,Y,_).

% Each row must contain all numbers from 1 to 9
:- sudoku(X,Y,N), sudoku(X,Y',N), Y != Y'.

% Each column must contain all numbers from 1 to 9
:- sudoku(X,Y,N), sudoku(X',Y,N), X != X'.

% Each 3x3 sub-grid must contain all numbers from 1 to 9
:- sudoku(X,Y,N), sudoku(X',Y',N), X != X', Y != Y', (X-1)//3 = (X'-1)//3, (Y-1)//3 = (Y'-1)//3.

% Show output predicate sudoku
#show sudoku/3.