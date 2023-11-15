% generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).

% a light can be placed in any cell that is not initially given
{ light(X,Y) } :- cell(X,Y), not digit(X,Y,_), not empty(X,Y).

% a cell is illuminated if it has a light or if it is adjacent to an illuminated cell that is not blocked by a given cell
illuminated(X,Y) :- light(X,Y).
illuminated(X,Y) :- light(X,Y1), Y1<Y, not empty(X,Y1), not digit(X,Y1,_), not illuminated(X,Y-1).
illuminated(X,Y) :- light(X,Y1), Y1>Y, not empty(X,Y1), not digit(X,Y1,_), not illuminated(X,Y+1).
illuminated(X,Y) :- light(X1,Y), X1<X, not empty(X1,Y), not digit(X1,Y,_), not illuminated(X-1,Y).
illuminated(X,Y) :- light(X1,Y), X1>X, not empty(X1,Y), not digit(X1,Y,_), not illuminated(X+1,Y).

% no two lights should illuminate each other
:- light(X,Y), light(X1,Y), X1>X, not empty(X1,Y), not digit(X1,Y,_), not illuminated(X+1,Y).
:- light(X,Y), light(X,Y1), Y1>Y, not empty(X,Y1), not digit(X,Y1,_), not illuminated(X,Y+1).

% for each cell with a number 'n', there must be exactly 'n' horizontally or vertically adjacent cells, each containing a light
:- digit(X,Y,N), N != #count{ X1,Y1 : light(X1,Y1), abs(X1-X)+abs(Y1-Y)=1 }.

% every cell that is not initially given must be illuminated
:- cell(X,Y), not digit(X,Y,_), not empty(X,Y), not illuminated(X,Y).

%Show output predicate
#show light/2.