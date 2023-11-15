                    % The player starts at the start field
possible_at(X,Y,0) :- start(X,Y).
% The Minotaur starts at the mino field
possible_mino(X,Y,0) :- mino(X,Y).
% The player can stay in his current field
possible_at(X,Y,T) :- possible_at(X,Y,T-1), not goal(X,Y), T>0, T<=S, maxsteps(S).
% The player can move one field in any direction: up, down, left or right
possible_at(X+1,Y,T) :- possible_at(X,Y,T-1), not wall(X,Y,X+1,Y), not goal(X+1,Y), T>0, T<=S, maxsteps(S).
possible_at(X-1,Y,T) :- possible_at(X,Y,T-1), not wall(X,Y,X-1,Y), not goal(X-1,Y), T>0, T<=S, maxsteps(S).
possible_at(X,Y+1,T) :- possible_at(X,Y,T-1), not wall(X,Y,X,Y+1), not goal(X,Y+1), T>0, T<=S, maxsteps(S).
possible_at(X,Y-1,T) :- possible_at(X,Y,T-1), not wall(X,Y,X,Y-1), not goal(X,Y-1), T>0, T<=S, maxsteps(S).
% The Minotaur can move two fields every step, but his movements are determined by his and the player position
possible_mino(X+2,Y,T) :- possible_mino(X,Y,T-1), possible_at(XX,YY,T-1), XX>X, not wall(X,Y,X+2,Y), T>0, T<=S, maxsteps(S).
possible_mino(X-2,Y,T) :- possible_mino(X,Y,T-1), possible_at(XX,YY,T-1), XX<X, not wall(X,Y,X-2,Y), T>0, T<=S, maxsteps(S).
possible_mino(X,Y+2,T) :- possible_mino(X,Y,T-1), possible_at(XX,YY,T-1), YY>Y, not wall(X,Y,X,Y+2), T>0, T<=S, maxsteps(S).
possible_mino(X,Y-2,T) :- possible_mino(X,Y,T-1), possible_at(XX,YY,T-1), YY<Y, not wall(X,Y,X,Y-2), T>0, T<=S, maxsteps(S).