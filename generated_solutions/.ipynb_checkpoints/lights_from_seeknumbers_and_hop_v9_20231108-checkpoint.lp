% Generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% Generate lights in non-given cells
{ light(X,Y) } :- cell(X,Y), not digit(X,Y,_), not empty(X,Y).
% Generate lights in cells adjacent to cells with a number
{ light(X+A,Y+B) } :- digit(X,Y,N), cell(X+A,Y+B), |A|+|B|=1, N > 0.
% Generate lights in cells adjacent to cells with a light
{ light(X+A,Y+B) } :- light(X,Y), cell(X+A,Y+B), |A|+|B|=1.
% Generate lights in cells adjacent to cells with a light and a number
{ light(X+A,Y+B) } :- digit(X,Y,N), light(X,Y), cell(X+A,Y+B), |A|+|B|=1, N > 0.