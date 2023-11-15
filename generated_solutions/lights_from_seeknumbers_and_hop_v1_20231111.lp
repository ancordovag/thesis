                    % generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% place lights
1 { light(X,Y) : cell(X,Y) } 1 :- number(X,Y,_).
% illuminate cells
illuminated(X,Y) :- light(X,Y).
illuminated(X,Y) :- light(X,Y1), Y1 < Y, not obstacle(X,Y2), Y2=Y1..Y-1.
illuminated(X,Y) :- light(X,Y1), Y1 > Y, not obstacle(X,Y2), Y2=Y+1..Y1-1.
illuminated(X,Y) :- light(X1,Y), X1 < X, not obstacle(X2,Y), X2=X1..X-1.
illuminated(X,Y) :- light(X1,Y), X1 > X, not obstacle(X2,Y), X2=X+1..X1-1.
% place numbers
number(X,Y,N) :- light(X,Y), N = #count { X1,Y1 : illuminated(X1,Y1), not light(X1,Y1) }.
% show output predicate
#show light/2.
#show number/3.
% A light cannot be placed in a cell that already has a number
:- light(X,Y), number(X,Y,_).
% A cell with a number must be illuminated by exactly that number of lights
{ light(XX,YY) : around(X,Y,XX,YY) } = N :- number(X,Y,N).
% A light illuminates all cells in the same row to the right until it reaches a cell with a number or the edge of the grid
illuminated(XX,Y) :- light(X,Y), row(X,XX), not number(_,Y,_), not edge(XX,Y).
% A light illuminates all cells in the same row to the left until it reaches a cell with a number or the edge of the grid
illuminated(XX,Y) :- light(X,Y), row(XX,X), not number(_,Y,_), not edge(XX,Y).
% A light illuminates all cells in the same column up until it reaches a cell with a number or the edge of the grid
illuminated(X,YY) :- light(X,Y), column(Y,YY), not number(X,_,_), not edge(X,YY).
% A light illuminates all cells in the same column down until it reaches a cell with a number or the edge of the grid
illuminated(X,YY) :- light(X,Y), column(YY,Y), not number(X,_,_), not edge(X,YY).
% A cell cannot be illuminated by more than one light
:- illuminated(X,Y), 1 < { light(XX,YY) : around(X,Y,XX,YY) }.
% All cells must be illuminated
:- cell(X,Y), not illuminated(X,Y).