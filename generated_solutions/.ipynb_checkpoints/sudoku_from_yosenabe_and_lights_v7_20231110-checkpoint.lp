                    % Generate cells
cell(X,Y) :- X=1..9, Y=1..9.
% Possible values for each cell
possible_sudoku(X,Y,V) :- cell(X,Y), V=1..9.