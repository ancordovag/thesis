                    % Initial parameters
direction(-1,0). direction(1,0). direction(0,-1). direction(0,1). % Possible directions: up, down, left, right

% The path starts at the cell marked with a white circle
path(X,Y,0) :- start(X,Y).
% The path continues from a cell to an adjacent cell
1 { path(X+DX,Y+DY,S+1) : direction(DX,DY), cell(X+DX,Y+DY) } 1 :- path(X,Y,S), not numsteps(S).
% The path ends at the cell marked with a black circle
:- final(X,Y), not path(X,Y,S), numsteps(S).

% The path does not bend between the cell marked with a white circle and the first cell with a number
:- path(X,Y,S), number(X,Y,N), S < N.

% Between a cell with a (positive) number and the next cell with a number or the cell marked with a black circle, respectively, the path bends exactly as often as the number in the first cell indicates
bend(S) :- path(X,Y,S), path(X+DX,Y+DY,S+1), path(X+DX+DX2,Y+DY+DY2,S+2), direction(DX,DY), direction(DX2,DY2), DX != DX2, DY != DY2.
:- number(X,Y,N), path(X,Y,S), bend(S1), S < S1, S1 < S+N.
:- number(X,Y,N), path(X,Y,S), not bend(S+N-1).

% The path traverses each remaining cell of the square grid without ever crossing or intersecting itself
:- cell(X,Y), not path(X,Y,S), numsteps(S).
:- path(X,Y,S1), path(X,Y,S2), S1 != S2.

% Show output predicate
#show path/3.