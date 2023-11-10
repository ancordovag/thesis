% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the first cell of the path
path(X,Y,XX,YY) :- first(X,Y), cell(XX,YY), (X,Y) != (XX,YY), dir(DX,DY), (DX,DY) != (0,0), (X+DX,Y+DY) = (XX,YY).

% Define the final cell of the path
path(X,Y,XX,YY) :- final(X,Y), cell(XX,YY), (X,Y) != (XX,YY), dir(DX,DY), (DX,DY) != (0,0), (X+DX,Y+DY) = (XX,YY).

% Define the path between two cells with a hint number
path(X,Y,XX,YY) :- hint(X,Y,N), cell(XX,YY), (X,Y) != (XX,YY), dir(DX,DY), (DX,DY) != (0,0), (X+DX,Y+DY) = (XX,YY), bend(X,Y,XX,YY,N).

% Define the path between two generic cells
path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), (X,Y) != (XX,YY), dir(DX,DY), (DX,DY) != (0,0), (X+DX,Y+DY) = (XX,YY).

% Define the number of bends between two cells with a hint number
bend(X,Y,XX,YY,N) :- hint(X,Y,N), cell(XX,YY), (X,Y) != (XX,YY), countbend(X,Y,XX,YY,C), C = N.

% Define the number of bends between two generic cells
countbend(X,Y,XX,YY,C) :- cell(X,Y), cell(XX,YY), (X,Y) != (XX,YY), dir(DX,DY), (DX,DY) != (0,0), (X+DX,Y+DY) = (XX,YY), C = #count{dir(DX,DY) : dir(DX,DY)}.

% Show output predicate path
#show path/4.
% The path starts at the cell marked with a white circle
:- not start(X,Y), white(X,Y).

% The path ends at the cell marked with a black circle
:- not end(X,Y), black(X,Y).

% The path traverses each remaining cell of the square grid without crossing or intersecting itself
:- path(X,Y,XX,YY), path(XX,YY,X,Y), (X != XX ; Y != YY).

% Between a cell with a number and the next cell with a number or the cell marked with a black circle, the path bends exactly as often as the number in the first cell indicates
:- hint(X,Y,N), path(X,Y,XX,YY), path(XX,YY,XXX,YYY), path(XXX,YYY,XXXX,YYYY), (N != 0 ; (X == XX ; Y == YY)), (N != 1 ; (XX == XXX ; YY == YYY)), (N != 2 ; (XXX == XXXX ; YYY == YYYY)).

% The path does not bend between the cell marked with a white circle and the first cell with a number
:- first(X,Y), hint(XX,YY,_), path(X,Y,XX,YY), (X != XX ; Y != YY).