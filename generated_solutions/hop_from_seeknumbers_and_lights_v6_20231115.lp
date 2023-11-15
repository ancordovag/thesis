                    % Generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% Possible steps could be in cells that are not the start or goal
possible_step(X,Y,T) :- cell(X,Y), not start(X,Y), not goal(X,Y), T=1..N, numsteps(N).