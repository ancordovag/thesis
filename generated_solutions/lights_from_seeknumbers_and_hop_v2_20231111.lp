                    % generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).

% A light can be placed in a cell if it is not a digit cell and not an empty cell
light(X,Y) :- cell(X,Y), not digit(X,Y,_), not empty(X,Y).

% A cell is illuminated if it has a light or if it is adjacent to an illuminated cell and there is no digit or empty cell between them
illuminated(X,Y) :- light(X,Y).
illuminated(X,Y) :- light(X,Y1), Y1<Y, not digit(X,Y2,_), Y2<Y, Y2>Y1, not empty(X,Y2).
illuminated(X,Y) :- light(X,Y1), Y1>Y, not digit(X,Y2,_), Y2>Y, Y2<Y1, not empty(X,Y2).
illuminated(X,Y) :- light(X1,Y), X1<X, not digit(X2,Y,_), X2<X, X2>X1, not empty(X2,Y).
illuminated(X,Y) :- light(X1,Y), X1>X, not digit(X2,Y,_), X2>X, X2<X1, not empty(X2,Y).

% A cell with a digit must have exactly that many adjacent cells with lights
:- digit(X,Y,D), #count{X1,Y1 : light(X1,Y1), abs(X1-X)+abs(Y1-Y)=1} != D.

% Two lights cannot illuminate each other
:- light(X1,Y1), light(X2,Y2), X1=X2, Y1<Y2, not digit(X1,Y,_), Y>Y1, Y<Y2, not empty(X1,Y).
:- light(X1,Y1), light(X2,Y2), X1=X2, Y1>Y2, not digit(X1,Y,_), Y<Y1, Y>Y2, not empty(X1,Y).
:- light(X1,Y1), light(X2,Y2), Y1=Y2, X1<X2, not digit(X,_,Y1), X>X1, X<X2, not empty(X,Y1).
:- light(X1,Y1), light(X2,Y2), Y1=Y2, X1>X2, not digit(X,_,Y1), X<X1, X>X2, not empty(X,Y1).

% Show output predicate
#show light/2.
                    % A light cannot be placed in a cell with a digit or an empty cell
:- light(X,Y), digit(X,Y,_).
:- light(X,Y), empty(X,Y).
% A light cannot be placed in a cell that is illuminated by another light
:- light(X,Y), light(XX,YY), (X=XX; Y=YY), not block(X,Y,XX,YY).
% Each cell with a digit must have exactly that many adjacent lights
{ light(XX,YY) : adjacent(X,Y,XX,YY) }=D :- digit(X,Y,D).
% Each cell that is not given must be illuminated by at least one light
1 { light(XX,YY) : illuminate(X,Y,XX,YY) } 1 :- not digit(X,Y,_), not empty(X,Y).
% Two lights cannot illuminate each other
:- light(X,Y), light(XX,YY), (X=XX; Y=YY), not block(X,Y,XX,YY).