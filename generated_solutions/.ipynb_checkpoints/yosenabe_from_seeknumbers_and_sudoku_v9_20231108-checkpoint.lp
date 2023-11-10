% Define the neighbours of a cell X,Y
neighbour(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), |XX-X| + |YY-Y| = 1.

% Define the possible targets for a number in a cell X,Y
target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), area(P,Q,A), number(X,Y,N), goal(A,G), G = N.

% Define the possible moves for a number in a cell X,Y
{ target(X,Y,P,Q) } 1 :- neighbour(X,Y,P,Q), number(X,Y,_), not target(P,Q,_,_).

% Define the condition that each gray area must be populated with at least one moved number
:- area(X,Y,A), not target(_,_,X,Y), goal(A,_).

% Define the condition that the numbers moved into an area must sum up exactly to the goal
:- target(X,Y,P,Q), area(P,Q,A), goal(A,G), not number(X,Y,_).
:- target(X,Y,P,Q), area(P,Q,A), goal(A,G), sum { number(X,Y,N) : target(X,Y,P,Q) } = G.