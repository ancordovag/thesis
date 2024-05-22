                    % Define the possible movements for the player and the Minotaur
move(0,1). move(0,-1). move(1,0). move(-1,0).

% The player starts at the start field at time 0
at(X,Y,0) :- start(X,Y).
% The Minotaur starts at the Minotaur field at time 0
mino(X,Y,0) :- mino(X,Y).

% The player can stay in the same field or move to an adjacent field at each time step
at(X,Y,T+1) :- at(X,Y,T), field(X,Y), maxsteps(S), T < S.
at(X+DX,Y+DY,T+1) :- at(X,Y,T), move(DX,DY), field(X+DX,Y+DY), not wall(X,Y,X+DX,Y+DY), maxsteps(S), T < S.

% The Minotaur can move up to two fields in any direction at each time step
mino(X+DX,Y+DY,T+1) :- mino(X,Y,T), move(DX,DY), field(X+DX,Y+DY), not wall(X,Y,X+DX,Y+DY), maxsteps(S), T < S.
mino(X+2*DX,Y+2*DY,T+1) :- mino(X,Y,T), move(DX,DY), field(X+2*DX,Y+2*DY), not wall(X,Y,X+2*DX,Y+2*DY), maxsteps(S), T < S.

% The player cannot be in the same field as the Minotaur at any time step
:- at(X,Y,T), mino(X,Y,T).

% The player must reach the goal field within the maximum number of steps
:- not at(X,Y,S), goal(X,Y), maxsteps(S).

% Show output predicates
#show at/3.
#show mino/3.