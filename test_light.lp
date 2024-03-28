
% Given a number R of rows "rows(R)", and C columns "cols(C)", define "fields" as the combination of a row X and a column Y if this combination X,Y is not "empty"  
field(X,Y) :- rows(R), cols(C), X=1..R, Y=1..C, not empty(X,Y). 
% Define predicate digit/2 from digit/3 that only shows the position (first 2 varialbes) of the digit 
digit(X,Y) :- digit(X,Y,_). 
% Define the four possible distances from a field, as "delta" with 2 variables, showing a difference of 1 field with respect to (0,0) 
delta(1,0).
delta(-1,0).
delta(0,1).
delta(0,-1). 
% Define "neighbor" of 6 variables for 2 fields if there is a "delta" distance between them 
neighbor(X1,Y1,X2,Y2) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X1+DX=X2, Y1+DY=Y2. 
% Neighbors that are not "digit" are defined as "reach" 
reach(X1,Y1,X2,Y2) :- neighbor(X1,Y1,X2,Y2), not digit(X2,Y2). 
% Transitive property of relation "reach": all fields that are neighbours in the same direction, have a relation reach 
reach(X1,Y1,X2,Y2) :- reach(X1,Y1,X3,Y3), reach(X3,Y3,X2,Y2). 
% Generate minimum 0 predicate light for field(X,Y) if this is not a digit.   
{light(X,Y)} :- field(X,Y), not digit(X,Y).
% Mark a field as "lighted" for a position if there is a relation of "reach" between a position of "light" and that position 
lighted(X,Y) :- light(X1,Y1), reach(X1,Y1,X,Y). 
% Cannnot be the case that a field with a light is not lighted 
:- light(X,Y), not lighted(X,Y). 
% Cannot be the case that a field is not digit and is not lighted 
:- field(X,Y), not digit(X,Y), not lighted(X,Y). 
% A field with a digit N must have exactly N neighbors that are light 
:- digit(X,Y,N), #count{X1,Y1 : neighbor(X,Y,X1,Y1), light(X1,Y1)} != N. 
% Show output predicate "light" 
#show light/2.