% The maximum number of black cells in a 2x2 square is 4
:- black(X,Y), black(X+1,Y), black(X,Y+1), black(X+1,Y+1), cell(X,Y).

% The number of black cells in a 2x2 square is equal to the hint value
:- hint(X,Y,N), #count{1,X1,Y1 : black(X1,Y1), X1>=X, X1<X+2, Y1>=Y, Y1<Y+2} != N, cell(X,Y).

% A cell is blackened if it is a hint cell and the hint value is 4
black(X,Y) :- hint(X,Y,4), cell(X,Y).

% A cell is not blackened if it is a hint cell and the hint value is 0
:- hint(X,Y,0), black(X,Y), cell(X,Y).

% A cell is not blackened if it is a hint cell and the hint value is 1
:- hint(X,Y,1), black(X,Y), cell(X,Y).

% A cell is blackened if it is a hint cell and the hint value is 3 and there is at least one black cell in the 2x2 square
black(X,Y) :- hint(X,Y,3), #count{1,X1,Y1 : black(X1,Y1), X1>=X, X1<X+2, Y1>=Y, Y1<Y+2} > 0, cell(X,Y).

% A cell is blackened if it is a hint cell and the hint value is 2 and there are exactly two black cells in the 2x2 square
black(X,Y) :- hint(X,Y,2), #count{1,X1,Y1 : black(X1,Y1), X1>=X, X1<X+2, Y1>=Y, Y1<Y+2} = 2, cell(X,Y).

% A cell is not blackened if it is a hint cell and the hint value is 2 and there are not exactly two black cells in the 2x2 square
:- hint(X,Y,2), #count{1,X1,Y1 : black(X1,Y1), X1>=X, X1<X+2, Y1>=Y, Y1<Y+2} != 2, black(X,Y), cell(X,Y).

% A cell is not blackened if it is a hint cell and the hint value is 3 and there are no black cells in the 2x2 square
:- hint(X,Y,3), #count{1,X1,Y1 : black(X1,Y1), X1>=X, X1<X+2, Y1>=Y, Y1<Y+2} = 0, black(X,Y), cell(X,Y).

% A cell is not blackened if it is a hint cell and the hint value is 4 and there is not exactly one black cell in the 2x2 square
:- hint(X,Y,4), #count{1,X1,Y1 : black(X1,Y1), X1>=X, X1<X+2, Y1>=Y, Y1<Y+2} != 1, black(X,Y), cell(X,Y).

% A cell is not blackened if it is not a hint cell
:- cell(X,Y), not hint(X,Y,_), black(X,Y).
% The number of black cells adjacent to a hint cell must be equal to the hint value
:- hint(X,Y,N), N != #count{1, X1, Y1 : black(X1,Y1), neighbour(X,Y,X1,Y1)}.

% The number of black cells adjacent to a non-hint cell must be less than or equal to 2
:- cell(X,Y), not hint(X,Y,_), #count{1, X1, Y1 : black(X1,Y1), neighbour(X,Y,X1,Y1)} > 2.

% Show output predicate
#show black/2.