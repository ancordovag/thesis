% Define all possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define a path between two cells when they are adjacent
path(X,Y,P,Q) :- cell(X,Y), cell(P,Q), |P-X| + |Q-Y| = 1.

% Define a move from one cell to another in a specific direction
move(X,Y,P,Q,DX,DY) :- path(X,Y,P,Q), dir(DX,DY).

% Define a target cell for a number in an area
target(X,Y,P,Q) :- number(X,Y,N), area(P,Q,A), goal(A,G), G = N, move(X,Y,P,Q,DX,DY), not move(X,Y,P+DX,Q+DY,DX,DY).

% Show output predicate target
#show target/4.
% No two numbers can be moved to the same target cell
:- target(X,Y,I,J), target(X',Y',I,J), number(X,Y,N), number(X',Y',N).

% Only one number can be moved to each target cell
:- target(X,Y,I,J), target(X',Y',I,J), number(X,Y,N), number(X',Y',M), N != M.

% Each gray area must have at least one moved number
:- area(I,J,A), not target(X,Y,I,J), number(X,Y,N), area(I,J,A).

% The sum of the moved numbers in each gray area must be equal to the goal
:- target(X,Y,I,J), number(X,Y,N), area(I,J,A), not total(A,S), goal(A,V).
:- target(X,Y,I,J), number(X,Y,N), area(I,J,A), total(A,S), goal(A,V), S != V.