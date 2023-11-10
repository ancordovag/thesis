% All possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% A cell is blackened if it is a hint
black(X,Y) :- hint(X,Y,_).

% A cell is blackened if it has N blackened neighbors
black(X,Y) :- cell(X,Y), hint(X,Y,N), countblack(X,Y,N).

% Count the number of blackened neighbors of a cell
countblack(X,Y,N) :- N = #count{black(X+DX,Y+DY) : dir(DX,DY)}, hint(X,Y,_).

% All white cells must be connected
connected(X,Y) :- cell(X,Y), not black(X,Y), not isolated(X,Y).
isolated(X,Y) :- cell(X,Y), not black(X,Y), not connected(X,Y), not connected(X+1,Y), not connected(X,Y+1), not connected(X+1,Y+1).

#show black/2.
% For each hint, the number of blackened cells adjacent to the hint cell must be equal to the hint number
:- hint(X,Y,N), N != #count{black(X+A,Y+B) : cell(X+A,Y+B), plus(A,B)}.