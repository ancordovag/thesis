% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define a path between two adjacent cells
path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), |X-XX| + |Y-YY| = 1.

% Define the starting cell of the path
start(X,Y) :- first(X,Y).

% Define the ending cell of the path
end(X,Y) :- final(X,Y).

% Define the number of bends between two cells
bends(X,Y,XX,YY,N) :- hint(X,Y,N), path(X,Y,XX,YY).

% Define the number of bends between the starting cell and the next cell with a number or the ending cell
bends(X,Y,XX,YY,N) :- start(X,Y), hint(XX,YY,N), path(X,Y,XX,YY).
bends(X,Y,XX,YY,N) :- start(X,Y), end(XX,YY), path(X,Y,XX,YY).

% Define the number of bends between two cells other than the starting cell
bends(X,Y,XX,YY,N) :- path(X,Y,XX,YY), hint(X,Y,N), not start(X,Y).

% Define the number of bends between two cells other than the ending cell
bends(X,Y,XX,YY,N) :- path(X,Y,XX,YY), hint(XX,YY,N), not end(XX,YY).

% Define the number of bends between two cells other than the starting and ending cells
bends(X,Y,XX,YY,N) :- path(X,Y,XX,YY), not start(X,Y), not end(XX,YY), not hint(X,Y,_), not hint(XX,YY,_).

% Define the number of bends between the starting cell and the ending cell
bends(X,Y,XX,YY,N) :- start(X,Y), end(XX,YY), not hint(XX,YY,_), path(X,Y,XX,YY).

% It cannot be the case that a cell is visited more than once
:- path(X,Y,XX,YY), path(X,Y,XXX,YYY), (X,Y) != (XXX,YYY).

% Show the output predicate path
#show path/4.