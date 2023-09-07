% Rule to check if a number N can be placed in cell (X,Y) without violating the row, column, and box constraints
valid(X,Y,N) :- cell(X,Y), not row(X,Y,N), not column(X,Y,N), not box(X,Y,N).

% Rule to check if a number N can be placed in cell (X,Y) without violating the row constraint
row(X,Y,N) :- cell(X,Y), row(X,Y), not row(X,Y,N), not column(X,Y,N), not box(X,Y,N).

% Rule to check if a number N can be placed in cell (X,Y) without violating the column constraint
column(X,Y,N) :- cell(X,Y), column(X,Y), not row(X,Y,N), not column(X,Y,N), not box(X,Y,N).

% Rule to check if a number N can be placed in cell (X,Y) without violating the box constraint
box(X,Y,N) :- cell(X,Y), box(X,Y), not row(X,Y,N), not column(X,Y,N), not box(X,Y,N).
% The same number cannot appear twice in the same row
:- row(X,Y,N), row(X,YY,N), Y != YY.

% The same number cannot appear twice in the same column
:- column(X,Y,N), column(XX,Y,N), X != XX.

% The same number cannot appear twice in the same 3x3 box
:- box(X,Y,N), box(XX,YY,N), X/3 = XX/3, Y/3 = YY/3, X != XX, Y != YY.

% Show output predicates
#show row/3.
#show column/3.
#show box/3.