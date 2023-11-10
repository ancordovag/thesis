% The start cell is visited at timestep 0
possible_step(X,Y,0) :- start(X,Y).

% The goal cell is visited at the last timestep
possible_step(X,Y,N) :- goal(X,Y), numsteps(N).

% A dot cell is visited at any timestep
possible_step(X,Y,T) :- dot(X,Y), numsteps(N), T >= 0, T <= N.

% A cell is visited at timestep T if the previous cell was visited at timestep T-1 and the current cell is reachable from the previous cell
possible_step(X,Y,T) :- step(Xprev,Yprev,T-1), step(Xprev,Yprev,T), numsteps(N), T >= 1, T <= N.