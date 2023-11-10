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

% Define the number of bends between a cell with a number and the ending cell
bends(X,Y,XX,YY,N) :- hint(X,Y,N), end(XX,YY), path(X,Y,XX,YY).

% Define the number of bends between two cells that are not the starting or ending cell
bends(X,Y,XX,YY,N) :- hint(X,Y,N), path(X,Y,XX,YY).

% Show the output predicate path
#show path/4.
% The path starts at the cell marked with a white circle and ends at the cell marked with a black circle
:- not path(X,Y,_,_), first(X,Y).
:- not path(_,_,X,Y), final(X,Y).

% The path traverses each remaining cell of the square grid without ever crossing or intersecting itself
:- path(X,Y,XX,YY), path(X,Y,XX,YY), (X,Y) != (XX,YY).

% Between a cell with a (positive) number and the next cell with a number or the cell marked with a black circle, respectively, the path bends exactly as often as the number in the first cell indicates
:- hint(X,Y,N), path(X,Y,XX,YY), path(XX,YY,XXX,YYY), path(XXX,YYY,XXXX,YYYY), N != 0, not bend(X,Y,XX,YY,XXX,YYY,XXXX,YYYY).
:- hint(X,Y,N), path(X,Y,XX,YY), path(XX,YY,XXX,YYY), path(XXX,YYY,XXXX,YYYY), N == 0, bend(X,Y,XX,YY,XXX,YYY,XXXX,YYYY).

% The path does not bend between the cell marked with a white circle and the first cell with a number
:- first(X,Y), hint(XX,YY,_), path(X,Y,XX,YY), bend(X,Y,XX,YY,_,_,_,_).

% Every problem instance contains exactly one fact over first/2 and one fact over final/2
:- not first(_, _).
:- not final(_, _).