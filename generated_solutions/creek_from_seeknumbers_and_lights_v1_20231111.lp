                    % Define cells at the combination of a row X and a column Y
cell(X,Y) :- grid_rows(R), grid_columns(C), X = 1..R, Y = 1..C.

% Define predicate number/2 from number/3 that only shows the position of the number N
number(X,Y) :- number(X,Y,N).

% Define the possible distances from a cell, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).

% Define neighbors for each cell given a delta
neighbor(X1,Y1,X2,Y2) :- cell(X1,Y1), cell(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

% Generate minimum 0 predicate black for cell(X,Y) if this is not a number.  
{ black(X,Y) } :- cell(X,Y), not number(X,Y).

% Generate minimum 0 predicate white for cell(X,Y) if this is not a number.  
{ white(X,Y) } :- cell(X,Y), not number(X,Y).

% A cell cannot be both black and white
:- black(X,Y), white(X,Y).

% A cell with a number N must have exactly N black neighbors
:- number(X,Y,N), #count{X1,Y1 : neighbor(X,Y,X1,Y1), black(X1,Y1)} != N.

% A black cell cannot have a black neighbor
:- black(X,Y), neighbor(X,Y,X1,Y1), black(X1,Y1).

% A white cell must be part of a connected group of white cells
:- white(X,Y), not #count{X1,Y1 : neighbor(X,Y,X1,Y1), white(X1,Y1)} > 0.

% A group of white cells cannot contain a cycle
:- white(X,Y), #count{X1,Y1 : neighbor(X,Y,X1,Y1), white(X1,Y1)} > 2.

% A group of white cells cannot contain more than one numbered cell
:- white(X,Y), #count{X1,Y1 : neighbor(X,Y,X1,Y1), number(X1,Y1)} > 1.
% Cannot be the case that a cell is both black and white
:- black(X,Y), white(X,Y).
% Cannot be the case that a cell is both black and has a number
:- black(X,Y), number(X,Y,_).
% Cannot be the case that a cell is both white and has a number
:- white(X,Y), number(X,Y,_).
% A cell with a number N must have exactly N black neighbors
:- number(X1,Y1,N), not N { black(X2,Y2) : neighbor(X1,Y1,X2,Y2) } N.
% A black cell must not have a black neighbor
:- black(X1,Y1), black(X2,Y2), neighbor(X1,Y1,X2,Y2).
% A white cell must be connected to all other white cells
:- white(X1,Y1), white(X2,Y2), not path(X1,Y1,X2,Y2).

% Show output predicates
#show black/2.
#show white/2.
#show number/3.