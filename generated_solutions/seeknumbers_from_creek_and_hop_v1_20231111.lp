% generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% start at "white circle"
path(X,Y) :- start(X,Y).
% end at "black circle"
path(X,Y) :- end(X,Y).
% possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% move to adjacent cell
1 {path(X+DX,Y+DY) : dir(DX,DY), cell(X+DX,Y+DY)} 1 :- path(X,Y), not end(X,Y).
% count bends
bends(X,Y,N) :- path(X,Y), path(P,Q), path(R,S), N = #count{V,W : path(V,W), V!=X, W!=Y, V!=P, W!=Q, V!=R, W!=S, |V-X| + |W-Y| = 1, |V-P| + |W-Q| = 1, |V-R| + |W-S| = 1}.
% no bends at start or end
:- start(X,Y), bends(X,Y,N), N > 0.
:- end(X,Y), bends(X,Y,N), N > 0.
% at most two bends at any other cell
:- path(X,Y), not start(X,Y), not end(X,Y), bends(X,Y,N), N > 2.
% path must be continuous
:- path(X,Y), not start(X,Y), not end(X,Y), not 1 {path(P,Q) : dir(DX,DY), P=X+DX, Q=Y+DY, cell(P,Q)} 1.
% path must not cross itself
:- path(X,Y), path(P,Q), X=P, Y=Q, not start(X,Y), not end(P,Q).
% path must not go outside the grid
:- path(X,Y), not cell(X,Y).
% The path must start at the start point
:- not path(X,Y), start(X,Y).

% The path must end at the end point
:- not path(X,Y), end(X,Y).

% The path cannot go through the same cell twice
:- path(X,Y), path(X,Y).

% The path cannot bend more than once between two cells
:- bends(X,Y,N), N > 1.

% The path cannot bend at the start or end point
:- bends(X,Y,N), start(X,Y).
:- bends(X,Y,N), end(X,Y).

% The path must be continuous, i.e., every cell on the path (except for the start and end points) must be adjacent to exactly two other cells on the path
:- path(X,Y), not start(X,Y), not end(X,Y), #count{X1,Y1 : path(X1,Y1), adjacent(X,Y,X1,Y1)} != 2.

% The number of bends must be even
:- #count{X,Y,N : bends(X,Y,N)} mod 2 != 0.