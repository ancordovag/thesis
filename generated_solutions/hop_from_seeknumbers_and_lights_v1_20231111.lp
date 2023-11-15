                    % Define fields at the combination of a row X and a column Y if this combination X,Y is not empty 
field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not empty(X,Y).
% Define predicate jump/2 from jump/3 that only shows the position of the jump N
jump(X,Y) :- jump(X,Y,N).
% Define the possible distances from a field, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).
% Define neighbors for each field given a delta
neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.
% Neighbors that are not jumps are defined as reach, to indicate that one field is reachable from the other one.
reach(X1,Y1,X2,Y2,DX,DY) :- neighbor(X1,Y1,X2,Y2,DX,DY), not jump(X1,Y1), not jump(X2,Y2).
% Transitive property of relation "reach": all fields that are neighbours in the same direction (DX,DY), have a relation reach
reach(X1,Y1,X3,Y3,DX,DY) :- neighbor(X2,Y2,X3,Y3,DX,DY), reach(X1,Y1,X2,Y2,DX,DY), not jump(X3,Y3).

% Generate minimum 0 predicate path for field(X,Y) if this is not a jump.  
{ path(X,Y) } :- field(X,Y), not jump(X,Y).

% Mark a field as pathed
pathed(X2,Y2) :- path(X1,Y1), reach(X1,Y1,X2,Y2,DX,DY). 

% If a field is pathed, it cannot be a jump
:- pathed(X,Y), jump(X,Y). 

% If a field is a jump, it cannot be pathed
:- jump(X,Y), pathed(X,Y). 

% A field can either be pathed or a jump, but not both
:- field(X,Y), pathed(X,Y), jump(X,Y). 

% A field can either be a jump or pathed, but not both
:- field(X,Y), jump(X,Y), pathed(X,Y). 

% Show output predicate
#show path/2.
% Cannot be the case that a cell is part of the path but does not have a jump
:- path(X,Y), not jump(X,Y,_).

% Cannot be the case that a cell has a jump but is not part of the path
:- jump(X,Y,_), not path(X,Y).

% Cannot be the case that a cell has a jump of N but does not have exactly N neighbors that are part of the path
:- jump(X1,Y1,N), not N { path(X2,Y2) : neighbor(X1,Y1,X2,Y2) } N.

% Show output predicate
#show path/2. 
#show jump/2.