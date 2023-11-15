                    % Define fields at the combination of a row X and a column Y
field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C.

% Define the possible distances from a field, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).

% Define neighbors for each field given a delta
neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

% The start cell is visited at timestep 0
step(X,Y,0) :- start(X,Y).

% If a cell (X,Y) is visited at timestep T, and there is a neighbor (XX,YY), then cell (XX,YY) is visited at timestep T+1
step(XX,YY,T+1) :- step(X,Y,T), neighbor(X,Y,XX,YY,DX,DY), T < numsteps(N).

% If a cell (X,Y) is visited at timestep T, and there is a dot (XX,YY), then cell (XX,YY) is visited at timestep T+1
step(XX,YY,T+1) :- step(X,Y,T), dot(XX,YY), T < numsteps(N).

% The goal cell is visited at the last timestep
step(X,Y,N) :- goal(X,Y), numsteps(N).

% Show output predicate
#show step/3.
% Cannot be the case that a cell is visited more than once
:- step(X,Y,S1), step(X,Y,S2), S1 != S2.
% Cannot be the case that a cell is visited in a step that is not a multiple of 3 if it is not a dot
:- step(X,Y,S), not dot(X,Y), S mod 3 != 0.
% Cannot be the case that the goal is not reached in the last step
:- not step(X,Y,N), goal(X,Y), numsteps(N).

% Show output predicate
#show step/3.