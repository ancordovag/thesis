                    % For each cell that is not a digit or empty, place a light
{ light(X,Y) } :- rows(R), cols(C), X=1..R, Y=1..C, not digit(X,Y,_), not empty(X,Y).

% A cell is illuminated if it has a light or if it is illuminated by another cell
illuminated(X,Y) :- light(X,Y).
illuminated(X,Y) :- light(XX,Y), X!=XX, not block(X,Y), not block(XX,Y).
illuminated(X,Y) :- light(X,YY), Y!=YY, not block(X,Y), not block(X,YY).

% A cell is blocked if it has a digit or is empty
block(X,Y) :- digit(X,Y,_).
block(X,Y) :- empty(X,Y).

% No two lights should illuminate each other
:- light(X,Y), light(XX,Y), X!=XX, not block(X,Y), not block(XX,Y).
:- light(X,Y), light(X,YY), Y!=YY, not block(X,Y), not block(X,YY).

% For each cell with a number n, there must be exactly n horizontally or vertically adjacent cells, each containing a light.
:- digit(X,Y,N), N != #count{XX,YY : light(XX,YY), adjacent(X,Y,XX,YY)}.

% Define adjacent cells
adjacent(X,Y,XX,Y) :- XX=X+1 ; XX=X-1.
adjacent(X,Y,X,YY) :- YY=Y+1 ; YY=Y-1.

% Show output predicate
#show light/2.