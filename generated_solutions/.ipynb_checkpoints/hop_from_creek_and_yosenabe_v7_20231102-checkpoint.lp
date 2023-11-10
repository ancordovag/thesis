% Define the possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible steps
possible_step(X,Y,T) :- numsteps(N), between(1,N,T), step(X,Y,T-1), dir(DX,DY), step(X+DX,Y+DY,T-2).

% The start cell is visited at timestep 0
step(X,Y,0) :- start(X,Y).

% The goal cell is visited at the last timestep
step(X,Y,N) :- goal(X,Y), numsteps(N).

% The predefined intermediate steps are visited at the corresponding timesteps
step(X,Y,T) :- dot(X,Y), step(X,Y,T), numsteps(N), between(1,N,T).