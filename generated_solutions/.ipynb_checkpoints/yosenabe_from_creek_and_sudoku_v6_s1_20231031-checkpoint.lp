% A number can be moved from one cell to another
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), area(P,Q,_).

% A number can only be moved to a cell that belongs to the same area
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), area(P,Q,A), area(X,Y,A).

% The sum of the numbers in an area must be equal to the goal
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,N), area(P,Q,A), goal(A,G), sum_area(A,G).

% Helper rule to calculate the sum of the numbers in an area
sum_area(A,G) :- area(X,Y,A), number(X,Y,N), sum_area(A,G,N).

% Base case for the sum of the numbers in an area
sum_area(_,G,G).

% Recursive rule to calculate the sum of the numbers in an area
sum_area(A,G,N) :- area(X,Y,A), number(X,Y,M), M != N, sum_area(A,G,N+M).