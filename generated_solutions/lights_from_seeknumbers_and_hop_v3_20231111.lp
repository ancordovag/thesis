% generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).

% a cell is blocked if it contains a digit or is empty
blocked(X,Y) :- digit(X,Y,_).
blocked(X,Y) :- empty(X,Y).

% a cell is free if it is not blocked
free(X,Y) :- cell(X,Y), not blocked(X,Y).

% a light can be placed in a free cell
{ light(X,Y) } :- free(X,Y).

% a cell is illuminated if it contains a light
illuminated(X,Y) :- light(X,Y).

% a cell is illuminated if it is in the same row as a light and there are no blocked cells between them
illuminated(X,Y) :- light(XX,Y), X=1..XX-1, not blocked(X,Y), not blocked(X+1,Y).
illuminated(X,Y) :- light(XX,Y), X=XX+1..C, not blocked(X,Y), not blocked(X-1,Y).

% a cell is illuminated if it is in the same column as a light and there are no blocked cells between them
illuminated(X,Y) :- light(X,YY), Y=1..YY-1, not blocked(X,Y), not blocked(X,Y+1).
illuminated(X,Y) :- light(X,YY), Y=YY+1..R, not blocked(X,Y), not blocked(X,Y-1).

% all free cells must be illuminated
:- free(X,Y), not illuminated(X,Y).

% no two lights should illuminate each other
:- light(X,Y), light(XX,Y), X!=XX, not blocked(X,Y), not blocked(XX,Y).
:- light(X,Y), light(X,YY), Y!=YY, not blocked(X,Y), not blocked(X,YY).

% for each cell with a number 'n', there must be exactly 'n' horizontally or vertically adjacent cells, each containing a light
:- digit(X,Y,N), #count{XX,YY : light(XX,YY), (XX=X,YY=Y+1; XX=X,YY=Y-1; XX=X+1,YY=Y; XX=X-1,YY=Y)} != N.

% Show output predicate
#show light/2.
                    % A light cannot be placed in a cell that is already lighted
:- light(X,Y), lighted(X,Y).
% A digit cell must have exactly N lights in its neighboring cells
:- digit(X,Y,N), N != { light(X1,Y1) : neighbor(X,Y,X1,Y1,_,_) }.
% A cell must be lighted
:- field(X,Y), not digit(X,Y), not lighted(X,Y).

#show light/2.