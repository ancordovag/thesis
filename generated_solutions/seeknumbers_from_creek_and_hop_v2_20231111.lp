% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% If a cell is the first cell, it should have a path to an adjacent cell
path(X,Y,X+DX,Y+DY) :- first(X,Y), dir(DX,DY), cell(X+DX,Y+DY).

% If a cell is not the first or final cell and it has a hint, it should have a path to two different adjacent cells
path(X,Y,X+DX,Y+DY) :- hint(X,Y,N), dir(DX,DY), cell(X+DX,Y+DY), not first(X,Y), not final(X,Y).
path(X,Y,X+DX,Y+DY) :- hint(X,Y,N), dir(DX,DY), cell(X+DX,Y+DY), not first(X,Y), not final(X,Y), not path(X,Y,X+DX,Y+DY).

% If a cell is the final cell, it should have a path from an adjacent cell
path(X+DX,Y+DY,X,Y) :- final(X,Y), dir(DX,DY), cell(X+DX,Y+DY).

% If a cell is not the first or final cell and it does not have a hint, it should have a path to and from the same adjacent cell
path(X,Y,X+DX,Y+DY) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not first(X,Y), not final(X,Y), not hint(X,Y,N).
path(X+DX,Y+DY,X,Y) :- cell(X,Y), dir(DX,DY), cell(X+DX,Y+DY), not first(X,Y), not final(X,Y), not hint(X,Y,N).

% There should be no path between two cells if they are not adjacent
:- path(X,Y,XX,YY), not dir(XX-X,YY-Y).

% There should be no path between two cells if one of them is not a cell
:- path(X,Y,XX,YY), not cell(X,Y).
:- path(X,Y,XX,YY), not cell(XX,YY).

% Show output predicate path
#show path/4.
% The path must start at the first cell
:- not path(X,Y,_,_), first(X,Y).
% The path must end at the final cell
:- not path(_,_,X,Y), final(X,Y).
% The path must not cross or intersect itself
:- path(X,Y,XX,YY), path(XX,YY,X,Y).
% The path must traverse each cell of the grid
:- not path(_,_,X,Y), cell(X,Y).
% The path must not bend between the first cell and the first cell with a number
:- path(X,Y,XX,YY), first(X,Y), hint(XX,YY,_), path(XX,YY,XXX,YYY), XXX != X, YYY != Y.
% The path must bend exactly as often as the number in the cell indicates
{path(X,Y,XX,YY), path(XX,YY,XXX,YYY), XXX != X, YYY != Y} = N :- hint(X,Y,N).
% The path must not bend between a cell with a number and the next cell with a number or the final cell
:- path(X,Y,XX,YY), hint(X,Y,_), path(XX,YY,XXX,YYY), XXX != X, YYY != Y, hint(XXX,YYY,_).
:- path(X,Y,XX,YY), hint(X,Y,_), path(XX,YY,XXX,YYY), XXX != X, YYY != Y, final(XXX,YYY).