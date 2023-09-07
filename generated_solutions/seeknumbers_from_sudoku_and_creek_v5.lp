% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the starting cell
visited(X,Y) :- first(X,Y).

% Define the ending cell
visited(X,Y) :- final(X,Y).

% Define the path between two adjacent cells
path(X,Y,XX,YY) :- visited(X,Y), visited(XX,YY), |X-XX| + |Y-YY| = 1.

% Define the number of bends between two cells
bends(X,Y,XX,YY,N) :- path(X,Y,XX,YY), hint(X,Y,N).

% Define the number of bends between the starting cell and the first cell with a number
bends(X,Y,XX,YY,N) :- first(X,Y), path(X,Y,XX,YY), hint(XX,YY,N).

% Define the number of bends between a cell with a number and the next cell with a number or the ending cell
bends(X,Y,XX,YY,N) :- hint(X,Y,N), path(X,Y,XX,YY), (hint(XX,YY,_) ; final(XX,YY)).

% Define the number of bends between the starting cell and the ending cell
bends(X,Y,XX,YY,N) :- first(X,Y), final(XX,YY), path(X,Y,XX,YY).

% Define the constraint that the path should not cross or intersect itself
:- path(X,Y,XX,YY), path(XXX,YYY,XX,YY), path(X,Y,XXX,YYY), (X != XXX ; Y != YYY).

% Define the constraint that all cells should be visited
:- cell(X,Y), not visited(X,Y).

% Define the constraint that there should be a path between the starting cell and the ending cell
:- not visited(X,Y), first(X,Y).
:- not visited(X,Y), final(X,Y).

% Define the constraint that the number of bends should match the number in the cell
:- hint(X,Y,N), bends(X,Y,XX,YY,M), N != M.

% Define the constraint that there should be exactly one fact over first/2 and one fact over final/2
1 { first(X,Y) } 1 :- cell(X,Y).
1 { final(X,Y) } 1 :- cell(X,Y).

% Show the goal predicates
#show visited/2.
#show path/4.
% The path should start at the cell marked with a white circle
:- not path(X,Y,_,_), first(X,Y).

% The path should end at the cell marked with a black circle
:- not path(_,_,X,Y), final(X,Y).

% The path should traverse each remaining cell of the square grid without crossing or intersecting itself
:- path(X,Y,XX,YY), path(X,Y,XX,YY), (X,Y) != (XX,YY).

% Between a cell with a number and the next cell with a number or the cell marked with a black circle, the path should bend exactly as often as the number in the first cell indicates
:- path(X,Y,XX,YY), number(X,Y,N), count_bends(X,Y,XX,YY,C), N != C.

% The path should not bend between the cell marked with a white circle and the first cell with a number
:- path(X,Y,XX,YY), first(X,Y), number(XX,YY,_), count_bends(X,Y,XX,YY,C), C != 0.

% Every problem instance should contain exactly one fact over first/2 and one fact over final/2
:- not first(_,_) ; not final(_,_) ; #count{X,Y : first(X,Y)} != 1 ; #count{X,Y : final(X,Y)} != 1.