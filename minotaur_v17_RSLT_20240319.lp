
% The possible next movements of the player "next" of 4 variables, are defined as 2 adjacent fields, with "field" predicate of 2 variables, that do not have a "wall" (4 variables) between them)          
next(X,Y,XX,YY) :- field(X,Y), field(XX,YY), not wall(X,Y,XX,YY), not wall(XX,YY,X,Y).
            % A "field" is "next" to itself 
next(X,Y,X,Y) :- field(X,Y).
            % If a field is next to another, then this second one is next to the first one
next(X,Y,XX,YY) :- next(XX,YY,X,Y).
            % The player, "at" 3 variables, is at start position "start" 2 Variables, at timestep 0
at(X,Y,0) :- start(X,Y).
            % The player chooses only one position from the possible "next" fields if it is not at the "goal" 2 variables, and the timestem T is less than the max steps S "maxsteps".
1 {at(XX,YY,T+1) : next(X,Y,XX,YY)} 1 :- at(X,Y,T), not goal(X,Y), T < S, maxsteps(S).
            % The minotaurs movements "mino_step" 5 variables depending of the possible "next" movement of the player.     
mino_step(X,Y,XX,YY,T) :- mino(X,Y,T), next(X,Y,XX,YY).
            % The minotaur's next position as the actual position plus the minotaur's movement
mino(XX,YY,T+1) :- mino(X,Y,T), mino_step(X,Y,XX,YY,T).
            % The minotaur is at the minotaur's start position at timestep 0
mino(X,Y,0) :- mino(X,Y).