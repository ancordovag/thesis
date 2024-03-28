minotaur = {"story":"minotaur",
            "problem":'''There is a player in a labyrinth. The goal is to go from a start field to a goal field without being eaten by the Minotaur. The labyrinth has walls, and neither the player nor the Minotaur can go through them. At every step the player can stay in his current field, or move one field in any direction: up, down, left or right. The Minotaur is faster than the player, but luckily he is a bit foolish. He can move two fields every step, but his movements are determined by his and the player position: there is no choice for him. He will try to move right or left to become closer of the player. If that is not possible, he will try to move up and down to become closer. If this is also not possible, the Minotaur will not move. In this way the Minotaur may move in a step first in one direction (e.g., up) and then in another direction (e.g., left). Typically, to solve a puzzle, the Minotaur should stay trapped between the walls of the labyrinth, so that the player can run free to the goal.''',
            "Short Problem":'''There is a player and a Minotaur in a labyrinth. The goal is for the player to go from a start field to a goal field without being eaten by the Minotaur. The labyrinth has walls, and neither the player nor the Minotaur can go through them. At every step the player can stay in his current field, or move one field in any direction: up, down, left or right. The Minotaur is faster than the player, but luckily he is a bit foolish. He can move two fields every step, but his movements are determined by his and the player position. He will try to move right or left to become closer of the player. If that is not possible, he will try to move up and down to become closer. If this is also not possible, the Minotaur will not move.''',
            
            "Representation in ASP":'''%% INPUT
field(X,Y).         % the field (X,Y) belongs to the labyrinth
start(X,Y).         % the start field is (X,Y)
goal(X,Y).          % the goal  field is (X,Y)
mino(X,Y).          % the Minotaur starts at (X,Y)
wall(X,Y,XX,YY).    % there is a wall between (X,Y) and (XX,YY)
maxsteps(S).        % there are at most S steps to reach the goal
%% OUTPUT
at(X,Y,T). % position at cell X,Y of the player at time T  
mino(X,Y,T). % position at cell X,Y of the minotaur at time T  ''',
            
            "constants":'''rows: 1; 2; ...; R;
                        columns: 1; 2; ...; C; ''',
            "predicates":'''% the player is at field (X,Y) at step S 
                at(X,Y,S).''',
            
            "rules":'''% The possible next movements of the player          
            next(X,Y,X+1,Y) :- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
            next(X,Y,X,Y+1) :- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
            next(X,Y,X,Y)   :- field(X,Y).
            next(X,Y,XX,YY) :- next(XX,YY,X,Y).

            % The player is at start position at timestep 0
            at(X,Y,0) :- start(X,Y).
            % The player chooses one position from the possible next movements if it is not at the goal cell
            1 { at(XX,YY,T+1) : next(X,Y,XX,YY) } 1 :- at(X,Y,T), not goal(X,Y), maxsteps(S), T < S.            
            % The minotaur's movements depending of the possible next movement of the player     
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
            % Show the output predicate
            #show at/3.''',
            
            "constraints":'''% The player and the minotaur can not be at the same cell at the same time        
            :- at(X,Y,T), mino(X,Y,T).
            % The goal is achieved when the player is at cell goal
            goal :- at(X,Y,T), goal(X,Y).
            % It can not be the case, that the goal is not achieved
            :- not goal.            
            % Optimization: minimize the time T            
            #minimize{ T : at(X,Y,T) }.
            % The minotaur's movements depending of the possible next movement of the player     
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
            mino(XXX,YYY,T+1) :- mino(X,Y,T), maxsteps(S), T < S, at(XX,YY,T+1), mino_next(X,Y,XX,YY,XXX,YYY).''',

            "normal_rules":'''% The possible next movements of the player          
            next(X,Y,X+1,Y) :- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
            next(X,Y,X,Y+1) :- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
            next(X,Y,X,Y)   :- field(X,Y).
            next(X,Y,XX,YY) :- next(XX,YY,X,Y).
            % The goal is achieved when the player is at cell goal
            goal(X,Y,T) :- at(X,Y,T), goal(X,Y).

            % The player is at start position at timestep 0
            at(X,Y,0) :- start(X,Y).
            at(XX,YY,T+1) :- next(X,Y,XX,YY), at(X,Y,T), not goal(X,Y), maxsteps(S), T < S. 
            
            % The minotaur's movements depending of the possible next movement of the player     
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
            mino(XXX,YYY,T+1) :- mino(X,Y,T), maxsteps(S), T < S, at(XX,YY,T+1), mino_next(X,Y,XX,YY,XXX,YYY).''',
            
            "integrity_constraints":'''% The player and the minotaur can not be at the same cell at the same time        
            :- at(X,Y,T), mino(X,Y,T). 
            % It can not be the case, that the goal is not achieved
            :- not goal(X,Y,T).''',

            "possible_rules":'''% The player is at start position at timestep 0
            possible_at(X,Y,0) :- start(X,Y).
            % The possible position of the player depends of the position of the last timestep, given than the cell is neighbours
            possible_at(XX,YY,T+1) :- next(X,Y,XX,YY), possible_at(X,Y,T), not goal(X,Y), maxsteps(S), T < S. 
            
            % The minotaur's movements depending of the possible next movement of the player     
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
            mino(XXX,YYY,T+1) :- mino(X,Y,T), maxsteps(S), T < S, at(XX,YY,T+1), mino_next(X,Y,XX,YY,XXX,YYY). ''',

            
            "Generation rules":'''% The player is at start position at timestep 0
            at(X,Y,0) :- start(X,Y).  
            % If the field(X,Y) and field(XX,YY) are neighbours there is no wall between them
            neighbour(X,Y,XX,YY) :- field(X,Y), field(XX,YY), |XX-X| + |YY-Y| = 1, not wall(X,Y,XX,YY).
            % If field(X,Y) is neighbor of field(XX,YY), then field(XX,YY) is neighbour of field(X,Y)
            neighbour(X,Y,XX,YY) :- neighbour(XX,YY,X,Y).
            % The next movement of the player at field(X,Y) could be either to a neighbour field or to stay at the same field
            next_movement(X,Y,XX,YY) :- neighbour(X,Y,XX,YY).
            next_movement(X,Y,X,Y) :- field(X,Y).
            % The player chooses one position from the possible next movements if it is not at the goal cell
            1 { at(XX,YY,T+1) : next_movement(X,Y,XX,YY) } 1 :- at(X,Y,T), not goal(X,Y), maxsteps(S), T < S. 
            % The minotaur is at the minotaurs start position at timestep 0
            mino(X,Y,0) :- mino(X,Y).
            % Show the output predicate
            #show at/3.''',

            
            "encoding":'''% The possible next movements of the player          
            next(X,Y,X+1,Y) :- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
            next(X,Y,X,Y+1) :- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
            next(X,Y,X,Y)   :- field(X,Y).
            next(X,Y,XX,YY) :- next(XX,YY,X,Y).

            % The player is at start position at timestep 0
            at(X,Y,0) :- start(X,Y).
            % The player chooses one position from the possible next movements if it is not at the goal cell
            1 { at(XX,YY,T+1) : next(X,Y,XX,YY) } 1 :- at(X,Y,T), not goal(X,Y), maxsteps(S), T < S.            
            % The minotaur's movements depending of the possible next movement of the player     
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
            % Show output predicate
            #show at/3. ''',

            "lines":'''% The possible next movements of the player "next" of 4 variables, are defined as 2 adjacent fields, with "field" predicate of 2 variables, that do not have a "wall" (4 arguments) between them)          
            next(X,Y,X+1,Y) :- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
            next(X,Y,X,Y+1) :- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
            % A "field" is "next" to itself 
            next(X,Y,X,Y)   :- field(X,Y).
            % If a field is next to another, then this second one is next to the first one
            next(X,Y,XX,YY) :- next(XX,YY,X,Y).

            % The player, "at" 3 variables, is at start position "start" 2 Variables, at timestep 0
            at(X,Y,0) :- start(X,Y).
            % The player chooses only one position from the possible "next" fields if it is not at the "goal" 2 variables, and the timestem T is less than the max steps S "maxsteps".
            1 { at(XX,YY,T+1) : next(X,Y,XX,YY) } 1 :- at(X,Y,T), not goal(X,Y), maxsteps(S), T < S.            
            % The minotaurs movements "mino_step" 5 variables depending of the possible "next" movement of the player.     
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
            % Show output predicate
            #show at/3. '''
}