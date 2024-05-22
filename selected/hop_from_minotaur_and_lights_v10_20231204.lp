                    % Define fields at the combination of a row X and a column Y if this combination X,Y is not empty 
            field(X,Y) :- rows(R), cols(C), X = 1..R, Y = 1..C, not empty(X,Y).
            % Define the possible distances from a field, as delta
            delta(1,0). delta(-1,0). delta(0,1). delta(0,-1).
            % Define neighbors for each field given a delta
            neighbor(X1,Y1,X2,Y2,DX,DY) :- field(X1,Y1), field(X2,Y2), delta(DX,DY), X2 = X1+DX, Y2 = Y1+DY.
            % Neighbors that are not digits are defined as reach, to indicate that one field is reachable from the other one.
            reach(X1,Y1,X2,Y2,DX,DY) :- neighbor(X1,Y1,X2,Y2,DX,DY), not digit(X1,Y1), not digit(X2,Y2).
            % Transitive property of relation "reach": all fields that are neighbours in the same direction (DX,DY), have a relation reach
            reach(X1,Y1,X3,Y3,DX,DY) :- neighbor(X2,Y2,X3,Y3,DX,DY), reach(X1,Y1,X2,Y2,DX,DY), not digit(X3,Y3).

            % Generate minimum 0 predicate step for field(X,Y) if this is not a digit.  
            { step(X,Y) } :- field(X,Y), not digit(X,Y).

            % Mark a field as stepped
            stepped(X2,Y2) :- step(X1,Y1), reach(X1,Y1,X2,Y2,DX,DY).

            % Cannnot be the case that a field with a step is not stepped
            :- step(X,Y), stepped(X,Y).
            % Cannot be the case that a field is not digit and is not stepped
            :- field(X,Y), not digit(X,Y), not step(X,Y), not stepped(X,Y).
            % A field with a difit N must have exactly N neighbors that are step
            :- digit(X1,Y1,N), not N { step(X2,Y2) : neighbor(X1,Y1,X2,Y2,DX,DY) } N.

            % Show output predicate
            #show step/2.