% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% Define a path between two adjacent cells
path(X,Y,P,Q) :- cell(X,Y), cell(P,Q), |P-X| + |Q-Y| = 1.
% The path starts at the cell marked with a white circle
start(X,Y) :- white_circle(X,Y).
% The path ends at the cell marked with a black circle
end(X,Y) :- black_circle(X,Y).
% The path traverses each remaining cell of the square grid without crossing or intersecting itself
traverse(X,Y) :- cell(X,Y), not bend(X,Y).
% The path bends exactly as often as the number in the first cell indicates
bend(X,Y) :- number(X,Y,N), count_bends(X,Y,N).
% The path does not bend between the cell marked with a white circle and the first cell with a number
no_bend(X,Y) :- start(X,Y), not bend(X,Y).
% Count the number of bends in the path
count_bends(X,Y,N) :- count_bends(X,Y,0,N).
count_bends(X,Y,K,N) :- K < N, bend(X,Y), K1 = K + 1, path(X,Y,P,Q), count_bends(P,Q,K1,N).
count_bends(X,Y,K,N) :- K = N, not bend(X,Y).
% The path does not intersect itself
bad(X,Y) :- path(X,Y,P,Q), path(X,Y,P,Q), (X != P ; Y != Q).