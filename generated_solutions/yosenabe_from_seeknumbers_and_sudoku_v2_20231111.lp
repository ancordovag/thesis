% The target of a cell (X,Y) is a cell (P,Q) that belongs to the same area A
target(X,Y,P,Q) :- number(X,Y,_), area(X,Y,A), area(P,Q,A), cell(P,Q).

% The target of a cell (X,Y) is a cell (P,Q) that belongs to a different area A, if the sum of the numbers in the cells of area A is equal to the goal G of area A
target(X,Y,P,Q) :- number(X,Y,N), area(X,Y,A1), area(P,Q,A2), A1 != A2, goal(A2,G), G = #sum{ N1 : number(P1,Q1,N1), area(P1,Q1,A2) }.

% The target of a cell (X,Y) is a cell (P,Q) that belongs to a different area A, if the sum of the numbers in the cells of area A is less than the goal G of area A
target(X,Y,P,Q) :- number(X,Y,N), area(X,Y,A1), area(P,Q,A2), A1 != A2, goal(A2,G), G > #sum{ N1 : number(P1,Q1,N1), area(P1,Q1,A2) }.

% The target of a cell (X,Y) is a cell (P,Q) that belongs to a different area A, if the sum of the numbers in the cells of area A is greater than the goal G of area A
target(X,Y,P,Q) :- number(X,Y,N), area(X,Y,A1), area(P,Q,A2), A1 != A2, goal(A2,G), G < #sum{ N1 : number(P1,Q1,N1), area(P1,Q1,A2) }.

% The target of a cell (X,Y) is a cell (P,Q) that belongs to a different area A, if the sum of the numbers in the cells of area A is equal to the goal G of area A and the number N in cell (X,Y) is not included in the sum
target(X,Y,P,Q) :- number(X,Y,N), area(X,Y,A1), area(P,Q,A2), A1 != A2, goal(A2,G), G = #sum{ N1 : number(P1,Q1,N1), area(P1,Q1,A2), (P1,Q1) != (X,Y) }.

% Show output predicate
#show target/4.
% It cannot be the case that a number is not moved
:- number(X,Y,_), not target(X,Y,_,_).
% It cannot be the case that a number is moved to a cell that is not in an area
:- target(X,Y,P,Q), not area(P,Q,_).
% It cannot be the case that a number is moved to a cell that already contains a number
:- target(X,Y,P,Q), number(P,Q,_).
% It cannot be the case that a number is moved to a cell that is already a target
:- target(X,Y,P,Q), target(_,_,P,Q).
% It cannot be the case that the sum of the numbers moved into an area does not match the goal of the area
:- goal(A,G), G != #sum{ N : target(X,Y,P,Q), number(X,Y,N), area(P,Q,A) }.
% It cannot be the case that an area does not contain at least one moved number
:- area(P,Q,A), not target(_,_,P,Q).