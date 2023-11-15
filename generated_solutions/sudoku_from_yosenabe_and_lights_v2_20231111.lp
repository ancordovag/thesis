% Define the range of the sudoku grid
range(1..9).

% Each cell in the grid must have exactly one number
1 { sudoku(X,Y,N) : range(N) } 1 :- range(X), range(Y).

% Each number can only appear once in each row
:- range(X), range(N), 1 < #count{ Y : sudoku(X,Y,N) }.

% Each number can only appear once in each column
:- range(Y), range(N), 1 < #count{ X : sudoku(X,Y,N) }.

% Each number can only appear once in each 3x3 sub-grid
:- range(I), range(J), range(N), 1 < #count{ X,Y : sudoku(X,Y,N), (X-1)/3 = I-1, (Y-1)/3 = J-1 }.

% The initial values must be respected
sudoku(X,Y,V) :- initial(X,Y,V).

% Show output predicate
#show sudoku/3.
% Each cell must have exactly one number
1 { sudoku(X,Y,N) : N=1..9 } 1 :- initial(X,Y,_).

% Each row must have all numbers from 1 to 9
1 { sudoku(X,Y,N) : Y=1..9 } 1 :- N=1..9.

% Each column must have all numbers from 1 to 9
1 { sudoku(X,Y,N) : X=1..9 } 1 :- N=1..9.

% Each 3x3 sub-grid must have all numbers from 1 to 9
1 { sudoku(3*X1+X2,3*Y1+Y2,N) : X2=0..2, Y2=0..2 } 1 :- N=1..9, X1=0..2, Y1=0..2.

% The initial values must be respected
:- initial(X,Y,V), sudoku(X,Y,N), V!=N.