% A number can be moved from one cell to another
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), not number(P,Q,_).

% A number can be moved into an area if it belongs to that area
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), area(P,Q,_).

% The sum of the numbers in an area must be equal to the goal
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), goal(P,G), sum_numbers_in_area(P,G).

% The ways of any two moved numbers must not cross or meet at any grid cell
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), not intersecting_ways(X,Y,P,Q).

% Each gray area must be populated with at least one moved number
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), area(P,Q,A), at_least_one_number_in_area(A).

% A move stops at the first cell with respect to its direction of the area into which it leads
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), area(P,Q,A), first_cell_in_direction(X,Y,P,Q,A).