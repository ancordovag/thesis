% The possible cells to blacken are the ones that are adjacent to a hint cell
possible_black(X,Y) :- hint(X,Y,N).
possible_black(X+1,Y) :- hint(X,Y,N).
possible_black(X,Y+1) :- hint(X,Y,N).
possible_black(X+1,Y+1) :- hint(X,Y,N).

% The number of black cells around a hint must be equal to the hint number
:- hint(X,Y,N), N != #count{ 1 : black(X,Y); 1 : black(X+1,Y); 1 : black(X,Y+1); 1 : black(X+1,Y+1) }.

% All white cells must be connected orthogonally
connected(X,Y) :- cell(X,Y), not black(X,Y).
connected(X,Y) :- connected(X-1,Y), cell(X,Y), not black(X,Y).
connected(X,Y) :- connected(X+1,Y), cell(X,Y), not black(X,Y).
connected(X,Y) :- connected(X,Y-1), cell(X,Y), not black(X,Y).
connected(X,Y) :- connected(X,Y+1), cell(X,Y), not black(X,Y).

% There must be a path of white cells from every cell to every other cell
:- cell(X,Y), not black(X,Y), not connected(X,Y).

% Show the output predicate
#show black/2.
% A cell cannot be blackened if it is not a cell
:- black(X,Y), not cell(X,Y).
% A cell must be blackened if it is surrounded by a hint that requires it
black(X,Y) :- hint(X,Y,N), N > 0.
% A cell must not be blackened if it is surrounded by a hint that requires it not to be
:- black(X,Y), hint(X,Y,0).
% The number of blackened cells around a hint must match the hints number
{ black(X-1,Y); black(X+1,Y); black(X,Y-1); black(X,Y+1) }=N :- hint(X,Y,N).
% All white cells must be orthogonally connected
:- cell(X,Y), not black(X,Y), cell(XX,YY), not black(XX,YY), not connected(X,Y,XX,YY).
connected(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), not black(X,Y), not black(XX,YY), X=XX, Y=YY.
connected(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), not black(X,Y), not black(XX,YY), connected(X,Y,X1,Y1), (X1=XX, Y1=YY+1; X1=XX, Y1=YY-1; X1=XX+1, Y1=YY; X1=XX-1, Y1=YY).