% The possible next movements of the player          
next(X,Y,X+1,Y) :- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
next(X,Y,X,Y+1) :- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
next(X,Y,X,Y-1) :- field(X,Y), field(X,Y-1), not wall(X,Y,X,Y-1).
next(X,Y,X-1,Y) :- field(X,Y), field(X-1,Y), not wall(X,Y,X-1,Y).

% The player is at start position at timestep 0
at(X,Y,0) :- start(X,Y).

% The player chooses one position from the possible next movements if it is not at the goal cell
1 { at(XX,YY,T+1) : next(X,Y,XX,YY) } 1 :- at(X,Y,T), not goal(X,Y), maxsteps(S), T < S.

% The minotaur's movements depending on the possible next movement of the player     
mino_step(X,Y,XX,YY,( 1, 0)) :- field(X,Y), field(XX,YY), X < XX, next(X,Y,X+1,Y).
mino_step(X,Y,XX,YY,(-1, 0)) :- field(X,Y), field(XX,YY), X > XX, next(X,Y,X-1,Y).
mino_step(X,Y,XX,YY,( 0, 1)) :- field(X,Y), field(XX,YY), Y < YY, next(X,Y,X,Y+1), not mino_step(X,Y,XX,YY,( 1, 0)), not mino_step(X,Y,XX,YY,(-1, 0)).
mino_step(X,Y,XX,YY,( 0,-1)) :- field(X,Y), field(XX,YY), Y > YY, next(X,Y,X,Y-1), not mino_step(X,Y,XX,YY,( 1, 0)), not mino_step(X,Y,XX,YY,(-1, 0)).
mino_step(X,Y,XX,YY,( 0, 0)) :- field(X,Y), field(XX,YY), not mino_step(X,Y,XX,YY,( 1, 0)), not mino_step(X,Y,XX,YY,(-1, 0)), not mino_step(X,Y,XX,YY,( 0, 1)), not mino_step(X,Y,XX,YY,( 0,-1)).

% The minotaur's next position as the actual position plus the minotaur's movement
mino_next(X,Y,XX,YY,X+DX1+DX2,Y+DY1+DY2) :- mino_step(X,Y,XX,YY,(DX1,DY1)), mino_step(X+DX1,Y+DY1,XX,YY,(DX2,DY2)).

% The minotaur is at the minotaur's start position at timestep 0
mino(X,Y,0) :- mino(X,Y).

% The minotaur's next position depending on the actual position and the next position of the player
mino(XXX,YYY,T+1) :- mino(X,Y,T), maxsteps(S), T < S, at(XX,YY,T+1), mino_next(X,Y,XX,YY,XXX,YYY).
% The player and the minotaur can not be at the same cell at the same time        
:- at(X,Y,T), mino(X,Y,T).

% The goal is achieved when the player is at cell goal
goal :- at(X,Y,T), goal(X,Y).

% It can not be the case, that the goal is not achieved
:- not goal.

% Optimization: minimize the time T            
#minimize{ T : at(X,Y,T) }.