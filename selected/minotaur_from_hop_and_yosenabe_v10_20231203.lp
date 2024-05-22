                    % The player starts at the start field
at(X,Y,0) :- start(X,Y).
% The Minotaur starts at the mino field
mino(X,Y,0) :- mino(X,Y).
% The player can stay in his current field, or move one field in any direction: up, down, left or right
1 {at(X+DX,Y+DY,T+1) : dir(DX,DY), field(X+DX,Y+DY)} 1 :- at(X,Y,T), maxsteps(S), T < S.
% The Minotaur can move two fields every step, but his movements are determined by his and the player position
1 {mino(X+DX,Y+DY,T+1) : dir(DX,DY), field(X+DX,Y+DY)} 1 :- mino(X,Y,T), at(PX,PY,T), maxsteps(S), T < S, DX = sign(PX-X), DY = 0.
1 {mino(X+DX,Y+DY,T+1) : dir(DX,DY), field(X+DX,Y+DY)} 1 :- mino(X,Y,T), at(PX,PY,T), maxsteps(S), T < S, DX = 0, DY = sign(PY-Y).
% The Minotaur cant move to the players position
:- mino(X,Y,T), at(X,Y,T).
% The player must reach the goal
:- goal(X,Y), maxsteps(S), not at(X,Y,S).
% The Minotaur cant reach the goal
:- goal(X,Y), mino(X,Y,T).
% Show output predicates
#show at/3.
#show mino/3. 

% Helper function to get the sign of a number
sign(N) :- N = 0, N = 0.
sign(N) :- N > 0, N = 1.
sign(N) :- N < 0, N = -1.