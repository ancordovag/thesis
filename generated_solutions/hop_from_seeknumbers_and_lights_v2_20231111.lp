                    % Define fields at the combination of a row X and a column Y
field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C.

% Define the possible distances from a field, as delta
delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).

% Define neighbors for each field given a delta
neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.

% Define the possible jumps for each step
jump(1,1). jump(2,2). jump(3,3). jump(4,1). jump(5,2). jump(6,3).

% The start cell is visited at timestep 1
step(X,Y,1) :- start(X,Y).

% If a cell (X,Y) is visited at timestep T, and there is a jump of length L at timestep T, then the cell (XX,YY) is visited at timestep T+1
step(XX,YY,T+1) :- step(X,Y,T), neighbor(X,Y,XX,YY,DX,DY), jump(T,L), DX*L = XX-X, DY*L = YY-Y.

% All predefined intermediate steps must be visited
:- dot(X,Y), not step(X,Y,_).

% The goal cell must be visited at the last timestep
:- goal(X,Y), numsteps(N), not step(X,Y,N).

% Show output predicate
#show step/3.
% Cannot be the case that a cell is visited more than once
:- 2 { step(X,Y,T) : step(X,Y,T) } 2.
% Cannot be the case that a cell is not visited
:- dot(X,Y), not step(X,Y,_).
% Cannot be the case that a cell is visited in a wrong timestep
:- step(X,Y,T), not T mod 3 = 0, not dot(X,Y).
% Cannot be the case that a cell is visited in a wrong timestep
:- step(X,Y,T), T mod 3 = 0, not dot(X,Y), not start(X,Y), not goal(X,Y).
% Cannot be the case that a cell is visited in a wrong timestep
:- step(X,Y,T), T mod 3 = 1, not dot(X,Y), not start(X,Y), not goal(X,Y).
% Cannot be the case that a cell is visited in a wrong timestep
:- step(X,Y,T), T mod 3 = 2, not dot(X,Y), not start(X,Y), not goal(X,Y).
% Cannot be the case that a cell is visited in a wrong timestep
:- step(X,Y,T), T mod 3 = 3, not dot(X,Y), not start(X,Y), not goal(X,Y).
% Cannot be the case that a cell is visited in a wrong timestep
:- step(X,Y,T), T mod 3 = 4, not dot(X,Y), not start(X,Y), not goal(X,Y).
% Cannot be the case that a cell is visited in a wrong timestep
:- step(X,Y,T), T mod 3 = 5, not dot(X,Y), not start(X,Y), not goal(X,Y).
% Cannot be the case that a cell is visited in a wrong timestep
:- step(X,Y,T), T mod 3 = 6, not dot(X,Y), not start(X,Y), not goal(X,Y).