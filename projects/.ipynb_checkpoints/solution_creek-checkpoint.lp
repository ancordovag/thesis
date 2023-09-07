%% Header
plus(0,0). plus(0,1). plus(1,0). plus(1,1).
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

%% Generation
% Generate N black cells surrounding the hint
N {black(X+A,Y+B) : cell(X+A,Y+B), plus(A,B)} N :- hint(X,Y,N).
% Generate a path between white cells that are neighbors
path(X,Y,P,Q) :- white(X,Y), white(P,Q), |P-X| + |Q-Y| = 1.
% If there is a path between a visited cell and a neighbor, that neighbor is also visited
visit(X+DX,Y+DY) :- visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
% If there is a path between the first visited cell and its neighbor, the neighbor is visited
visit(X+DX,Y+DY) :- first_visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
% A cell is white is not marked as black
white(X,Y) :- not black(X,Y), cell(X,Y).
% A cell is black is not marked as black
black(X,Y) :- not white(X,Y), cell(X,Y).
% Finding the minimum X of white
mini_x(M) :- M = #min{X,Y : white(X,Y)}.
% Finding the minimum Y of the withe with the minimum X
mini_y(N) :- N = #min{Y : white(M,Y), mini_x(M)}.
% Define first visited cell
first_visit(M,N) :- mini_x(M), mini_y(N).

%% Test
% all white cells are visited
:- not visit(X,Y), white(X,Y).