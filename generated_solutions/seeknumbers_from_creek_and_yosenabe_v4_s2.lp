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

% Define the number of bends between the starting cell and the first cell with a number
bends(X,Y,XX,YY,N) :- start(X,Y), hint(XX,YY,N), path(X,Y,XX,YY).

% Define the number of bends between a cell with a number and the next cell with a number or the ending cell
bends(X,Y,XX,YY,N) :- hint(X,Y,N), hint(XX,YY,_), path(X,Y,XX,YY).
bends(X,Y,XX,YY,N) :- hint(X,Y,N), end(XX,YY), path(X,Y,XX,YY).

% Define the number of bends between the starting cell and the ending cell
bends(X,Y,XX,YY,N) :- start(X,Y), end(XX,YY), path(X,Y,XX,YY), N = 0.

% Define the number of bends between two cells as 0 if there is no hint number between them
bends(X,Y,XX,YY,0) :- path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_).

% Show the path between cells
#show path/4.