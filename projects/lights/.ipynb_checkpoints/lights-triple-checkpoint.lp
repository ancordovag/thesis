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

% Generate minimum 0 predicate light for field(X,Y) if this is not a digit.  
{ light(X,Y) } :- field(X,Y), not digit(X,Y).

% Mark a field as lighted
lighted(X2,Y2) :- light(X1,Y1), reach(X1,Y1,X2,Y2,DX,DY).

% Cannnot be the case that a field with a light is not lighted
:- light(X,Y), lighted(X,Y).
% Cannot be the case that a field is not digit and is not lighted
:- field(X,Y), not digit(X,Y), not light(X,Y), not lighted(X,Y).
% A field with a difit N must have exactly N neighbors that are light
:- digit(X1,Y1,N), not N { light(X2,Y2) : neighbor(X1,Y1,X2,Y2,DX,DY) } N.

% check attack combinations on pairs of fields neighboring a number for even stronger propagation
reach(X1,Y1,X2,Y2) :- reach(X1,Y1,X2,Y2,DX,DY).
:- digit(X,Y,N), 0 < N, N < 4,
   neighbor(X,Y,X1,Y1,DX1,DY1), neighbor(X,Y,X2,Y2,DX2,DY2), (DX1,DY1) < (DX2,DY2),
   reach(X3,Y3,X1,Y1),  reach(X4,Y4,X2,Y2), light(X3,Y3), light(X4,Y4),
   { light(X5,Y5) : neighbor(X,Y,X5,Y5,DX5,DY5) :
                    not reach(X3,Y3,X5,Y5) : not reach(X4,Y4,X5,Y5) } N-1.

#show light/2.
