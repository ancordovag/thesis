% possible movements
move(X,Y,X+1,Y) :- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
move(X,Y,X-1,Y) :- field(X,Y), field(X-1,Y), not wall(X,Y,X-1,Y).
move(X,Y,X,Y+1) :- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
move(X,Y,X,Y-1) :- field(X,Y), field(X,Y-1), not wall(X,Y,X,Y-1).

% player and minotaur positions at time 0
at(X,Y,0) :- start(X,Y).
mino(X,Y,0) :- mino(X,Y).

% player and minotaur movements at each time step
at(X,Y,T) :- at(X,Y,T-1), move(X,Y,X1,Y1), not mino(X1,Y1,T-1).
mino(X,Y,T) :- mino(X,Y,T-1), move(X,Y,X1,Y1), not at(X1,Y1,T-1).

% player reaches the goal within the maximum number of steps
reached_goal(T) :- at(X,Y,T), goal(X,Y), maxsteps(S), T <= S.