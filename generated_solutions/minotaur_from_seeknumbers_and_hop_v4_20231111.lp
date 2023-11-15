% Generate a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, field(X,Y), field(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, field(X,Y), field(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, field(X,Y), field(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, field(X,Y), field(XX,YY).

% The player starts at the start field
at(X,Y,0) :- start(X,Y).

% The player can stay in the same field or move to a neighbouring field, if there is no wall
1 { at(XX,YY,S+1) : neighbour(X,Y,XX,YY,D), not wall(X,Y,XX,YY) } 1 :- at(X,Y,S), maxsteps(S).

% The Minotaur starts at the Minotaur field
mino_at(X,Y,0) :- mino(X,Y).

% The Minotaur moves towards the player, if possible
mino_at(XX,YY,S+1) :- mino_at(X,Y,S), at(P,Q,S+1), (XX=X, YY=Y+1; XX=X, YY=Y-1; XX=X+1, YY=Y; XX=X-1, YY=Y), not wall(X,Y,XX,YY), abs(P-XX)+abs(Q-YY) < abs(P-X)+abs(Q-Y).

% The Minotaur stays in the same field, if it cannot move towards the player
mino_at(X,Y,S+1) :- mino_at(X,Y,S), at(P,Q,S+1), not mino_at(XX,YY,S+1), abs(P-X)+abs(Q-Y) <= abs(P-XX)+abs(Q-YY).

% The player cannot be in the same field as the Minotaur
:- at(X,Y,S), mino_at(X,Y,S).

% The player must reach the goal field
:- not at(X,Y,S), goal(X,Y), maxsteps(S).

% Show output predicate
#show at/3.