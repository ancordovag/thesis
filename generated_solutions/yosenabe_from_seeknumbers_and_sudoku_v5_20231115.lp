% A cell is defined by its coordinates (X,Y)
cell(X,Y) :- row(X), column(Y).

% A cell (X,Y) is a neighbor of cell (XX,YY) if it is horizontally or vertically adjacent
neighbor(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), (X=XX, Y=YY+1 ; X=XX, Y=YY-1 ; X=X+1, Y=YY ; X=X-1, Y=YY).

% A cell (X,Y) can move to cell (XX,YY) if they are neighbors and cell (XX,YY) is not occupied
move(X,Y,XX,YY) :- neighbor(X,Y,XX,YY), not occupied(XX,YY).

% A cell (X,Y) is occupied if it contains a number
occupied(X,Y) :- cell(X,Y), number(X,Y,_).

% A cell (X,Y) is in area A if it is within the boundaries of area A
in_area(X,Y,A) :- cell(X,Y), area(A), within_boundaries(X,Y,A).

% The sum of numbers in area A is equal to the goal of area A
sum_area(A,S) :- area(A), goal(A,G), S = #sum{ V,X,Y : number(X,Y,V), in_area(X,Y,A) }, S = G.

% A number can move from cell (X,Y) to cell (XX,YY) if cell (XX,YY) is in the same area as cell (X,Y) and cell (XX,YY) is not occupied
can_move(X,Y,XX,YY) :- number(X,Y,_), in_area(X,Y,A), in_area(XX,YY,A), not occupied(XX,YY).

% A number must move if it is not in a gray area
must_move(X,Y) :- number(X,Y,_), not in_gray_area(X,Y).

% A number cannot move if it is in a gray area
cannot_move(X,Y) :- number(X,Y,_), in_gray_area(X,Y).                    % A number cannot move to a cell that is occupied
:- can_move(X,Y,XX,YY), occupied(XX,YY).

% A number cannot move to a cell that is not in the same area
:- can_move(X,Y,XX,YY), not in_area(XX,YY,A).

% A number must move if it is not in a gray area
:- must_move(X,Y), not can_move(X,Y,XX,YY).

% A number cannot move if it is in a gray area
:- cannot_move(X,Y), can_move(X,Y,XX,YY).

% The sum of numbers in an area cannot exceed the goal of the area
:- sum_area(A,S), goal(A,G), S > G.

% Each gray area must contain at least one number
:- gray_area(A), not number(X,Y,_), in_area(X,Y,A).

% The ways of any two moved numbers must not cross or meet at any grid cell
:- move(X,Y,XX,YY), move(XXX,YYY,XXXX,YYYY), XX=XXXX, YY=YYYY, X!=XXX, Y!=YYY.