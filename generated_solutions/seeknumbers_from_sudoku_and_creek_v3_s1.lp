% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the starting cell of the path
start(X,Y) :- first(X,Y).

% Define the ending cell of the path
end(X,Y) :- final(X,Y).

% Define the number of bends between two cells
bends(X,Y,N) :- hint(X,Y,N).

% Define the path between two adjacent cells
path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), |X-XX| + |Y-YY| = 1.

% Define the path between the starting cell and the first cell with a number
path(X,Y,XX,YY) :- start(X,Y), hint(XX,YY,_), path(X,Y,XX,YY).

% Define the path between the first cell with a number and the next cell with a number or the ending cell
path(X,Y,XX,YY) :- hint(X,Y,_), hint(XX,YY,_), path(X,Y,XX,YY).

% Define the path between the ending cell and the final cell
path(X,Y,XX,YY) :- end(X,Y), final(XX,YY), path(X,Y,XX,YY).

% Show the output predicate path
#show path/4.
% It cannot be that a cell is visited and not in the path
:- visited(X,Y), not path(X,Y,_,_).

% It cannot be that a cell is in the path and not visited
:- path(X,Y,_,_), not visited(X,Y).

% It cannot be that a cell is in the path and not a cell
:- path(X,Y,_,_), not cell(X,Y).

% It cannot be that a cell is in the path and not a neighbour of another cell in the path
:- path(X,Y,_,_), not edge(_,_,X,Y,_).

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the same direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1!=D2.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=v.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=v, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
:- path(X,Y,_,_), edge(_,_,X,Y,D1), edge(_,_,_,_,D2), D1=D2, D1=h, D2=h.

% It cannot be that a cell is in the path and not a neighbour of another cell in the path in the opposite direction
