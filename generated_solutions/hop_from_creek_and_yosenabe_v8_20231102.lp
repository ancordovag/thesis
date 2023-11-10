% The start cell is visited at timestep 0
possible_step(X,Y,0) :- start(X,Y).

% The goal cell is visited at the last timestep
possible_step(X,Y,N) :- goal(X,Y), numsteps(N).

% Any cell can be visited at any timestep
possible_step(X,Y,T) :- cell(X,Y), numsteps(N), T >= 0, T <= N.

% Any predefined intermediate step is visited at a specific timestep
possible_step(X,Y,T) :- dot(X,Y), T > 0, T mod 3 =:= 0.