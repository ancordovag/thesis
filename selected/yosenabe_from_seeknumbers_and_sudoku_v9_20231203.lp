                    % Define the neighbours of a cell X,Y
neighbour(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), |XX-X| + |YY-Y| = 1.

% Define the possible directions for a number to move
direction(X,Y,XX,YY) :- neighbour(X,Y,XX,YY), number(X,Y,_), not area(XX,YY,_).

% Define the target cell for each number
1 { target(X,Y,XX,YY) : direction(X,Y,XX,YY) } 1 :- number(X,Y,_).

% Define the path for each number to its target
path(X,Y,XX,YY) :- target(X,Y,XX,YY).
path(X,Y,XXX,YYY) :- path(X,Y,XX,YY), direction(XX,YY,XXX,YYY), not number(XXX,YYY,_).

% Ensure that no two paths intersect
:- path(X,Y,XX,YY), path(XXX,YYY,XX,YY), X!=XXX, Y!=YYY.

% Ensure that each area has at least one number
:- area(XX,YY,_), not 1 { target(X,Y,XX,YY) : number(X,Y,_) } 1.

% Ensure that the sum of the numbers in each area equals the goal
:- area(XX,YY,G), G != #sum { N,X,Y : target(X,Y,XX,YY), number(X,Y,N) }.

% Show output predicate
#show target/4.