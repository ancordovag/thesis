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
bends(X,Y,XX,YY,N) :- start(X,Y), path(X,Y,XX,YY), hint(XX,YY,N).
bends(X,Y,XX,YY,N) :- path(X,Y,XX,YY), hint(XX,YY,N), end(XX,YY).

% Define the number of bends between two cells when there is no hint
bends(X,Y,XX,YY,0) :- path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(XX,YY,_).

% Define the number of bends between two cells when there is no hint and it is the ending cell of the path
bends(X,Y,XX,YY,0) :- path(X,Y,XX,YY), not hint(X,Y,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first and ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of bends between two cells when there is no hint and it is the first cell of the path and the ending cell of the path
bends(X,Y,XX,YY,0) :- start(X,Y), path(X,Y,XX,YY), not hint(X,Y,_), not hint(XX,YY,_), end(XX,YY).

% Define the number of
% The path starts at the cell marked with a white circle and ends at the cell marked with a black circle
:- not path(X,Y,_,_), first(X,Y).
:- not path(_,_,X,Y), final(X,Y).

% The path traverses each remaining cell of the square grid without ever crossing or intersecting itself
:- path(X,Y,XX,YY), path(X,Y,XX,YY), (X,Y) != (XX,YY).

% Between a cell with a (positive) number and the next cell with a number or the cell marked with a black circle, respectively, the path bends exactly as often as the number in the first cell indicates
:- hint(X,Y,N), path(X,Y,XX,YY), path(XX,YY,XXX,YYY), path(XXX,YYY,XXXX,YYYY), N != 0, (X,Y) != (XX,YY), (XX,YY) != (XXX,YYY), (XXX,YYY) != (XXXX,YYYY).

% The path does not bend between the cell marked with a white circle and the first cell with a number
:- first(X,Y), hint(XX,YY,_), path(X,Y,XX,YY), (X,Y) != (XX,YY).

% Every problem instance contains exactly one fact over first/2 and one fact over final/2
:- not first(_, _).
:- not final(_, _).

% Show output predicate path
#show path/4.