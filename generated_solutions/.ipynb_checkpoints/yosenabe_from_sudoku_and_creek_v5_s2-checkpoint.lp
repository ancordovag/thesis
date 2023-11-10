% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% Define a path between 2 cells when they are adjacent
path(X,Y,P,Q) :- cell(X,Y), cell(P,Q), |P-X| + |Q-Y| = 1.
% If a cell is not gray, it should be white
white(X,Y) :- not gray(X,Y), cell(X,Y).
% If a cell is not white, it should be gray
gray(X,Y) :- not white(X,Y), cell(X,Y).
% Find the minimum column containing a gray cell 
mini_x(M) :- M = #min{X,Y : gray(X,Y)}.
% Find the minimum row containing a gray cell in the minimum column containing a gray cell
mini_y(N) :- N = #min{Y : gray(M,Y), mini_x(M)}.
% Declare the first visit as the minimum column and minimum row
first_visit(M,N) :- mini_x(M), mini_y(N).
% Declare a cell as visited if there is an incoming path from the first visited cell
visit(X+DX,Y+DY) :- first_visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
% Declare a cell as visited if there is an incoming path from a already visited cell
visit(X+DX,Y+DY) :- visit(X,Y), path(X,Y,X+DX,Y+DY), dir(DX,DY).
% Define cells to be moved among the subset of possible cells, when there is a number in cell X,Y,
moved(X+A,Y+B) :- cell(X+A,Y+B), dir(A,B), number(X,Y,_).
% Define the sum of the numbers in an area to be equal to the goal number
:- area(X,Y,G), goal(X,G), not #sum{N : moved(X,Y), number(X,Y,N)} = G.% It cannot be that a white cell is not visited
:- not visit(X,Y), white(X,Y).

% It cannot be that two moved numbers cross or meet at any grid cell
:- moved(X,Y), moved(X',Y'), path(X,Y,X',Y').

% Each gray area must be populated with at least one moved number
:- area(X,Y,_), not moved(X,Y).

% The sum of the numbers in an area must be equal to the goal number
:- area(X,Y,G), goal(X,G), not #sum{N : moved(X,Y), number(X,Y,N)} = G.