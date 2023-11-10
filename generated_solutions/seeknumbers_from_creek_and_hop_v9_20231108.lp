% Generate cells
cell(X,Y) :- X=1..N, Y=1..N.
% The path starts at the cell marked with a white circle
path(X,Y,XX,YY) :- first(X,Y), cell(XX,YY).
% The path ends at the cell marked with a black circle
path(X,Y,XX,YY) :- final(X,Y), cell(XX,YY).
% The path traverses each remaining cell of the square grid without crossing or intersecting itself
{ path(X,Y,XX,YY) } :- cell(X,Y), cell(XX,YY), (X,Y) != (XX,YY).
% Between a cell with a number and the next cell with a number or the cell marked with a black circle, the path bends exactly as often as the number in the first cell indicates
{ path(X,Y,XX,YY) } :- hint(X,Y,N), cell(XX,YY), bend(X,Y,XX,YY,N).
% The path does not bend between the cell marked with a white circle and the first cell with a number
{ path(X,Y,XX,YY) } :- first(X,Y), hint(XX,YY,_), (X,Y) != (XX,YY), not bend(X,Y,XX,YY,_).

bend(X,Y,XX,YY,N) :- count_bends(X,Y,XX,YY,N,0).

count_bends(X,Y,XX,YY,N,C) :- N = 0, C = 0.
count_bends(X,Y,XX,YY,N,C) :- N > 0, C = N, (X = XX ; Y = YY).
count_bends(X,Y,XX,YY,N,C) :- N > 0, C < N, (X != XX ; Y != YY), C1 = C + 1, count_bends(X,Y,XX,YY,N,C1).