% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define a path between 2 cells when they are adjacent
path(X,Y,X+DX,Y+DY) :- cell(X,Y), cell(X+DX,Y+DY), dir(DX,DY).

% Define a path from the first cell to an adjacent cell
path(X,Y,X+DX,Y+DY) :- first(X,Y), cell(X+DX,Y+DY), dir(DX,DY).

% Define a path from a cell to an adjacent cell if there is a path to the first cell and the number of bends is correct
path(X,Y,X+DX,Y+DY) :- path(P,Q,X,Y), hint(X,Y,N), #count{D1,D2 : path(X,Y,X+D1,Y+D2)} = N, dir(DX,DY).

% Define a path from a cell to the final cell if there is a path to the first cell and the number of bends is correct
path(X,Y,FX,FY) :- path(P,Q,X,Y), hint(X,Y,N), #count{D1,D2 : path(X,Y,X+D1,Y+D2)} = N, final(FX,FY).

% It cannot be that a cell is not on the path
:- not path(X,Y,_,_), cell(X,Y).

% It cannot be that a cell is on the path more than once
:- path(X,Y,P,Q), path(X,Y,R,S), P != R, Q != S.

% Show output predicate
#show path/4.