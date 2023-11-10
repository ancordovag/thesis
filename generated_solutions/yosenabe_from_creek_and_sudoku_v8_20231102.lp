% A number can be moved from any cell
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q).

% A number can be moved to any cell within the same area
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), area(X,Y,A), area(P,Q,A).

% A number can be moved to any cell within the same area and fulfill the goal
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), area(X,Y,A), area(P,Q,A), goal(A,G), number(X,Y,N), N + G = Q.