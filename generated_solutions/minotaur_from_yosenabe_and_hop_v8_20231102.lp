% possible movements for the player
possible_move(X,Y,T) :- at(X,Y,T-1), field(X,Y), not wall(X,Y,_,_), not mino(_,_,T-1).
possible_move(X,Y,T) :- at(X,Y,T-1), field(X,Y), not wall(_,_,X,Y), not mino(_,_,T-1).

% possible movements for the Minotaur
possible_mino_move(X,Y,T) :- mino(X,Y,T-1), field(X,Y), not wall(X,Y,_,_), not at(_,_,T-1).
possible_mino_move(X,Y,T) :- mino(X,Y,T-1), field(X,Y), not wall(_,_,X,Y), not at(_,_,T-1).