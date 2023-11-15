% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% Define a path between 2 cells when they are adjacent
path(X,Y,P,Q) :- cell(X,Y), cell(P,Q), |P-X| + |Q-Y| = 1.
% If a cell is not part of the path, it should be empty
empty(X,Y) :- not path(X,Y), cell(X,Y).
% If a cell is not empty, it should be part of the path
path(X,Y) :- not empty(X,Y), cell(X,Y).
% Define the start and end cells
start(X,Y) :- white_circle(X,Y).
end(X,Y) :- black_circle(X,Y).
% The path starts at the cell marked with a white circle
path(X,Y) :- start(X,Y).
% The path ends at the cell marked with a black circle
path(X,Y) :- end(X,Y).
% The path traverses each remaining cell of the square grid without ever crossing or intersecting itself
:- path(X,Y), path(P,Q), X != P, Y != Q.
% Between a cell with a (positive) number and the next cell with a number or the cell marked with a black circle, respectively, the path bends exactly as often as the number in the first cell indicates
bends(X,Y,N) :- cell(X,Y,N), N > 0, path(X,Y), path(P,Q), dir(DX,DY), X+DX=P, Y+DY=Q, N = #count{DX,DY : path(X+DX,Y+DY), dir(DX,DY)}.
% The path does not bend between the cell marked with a white circle and the first cell with a number
:- start(X,Y), path(P,Q), cell(P,Q,N), N > 0, dir(DX,DY), X+DX=P, Y+DY=Q, #count{DX,DY : path(X+DX,Y+DY), dir(DX,DY)} > 0.                    % The path cannot cross or intersect itself
:- path(X,Y), path(P,Q), X != P, Y != Q.
% The path cannot bend more times than the number in a cell
:- bends(X,Y,N), N < #count{DX,DY : path(X+DX,Y+DY), dir(DX,DY)}.
% The path cannot bend less times than the number in a cell
:- bends(X,Y,N), N > #count{DX,DY : path(X+DX,Y+DY), dir(DX,DY)}.
% The path cannot bend between the cell marked with a white circle and the first cell with a number
:- start(X,Y), path(P,Q), cell(P,Q,N), N > 0, dir(DX,DY), X+DX=P, Y+DY=Q, #count{DX,DY : path(X+DX,Y+DY), dir(DX,DY)} > 0.
% The path cannot start at a cell that is not marked with a white circle
:- path(X,Y), not start(X,Y).
% The path cannot end at a cell that is not marked with a black circle
:- path(X,Y), not end(X,Y).
% A cell cannot be part of the path and be empty at the same time
:- path(X,Y), empty(X,Y).
% A cell cannot be empty and be part of the path at the same time
:- empty(X,Y), path(X,Y).