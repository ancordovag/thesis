                    % A cell is a possible target if it belongs to an area and there is a number that can be moved to it
            possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(P,Q,_), area(X,Y,_). 

            % A cell is a possible target if it belongs to an area with a goal and there is a number that can be moved to it
            possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(P,Q,N), area(X,Y,A), goal(A,G), N <= G.