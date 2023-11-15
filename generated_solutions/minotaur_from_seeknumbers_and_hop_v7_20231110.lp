                    % The player starts at the start field
possible_at(X,Y,0) :- start(X,Y).
% The Minotaur starts at the mino field
possible_mino(X,Y,0) :- mino(X,Y).
% The player can stay in his current field
possible_at(X,Y,T+1) :- possible_at(X,Y,T), field(X,Y), not maxsteps(T).
% The player can move one field in any direction
possible_at(X+1,Y,T+1) :- possible_at(X,Y,T), field(X+1,Y), not wall(X,Y,X+1,Y), not maxsteps(T).
possible_at(X-1,Y,T+1) :- possible_at(X,Y,T), field(X-1,Y), not wall(X,Y,X-1,Y), not maxsteps(T).
possible_at(X,Y+1,T+1) :- possible_at(X,Y,T), field(X,Y+1), not wall(X,Y,X,Y+1), not maxsteps(T).
possible_at(X,Y-1,T+1) :- possible_at(X,Y,T), field(X,Y-1), not wall(X,Y,X,Y-1), not maxsteps(T).
% The Minotaur can move two fields in any direction
possible_mino(X+2,Y,T+1) :- possible_mino(X,Y,T), field(X+2,Y), not wall(X,Y,X+2,Y), not maxsteps(T).
possible_mino(X-2,Y,T+1) :- possible_mino(X,Y,T), field(X-2,Y), not wall(X,Y,X-2,Y), not maxsteps(T).
possible_mino(X,Y+2,T+1) :- possible_mino(X,Y,T), field(X,Y+2), not wall(X,Y,X,Y+2), not maxsteps(T).
possible_mino(X,Y-2,T+1) :- possible_mino(X,Y,T), field(X,Y-2), not wall(X,Y,X,Y-2), not maxsteps(T).