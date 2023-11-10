% The start cell is visited at timestep 0
step(X,Y,0) :- start(X,Y).

% The goal cell is visited at the last timestep
step(X,Y,N) :- goal(X,Y), numsteps(N).

% A dot cell is visited at any timestep
step(X,Y,T) :- dot(X,Y), numsteps(N), T <= N.

% A cell is visited at timestep T if the previous cell was visited at timestep T-1 and the jump length is correct
step(X,Y,T) :- step(Xprev,Yprev,T-1), numsteps(N), T <= N, jump_length(T, L), abs(X-Xprev) + abs(Y-Yprev) = L.

% Jump lengths follow the pattern 1, 2, 3, 1, 2, 3, ...
jump_length(T, L) :- T mod 3 = L.