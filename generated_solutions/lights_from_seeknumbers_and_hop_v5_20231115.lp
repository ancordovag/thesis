                    % generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).

% A cell can be illuminated if it is not blocked and there is a light in the same row or column
illuminated(X,Y) :- light(XX,Y), not blocked(X,Y), X!=XX.
illuminated(X,Y) :- light(X,YY), not blocked(X,Y), Y!=YY.

% A cell is blocked if it contains a number or is empty
blocked(X,Y) :- num(X,Y,_).
blocked(X,Y) :- empty(X,Y).

% A light can be placed in a cell if it is not blocked and not illuminated
light(X,Y) :- cell(X,Y), not blocked(X,Y), not illuminated(X,Y).

% A cell with a number 'n' must have exactly 'n' adjacent cells with lights
:- num(X,Y,N), #count{XX,YY : adjacent(X,Y,XX,YY), light(XX,YY)} != N.

% Two lights should not illuminate each other
:- light(X,Y), light(XX,YY), (X=XX; Y=YY), not blocked(X,Y), not blocked(XX,YY).

% Adjacent cells are horizontally or vertically next to each other
adjacent(X,Y,XX,Y) :- cell(X,Y), cell(XX,Y), X=XX+1.
adjacent(X,Y,XX,Y) :- cell(X,Y), cell(XX,Y), X=XX-1.
adjacent(X,Y,X,YY) :- cell(X,Y), cell(X,YY), Y=YY+1.
adjacent(X,Y,X,YY) :- cell(X,Y), cell(X,YY), Y=YY-1.                    % It cannot be the case that a cell is not illuminated
:- cell(X,Y), not illuminated(X,Y), not blocked(X,Y).
% It cannot be the case that a cell with a number 'n' does not have exactly 'n' adjacent cells with lights
:- num(X,Y,N), #count{XX,YY : adjacent(X,Y,XX,YY), light(XX,YY)} != N.
% It cannot be the case that two lights illuminate each other
:- light(X,Y), light(XX,YY), (X=XX; Y=YY), not blocked(X,Y), not blocked(XX,YY).