                    % Define fields at the combination of a row X and a column Y
field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C.

% Define the possible distances from a field, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).
delta(2,0). delta(-2,0). delta(0,2). delta(0,-2).
delta(3,0). delta(-3,0). delta(0,3). delta(0,-3).

% Define neighbors for each field given a delta
neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

% Generate minimum 0 predicate step for field(X,Y) if this is not a start or goal.  
{ step(X,Y,T) } :- field(X,Y), not start(X,Y), not goal(X,Y), numsteps(N), T = 1..N.

% The start cell is visited at time 0
step(X,Y,0) :- start(X,Y).

% The goal cell is visited at the last time step
step(X,Y,N) :- goal(X,Y), numsteps(N).

% If a cell (X,Y) is visited at time T, and there is a neighbor (XX,YY) at time T+1, then cell (XX,YY) is also visited at time T+1
step(XX,YY,T+1) :- step(X,Y,T), neighbor(X,Y,XX,YY,DX,DY), T mod 3 = DX+DY.

% It cannot be the case that a cell is visited at two different times
:- step(X,Y,T1), step(X,Y,T2), T1 != T2.

% It cannot be the case that a cell is visited at time T and it is not a dot
:- step(X,Y,T), not dot(X,Y), T != 0, T != N.

% Show output predicate
#show step/3.