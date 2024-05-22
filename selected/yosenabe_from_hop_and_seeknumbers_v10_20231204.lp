                    % Define the neighbours of a cell X,Y
neighbour(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), |XX-X| + |YY-Y| = 1.

% A number can be moved to a neighbouring cell if it belongs to an area
{ target(X,Y,XX,YY) } :- number(X,Y,N), neighbour(X,Y,XX,YY), area(XX,YY,A).

% A number can be moved to a cell in the same area
{ target(X,Y,XX,YY) } :- number(X,Y,N), area(X,Y,A), area(XX,YY,A), cell(XX,YY).

% A number cannot be moved to a cell that is already occupied by another number
:- target(X,Y,XX,YY), target(P,Q,XX,YY), (X,Y) != (P,Q).

% The sum of the numbers in an area must equal the goal of the area
:- area(X,Y,A), goal(A,G), #sum{ N : target(P,Q,X,Y), number(P,Q,N) } != G.

% Each area must contain at least one number
:- area(X,Y,A), not target(P,Q,X,Y).

% The paths of any two numbers must not cross
:- target(X,Y,XX,YY), target(P,Q,XX,YY), (X,Y) != (P,Q), path(X,Y,XX,YY), path(P,Q,XX,YY).

% Show output predicate
#show target/4.