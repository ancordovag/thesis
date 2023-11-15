% The target of a cell (X,Y) is a cell (P,Q) if both cells belong to the same area and there is no other cell between them in the same row or column
target(X,Y,P,Q) :- number(X,Y,_), area(X,Y,A), area(P,Q,A), X=P, not cell(X,Z), Z>Y, Z<Q.
target(X,Y,P,Q) :- number(X,Y,_), area(X,Y,A), area(P,Q,A), X=P, not cell(X,Z), Z<Q, Z>Y.
target(X,Y,P,Q) :- number(X,Y,_), area(X,Y,A), area(P,Q,A), Y=Q, not cell(Z,Y), Z>X, Z<P.
target(X,Y,P,Q) :- number(X,Y,_), area(X,Y,A), area(P,Q,A), Y=Q, not cell(Z,Y), Z<P, Z>X.

% The sum of the numbers moved into an area must be equal to the goal of the area
:- goal(A,G), G != #sum{ N : number(X,Y,N), target(X,Y,_,_) }.

% Each gray area must be populated with at least one moved number
:- area(X,Y,A), not target(_,_,X,Y).

% The ways of any two moved numbers must not cross or meet at any grid cell
:- target(X1,Y1,P1,Q1), target(X2,Y2,P2,Q2), X1!=X2, Y1!=Y2, P1=P2, Q1=Q2.

% Show the output predicate
#show target/4.
                    % It cannot be the case that a number is moved to a cell that is not in a gray area
                  :- target(X,Y,I,J), not area(I,J,A).
                  % It cannot be the case that a number is moved to a cell that already contains a number
                  :- target(X,Y,I,J), number(I,J,N).
                  % It cannot be the case that a number is moved to a cell that is not in the same row or column
                  :- target(X,Y,I,J), X != I, Y != J.
                  % It cannot be the case that a number is moved to a cell that is not in a straight line
                  :- target(X,Y,I,J), not dir(X-I,Y-J).
                  % It cannot be the case that a number is moved to a cell that is not reachable
                  :- target(X,Y,I,J), not reachable(X,Y,I,J).
                  % It cannot be the case that a number is moved to a cell that is already a target
                  :- target(X,Y,I,J), target(I,J,_,_).
                  % It cannot be the case that a number is moved to a cell that is in the path of another number
                  :- target(X,Y,I,J), target(X',Y',I',J'), X != X', Y != Y', path(X,Y,I,J) intersects path(X',Y',I',J').
                  % It cannot be the case that the sum of the numbers in an area is not equal to the goal of the area
                  :- area(_,_,A), goal(A,G), not sum(A,G).
                  % It cannot be the case that an area does not contain at least one number
                  :- area(_,_,A), not contains(A).