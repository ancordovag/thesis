% Define fields at the combination of a row X and a column Y if this combination X,Y is not empty 
field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not empty(X,Y).
% Define predicate digit/2 from digit/3 that only shows the position of the digit N
digit(X,Y) :- digit(X,Y,N).
% Define the possible distances from a field, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).
% Define neighbors for each field given a delta
neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.
% Neighbors that are not digits are defined as reach, to indicate that one field is reachable from the other one.
reach(X1,Y1,X2,Y2,DX,DY) :- neighbor(X1,Y1,X2,Y2,DX,DY), not digit(X1,Y1), not digit(X2,Y2).
% Transitive property of relation "reach": all fields that are neighbours in the same direction (DX,DY), have a relation reach
reach(X1,Y1,X3,Y3,DX,DY) :- neighbor(X2,Y2,X3,Y3,DX,DY), reach(X1,Y1,X2,Y2,DX,DY), not digit(X3,Y3). 
% Define black cells
black(X,Y) :- field(X,Y), not digit(X,Y).
% Define white cells
white(X,Y) :- field(X,Y), not black(X,Y).
% Define the number of black cells around a digit
black_around(X,Y,N) :- digit(X,Y), N = #count{ DX,DY : neighbor(X,Y,_,_,DX,DY), black(X+DX,Y+DY) }.
% Constraint: the number of black cells around a digit must be equal to the digit
:- digit(X,Y,N), black_around(X,Y,M), N != M.
% Constraint: all white cells must be connected
:- white(X1,Y1), white(X2,Y2), not reach(X1,Y1,X2,Y2,_,_).                    % Cannot be the case that a field is black and is a digit
:- black(X,Y), digit(X,Y).
% Cannot be the case that a field is white and is a digit
:- white(X,Y), digit(X,Y).
% Cannot be the case that a field is black and is not connected to a digit
:- black(X,Y), not neighbor(X,Y,_,_,_,_).
% Cannot be the case that a field is white and is not connected to a white field
:- white(X,Y), not reach(X,Y,_,_,_,_).
% Cannot be the case that a digit does not have the correct number of black neighbors
:- digit(X,Y,N), not N { neighbor(X,Y,_,_,_,_) : black(X,Y) } N.