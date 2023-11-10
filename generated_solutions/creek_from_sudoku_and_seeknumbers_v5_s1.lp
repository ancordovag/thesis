% Initial parameters
row(1..R).
column(1..C).
cell(X,Y) :- row(X), column(Y).

% A cell is blackened if it is not white
blackened(X,Y) :- cell(X,Y), not white(X,Y).

% A cell is white if it is not blackened
white(X,Y) :- cell(X,Y), not blackened(X,Y).

% A cell is connected to another cell if they are both white and there is a path between them
connected(X1,Y1,X2,Y2) :- white(X1,Y1), white(X2,Y2), path(X1,Y1,X2,Y2).

% The number in a circle indicates how many of the 4 adjacent cells must be blackened
count(X,Y,N) :- circle(X,Y,N), blackened(X1,Y1), neighbour(X,Y,X1,Y1).

% All white cells must form an orthogonally connected area
:- white(X1,Y1), white(X2,Y2), not connected(X1,Y1,X2,Y2).% It cannot be the case that a cell is both blackened and white
:- blackened(X,Y), white(X,Y).

% It cannot be the case that a cell is blackened and there is a number in a circle indicating that it should be white
:- blackened(X,Y), circle(X,Y,N), N>0.

% It cannot be the case that a cell is white and there is a number in a circle indicating that it should be blackened
:- white(X,Y), circle(X,Y,N), N=0.

% It cannot be the case that a cell is blackened and there is not the specified number of blackened cells adjacent to it
:- blackened(X,Y), circle(X,Y,N), count(X,Y,M), N!=M.

% It cannot be the case that a cell is white and there is not the specified number of blackened cells adjacent to it
:- white(X,Y), circle(X,Y,N), count(X,Y,M), N!=M.

% It cannot be the case that a cell is blackened and it is not adjacent to any white cell
:- blackened(X,Y), not connected(X,Y,X1,Y1), white(X1,Y1).

% It cannot be the case that a cell is white and it is adjacent to a blackened cell
:- white(X,Y), connected(X,Y,X1,Y1), blackened(X1,Y1).