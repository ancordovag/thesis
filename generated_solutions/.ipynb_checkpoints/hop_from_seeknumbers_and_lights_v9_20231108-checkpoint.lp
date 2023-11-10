% Generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).

% Generate steps
step(X,Y,T) :- cell(X,Y), T=1..N, numsteps(N).

% Generate path
{ step(X,Y,T) } :- step(X,Y,T), not dot(X,Y), not start(X,Y), not goal(X,Y).

% Generate start and goal cells
{ step(X,Y,1) } :- start(X,Y).
{ step(X,Y,N) } :- goal(X,Y), numsteps(N).