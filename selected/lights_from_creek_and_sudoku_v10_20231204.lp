                    % Define the possible positions for a light
row(1..R) :- rows(R).
column(1..C) :- cols(C).
cell(X,Y) :- row(X), column(Y).

% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Place a light in a cell if it is not initially given
light(X,Y) :- cell(X,Y), not digit(X,Y,_), not empty(X,Y).

% A cell is illuminated if it has a light
illuminated(X,Y) :- light(X,Y).
% A cell is illuminated if it is in the same row or column as a light and there are no digits or empty cells between them
illuminated(X,Y) :- light(X1,Y1), dir(DX,DY), X = X1 + DX, Y = Y1 + DY, not digit(X,Y,_), not empty(X,Y), illuminated(X-DX,Y-DY).

% No two lights should illuminate each other
:- light(X,Y), illuminated(X,Y).

% For each cell with a number n, there must be exactly n horizontally or vertically adjacent cells, each containing a light
:- digit(X,Y,N), N != #count{DX,DY : light(X+DX,Y+DY), dir(DX,DY)}.

% Show output predicate
#show light/2.