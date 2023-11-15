                    % Generate cells
            cell(X,Y) :- X=1..9, Y=1..9.
            % Generate possible values
            value(V) :- V=1..9.
            % Possible sudoku values could be set in cells that are not initially filled
            possible_sudoku(X,Y,V) :- cell(X,Y), value(V), not initial(X,Y,_).