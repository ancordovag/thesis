% Define the possible digits
digit(1..9).
% Define the cells of the grid
cell(1..9,1..9).
% Define the initial filled cells
filled(X,Y,D) :- initial(X,Y,D).
% Define the empty cells
empty(X,Y) :- cell(X,Y), not filled(X,Y,_).
% Define the rows
row(X,D) :- cell(X,_), digit(D).
% Define the columns
column(Y,D) :- cell(_,Y), digit(D).
% Define the sub-grids
subgrid(X,Y,D) :- cell(X,Y), digit(D), X1 = (X-1)//3*3+1, Y1 = (Y-1)//3*3+1, X2 = X1+2, Y2 = Y1+2, between(X1,X2,X), between(Y1,Y2,Y).
% Define the constraints for filled cells
:- filled(X,Y,D), filled(X,Y,D1), D != D1.
:- filled(X,Y,D), filled(X,Y1,D), Y != Y1.
:- filled(X,Y,D), filled(X1,Y,D), X != X1.
:- filled(X,Y,D), subgrid(X,Y,D), subgrid(X,Y1,D), Y != Y1.
:- filled(X,Y,D), subgrid(X,Y,D), subgrid(X1,Y,D), X != X1.
% Define the constraints for empty cells
:- empty(X,Y), filled(X,Y,D), filled(X,Y,D1), D = D1.
:- empty(X,Y), filled(X,Y,D), filled(X,Y1,D), Y = Y1.
:- empty(X,Y), filled(X,Y,D), filled(X1,Y,D), X = X1.
:- empty(X,Y), filled(X,Y,D), subgrid(X,Y,D), subgrid(X,Y1,D), Y = Y1.
:- empty(X,Y), filled(X,Y,D), subgrid(X,Y,D), subgrid(X1,Y,D), X = X1.% A cell cannot be filled with more than one digit
:- filled(X,Y,D), filled(X,Y,D1), D != D1.
% A digit cannot appear more than once in a row
:- row(X,D), row(X,D1), D != D1.
% A digit cannot appear more than once in a column
:- column(Y,D), column(Y,D1), D != D1.
% A digit cannot appear more than once in a sub-grid
:- subgrid(X,Y,D), subgrid(X,Y,D1), D != D1.