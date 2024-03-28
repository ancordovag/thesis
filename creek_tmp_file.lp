% Four atoms with predicate "plus" of 2 variables with possible values 0 and 1.
plus(0,0). plus(0,1). plus(1,0). plus(1,1).

% The four possible directions, predicate "dir" with 2 variables, of value 0, 1 or -1. dir(0,0) is not an option.
dir(0,1). dir(1,0). dir(0,-1). dir(-1,0).

% Predicate "black" of 2 variables is generated as the sum of the sum of the position (X,Y) and (A,B), for plus (A,B), if the cell(X+A,Y+B) exists, given hint(X,Y,N). There should be exactly "N" "black" predicates generated.
{ black(X+A,Y+B) : plus(A,B), cell(X+A,Y+B) } = N :- hint(X,Y,N).

% Predicate "path" has 4 variables, indicating a path between two cells of predicate "white" of positions (X,Y) and (P,Q) if they are adjacent
path(X,Y,P,Q) :- white(X,Y), white(P,Q), (X = P, |Y - Q| = 1; Y = Q, |X - P| = 1).
