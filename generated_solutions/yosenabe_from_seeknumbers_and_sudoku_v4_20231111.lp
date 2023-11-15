% The cell (X,Y) is a neighbor of cell (P,Q) if they are horizontally or vertically adjacent
neighbor(X,Y,P,Q) :- cell(X,Y), cell(P,Q), (X=P, Y=Q+1 ; X=P, Y=Q-1 ; X+1=P, Y=Q ; X-1=P, Y=Q).

% The cell (X,Y) is a target of cell (P,Q) if they are in the same area and there is no other cell between them
target(P,Q,X,Y) :- number(P,Q,_), area(P,Q,A), area(X,Y,A), not between(P,Q,X,Y).

% There is a cell (R,S) between cell (P,Q) and cell (X,Y) if it is a neighbor of both
between(P,Q,X,Y) :- neighbor(P,Q,R,S), neighbor(X,Y,R,S).

% The sum of numbers in area A is equal to the goal of area A
:- goal(A,G), #sum{ N,P,Q : target(P,Q,X,Y), number(P,Q,N), area(X,Y,A) } != G.

% Each number must have exactly one target
1 { target(P,Q,X,Y) : cell(X,Y) } 1 :- number(P,Q,_).

% Each area must have at least one number
1 { target(P,Q,X,Y) : number(P,Q,_), area(X,Y,A) } 1 :- area(_,_,A).

% The ways of any two moved numbers must not cross or meet at any grid cell
:- target(P,Q,X,Y), target(R,S,X,Y), P!=R, Q!=S.

% Show output predicate
#show target/4.