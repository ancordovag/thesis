% generate all possible moves for the player
move(X,Y,XX,YY) :- field(X,Y), field(XX,YY), not wall(X,Y,XX,YY), not wall(XX,YY,X,Y), |X-XX|+|Y-YY| = 1.
% generate all possible moves for the Minotaur
mino_move(X,Y,XX,YY) :- field(X,Y), field(XX,YY), not wall(X,Y,XX,YY), not wall(XX,YY,X,Y), |X-XX|+|Y-YY| <= 2.

% the player starts at "start"
at(X,Y,0) :- start(X,Y).
% the Minotaur starts at "mino"
mino_at(X,Y,0) :- mino(X,Y).

% the player can stay in the same field or move to a neighboring field
1 {at(XX,YY,S+1) : move(X,Y,XX,YY)} 1 :- at(X,Y,S), not goal(X,Y), maxsteps(S).

% the Minotaur moves towards the player
1 {mino_at(XX,YY,S+1) : mino_move(X,Y,XX,YY)} 1 :- mino_at(X,Y,S), at(P,Q,S+1), (XX-X)*(P-X) + (YY-Y)*(Q-Y) >= 0.

% the player cannot be in the same field as the Minotaur
:- at(X,Y,S), mino_at(X,Y,S).

% the player must reach the goal within the maximum number of steps
:- not at(X,Y,S), goal(X,Y), maxsteps(S).

% Show output predicate
#show at/3.
                    % The player cannot be at the same position as the minotaur
            :- at(X,Y,T), mino(X,Y,T).
            % The player cannot be at the same position as the minotaur in the next step
            :- at(X,Y,T), mino(XX,YY,T+1), next(X,Y,XX,YY).
            % The player must be at the goal position at the last step
            :- not at(X,Y,S), goal(X,Y), maxsteps(S).