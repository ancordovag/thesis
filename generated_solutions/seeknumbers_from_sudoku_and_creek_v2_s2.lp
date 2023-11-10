% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define a path between two adjacent cells
path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), |X-XX| + |Y-YY| = 1.

% Define the starting cell of the path
start(X,Y) :- first(X,Y), cell(X,Y).

% Define the ending cell of the path
end(X,Y) :- final(X,Y), cell(X,Y).

% Define the number of bends in the path between two cells
bends(X,Y,XX,YY,N) :- hint(X,Y,N), path(X,Y,XX,YY).

% Define the number of bends in the path between the starting cell and the first cell with a number
bends_start(X,Y,N) :- start(X,Y), hint(X,Y,N).

% Define the number of bends in the path between the starting cell and the first cell with a number
bends_end(X,Y,N) :- end(X,Y), hint(X,Y,N).

% Define the number of bends in the path between two cells when there is no hint
bends(X,Y,XX,YY,0) :- path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_).

% Show the output predicate path
#show path/4.
% The path starts at the first cell
path(X,Y,XX,YY) :- first(X,Y), cell(XX,YY).

% The path ends at the final cell
path(X,Y,XX,YY) :- final(X,Y), cell(XX,YY).

% The path goes from one cell to an adjacent cell horizontally or vertically
path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), (X = XX ; Y = YY), abs(X-XX) + abs(Y-YY) = 1.

% The path does not cross or intersect itself
:- path(X,Y,XX,YY), path(XX,YY,X,Y), (X != XX ; Y != YY).

% The path bends exactly as often as the hint number indicates
:- hint(X,Y,N), path(X,Y,XX,YY), path(XX,YY,XXX,YYY), path(XXX,YYY,XXXX,YYYY), (X != XX ; Y != YY), (XX != XXX ; YY != YYY), (XXX != XXXX ; YYY != YYYY), (N != 0), (N != 1), (N != 2), (N != 3), (N != 4).

% The path does not bend between the first cell and the first cell with a number
:- first(X,Y), hint(XX,YY,_), path(X,Y,XX,YY), (X != XX ; Y != YY).

% The path bends between a cell with a number and the next cell with a number or the final cell
:- hint(X,Y,N), path(X,Y,XX,YY), hint(XXX,YYY,_), path(XX,YY,XXX,YYY), (X != XX ; Y != YY), (XX != XXX ; YY != YYY), (N != 0), (N != 1), (N != 2), (N != 3), (N != 4), (XXX != 3 ; YYY != 3).