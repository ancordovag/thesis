
% The possible next movements of the player "next" of 4 variables, are defined as 2 adjacent fields, with "field" predicate of 2 variables, that do not have a "wall" (4 variables) between them)          
next(X1, Y1, X2, Y2) :- field(X1, Y1), field(X2, Y2), adjacent(X1, Y1, X2, Y2), not wall(X1, Y1, X2, Y2).
            % A "field" is "next" to itself 
next(X, Y, X, Y) :- field(X, Y).
            % If a field is next to another, then this second one is next to the first one
next(X2, Y2, X1, Y1) :- next(X1, Y1, X2, Y2).
            % The player, "at" 3 variables, is at start position "start" 2 Variables, at timestep 0
at(player, X, Y, 0) :- start(X, Y).
            % The player chooses only one position from the possible "next" fields if it is not at the "goal" 2 variables, and the timestem T is less than the max steps S "maxsteps".
1 {at(player, X2, Y2, T+1) : next(X1, Y1, X2, Y2)} 1 :- at(player, X1, Y1, T), not goal(X1, Y1), T < maxsteps.