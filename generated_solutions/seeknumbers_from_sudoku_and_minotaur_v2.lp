% The first cell of the path is a valid grid cell
first(X,Y) :- grid(X,Y).

% The final cell of the path is a valid grid cell
final(X,Y) :- grid(X,Y).

% The hint cell is a valid grid cell
hint(X,Y,N) :- grid(X,Y).

% The first cell cannot be the same as the final cell
:- first(X,Y), final(X,Y).

% The first cell cannot be the same as the hint cell
:- first(X,Y), hint(X,Y,_).

% The final cell cannot be the same as the hint cell
:- final(X,Y), hint(X,Y,_).

% The hint cell cannot be the same as any other hint cell
:- hint(X1,Y1,_), hint(X2,Y2,_), (X1,Y1) != (X2,Y2).

% The hint cell cannot be the same as the first cell
:- hint(X,Y,_), first(X,Y).

% The hint cell cannot be the same as the final cell
:- hint(X,Y,_), final(X,Y).
% The first cell of the path must be in the grid
:- first(X,Y), not grid(X,Y).

% The final cell of the path must be in the grid
:- final(X,Y), not grid(X,Y).

% The hint cell must be in the grid
:- hint(X,Y,N), not grid(X,Y).

% The first cell of the path cannot contain a hint number
:- first(X,Y), hint(X,Y,N).

% The final cell of the path cannot contain a hint number
:- final(X,Y), hint(X,Y,N).

% The hint cell must contain a hint number
:- hint(X,Y,N), not hint(X,Y,_).

% The hint number in a cell must be between 1 and R*C
:- hint(X,Y,N), N < 1.
:- hint(X,Y,N), N > R*C.