
% Four atoms with predicate "plus" of 2 variables with possible values 0 and 1.
plus(0,0).
plus(0,1).
plus(1,0).
plus(1,1).
% The four possible directions, predicate "dir" with 2 variables, of value 0, 1 or -1. dir(0,0) is not an option.
dir(0,1).
dir(0,-1).
dir(1,0).
dir(-1,0).
% Predicate "black" of 2 variables is generated as the sum of the sum of the position (X,Y) and (A,B), for plus (A,B), if the cell(X+A,Y+B) exists, given hint(X,Y,N). There should be exactly "N" "black" predicates generated.
{ black(X+DX,Y+DY) : dir(DX,DY), cell(X+DX,Y+DY) } = N :- hint(X,Y,N).
% Predicate "path" has 4 variables, indicating a path between two cells of predicate "white" of positions (X,Y) and (P,Q) if the sum of the absolute values of the differences of P and X, and Q and Y, is 1. Absolute value is expresed with bars: "||"
path(X,Y,P,Q) :- white(X,Y), white(P,Q), |P-X| + |Q-Y| = 1.
% If a cell is not black, it should be white
white(X,Y) :- cell(X,Y), not black(X,Y).
% If a cell is not white, it should be black
black(X,Y) :- cell(X,Y), not white(X,Y).
% Find the minimum column of predicate "mini_x" containing a white cell 
mini_x(MX) :- MX = #min{ X : white(X,_) }.
% Find the minimum row, predicate "mini_y", containing a white cell in the minimum column containing a white cell, using the last predicate "mini_x"
mini_y(MY) :- MY = #min{ Y : white(MX,Y) }, mini_x(MX).
% The predicate "first_visit" has 2 variables: the minimum column and the minimum row defined before
first_visit(MX,MY) :- mini_x(MX), mini_y(MY).
% Declare a cell as visited if there is an incoming path from the first visited cell
visited(X,Y) :- first_visit(X,Y).
visited(X,Y) :- path(P,Q,X,Y), visited(P,Q).
% Declare a cell as visited if there is an incoming path from a already visited cell
visited(X,Y) :- path(P,Q,X,Y), visited(P,Q).
% It cannot be that a white cell is not visited
:- white(X,Y), not visited(X,Y).
% Show output predicate "black"
#show black/2.