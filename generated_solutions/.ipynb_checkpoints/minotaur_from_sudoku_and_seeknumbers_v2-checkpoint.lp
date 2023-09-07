% The Minotaur can move to any adjacent field that is not a wall
minotaur_move(X1,Y1,X2,Y2) :- minotaur(X1,Y1), neighbour(X1,Y1,X2,Y2), not wall(X2,Y2).

% You can move to any adjacent field that is not a wall
you_move(X1,Y1,X2,Y2) :- you(X1,Y1), neighbour(X1,Y1,X2,Y2), not wall(X2,Y2).

% The Minotaur can move from (X1,Y1) to (X2,Y2) if it is currently in (X1,Y1) and it is a valid move
minotaur(X2,Y2) :- minotaur(X1,Y1), minotaur_move(X1,Y1,X2,Y2).

% You can move from (X1,Y1) to (X2,Y2) if you are currently in (X1,Y1) and it is a valid move
you(X2,Y2) :- you(X1,Y1), you_move(X1,Y1,X2,Y2).

% The Minotaur can move from (X1,Y1) to (X2,Y2) if it is currently in (X1,Y1) and it is a valid move, and you are not in (X2,Y2)
minotaur_move(X1,Y1,X2,Y2) :- minotaur(X1,Y1), minotaur_move(X1,Y1,X2,Y2), not you(X2,Y2).

% You can move from (X1,Y1) to (X2,Y2) if you are currently in (X1,Y1) and it is a valid move, and the Minotaur is not in (X2,Y2)
you_move(X1,Y1,X2,Y2) :- you(X1,Y1), you_move(X1,Y1,X2,Y2), not minotaur(X2,Y2).

% You win if you are in the goal field
win :- you(X,Y), goal(X,Y).

% The Minotaur wins if it is in the same field as you
minotaur_win :- minotaur(X,Y), you(X,Y).

% The game is over if either you win or the Minotaur wins
game_over :- win.
game_over :- minotaur_win.
:- wall(X,Y), minotaur(X,Y).
:- wall(X,Y), you(X,Y).
:- not 1 { minotaur_move(X1,Y1,X2,Y2) : neighbour(X1,Y1,X2,Y2) } 1, minotaur(X1,Y1).
:- not 1 { you_move(X1,Y1,X2,Y2) : neighbour(X1,Y1,X2,Y2) } 1, you(X1,Y1).
:- initial(X,Y), not you(X,Y).
:- goal(X,Y), not you(X,Y).