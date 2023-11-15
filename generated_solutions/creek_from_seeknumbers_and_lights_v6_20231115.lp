                    % Possible black cells are those that are not hint cells
possible_black(X,Y) :- cell(X,Y), not hint(X,Y,_).