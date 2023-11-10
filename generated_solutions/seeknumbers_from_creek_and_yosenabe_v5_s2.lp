% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% Define a path between two adjacent cells
path(X,Y,P,Q) :- cell(X,Y), cell(P,Q), |P-X| + |Q-Y| = 1.
% Define the starting cell
start(X,Y) :- first(X,Y), cell(X,Y).
% Define the final cell
end(X,Y) :- final(X,Y), cell(X,Y).
% Define a cell with a number
number(X,Y) :- hint(X,Y,_), cell(X,Y).
% Define the number of bends between two cells
bends(X,Y,P,Q,N) :- hint(X,Y,N), path(X,Y,P,Q).
% Define the number of bends between the starting cell and the first cell with a number
bends_start(X,Y,N) :- start(X,Y), number(P,Q), bends(X,Y,P,Q,N).
% Define the number of bends between a cell with a number and the next cell with a number or the final cell
bends_number(X,Y,P,Q,N) :- number(X,Y), (number(P,Q); end(P,Q)), bends(X,Y,P,Q,N).
% Define the number of bends between the starting cell and the final cell
bends_start_end(X,Y,N) :- start(X,Y), end(P,Q), bends(X,Y,P,Q,N).% The starting cell must be visited
:- not visit(X,Y), start(X,Y).
% The final cell must be visited
:- not visit(X,Y), end(X,Y).
% A cell with a number must be visited
:- not visit(X,Y), number(X,Y).
% The path cannot cross or intersect itself
:- visit(X,Y), visit(X,Y), (X,Y) != (X',Y').
% The path must bend exactly as many times as indicated by the number in a cell
:- bends(X,Y,P,Q,N), |P-X| + |Q-Y| != N.
% The path must bend between the starting cell and the first cell with a number
:- bends_start(X,Y,N), N != 0.
% The path must bend between a cell with a number and the next cell with a number or the final cell
:- bends_number(X,Y,P,Q,N), N != 0.
% The path must bend between the starting cell and the final cell
:- bends_start_end(X,Y,N), N != 0.