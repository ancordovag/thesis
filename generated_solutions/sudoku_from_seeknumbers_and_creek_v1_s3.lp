% Generate all possible values for each cell in the grid
1 { grid(X,Y,N) : N=1..9 } 1 :- cell(X,Y).

% Each row should contain unique values from 1 to 9
:- row(X,Y,N), row(X,Z,N), Y!=Z.

% Each column should contain unique values from 1 to 9
:- column(X,Y,N), column(Z,Y,N), X!=Z.

% Each box should contain unique values from 1 to 9
:- box(X,Y,N), box(Z,W,N), X!=Z, Y!=W.

% A cell is part of a row if it has the same X coordinate
row(X,Y,N) :- grid(X,Y,N).

% A cell is part of a column if it has the same Y coordinate
column(X,Y,N) :- grid(X,Y,N).

% A cell is part of a box if it has the same X and Y coordinates modulo 3
box(X,Y,N) :- grid(X,Y,N), X%3=BX, Y%3=BY, X>=BX, X<BX+3, Y>=BY, Y<BY+3.

% The initial values are specified in the input
grid(X,Y,N) :- initial(X,Y,N).
% It cannot be the case that two cells in the same row have the same number
:- row(X,Y,N), row(X,YY,N), Y != YY.

% It cannot be the case that two cells in the same column have the same number
:- column(X,Y,N), column(XX,Y,N), X != XX.

% It cannot be the case that two cells in the same box have the same number
:- box(X,Y,N), box(XX,YY,N), X/3 = XX/3, Y/3 = YY/3, X != XX, Y != YY.

% Show output predicate sudoku/3
#show sudoku/3.