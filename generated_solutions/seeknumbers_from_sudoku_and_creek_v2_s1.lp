% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the starting cell of the path
path(X,Y,XX,YY) :- first(X,Y), cell(XX,YY).

% Define the ending cell of the path
path(X,Y,XX,YY) :- final(X,Y), cell(XX,YY).

% Define a straight path between two adjacent cells
path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), |X-XX| + |Y-YY| = 1.

% Define a path with a bend between two adjacent cells
path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), hint(X,Y,N), |X-XX| + |Y-YY| = N.

% Show output predicate path
#show path/4.
% The path must start at the cell marked with a white circle
:- not path(X,Y,_,_), first(X,Y).

% The path must end at the cell marked with a black circle
:- not path(_,_,X,Y), final(X,Y).

% The path must traverse each remaining cell of the square grid without crossing or intersecting itself
:- path(X,Y,XX,YY), path(X,Y,XXX,YYY), path(XX,YY,XXX,YYY), (X != XX ; Y != YY), (X != XXX ; Y != YYY), (XX != XXX ; YY != YYY).

% Between a cell with a number and the next cell with a number or the cell marked with a black circle, the path must bend exactly as often as the number in the first cell indicates
:- hint(X,Y,N), path(X,Y,XX,YY), path(XX,YY,XXX,YYY), (N != 0), (X != XX ; Y != YY), (XX != XXX ; YY != YYY), (X = XX ; Y = YY ; XX = XXX ; YY = YYY).

% The path must not bend between the cell marked with a white circle and the first cell with a number
:- first(X,Y), hint(XX,YY,_), path(X,Y,XX,YY), (X != XX ; Y != YY).