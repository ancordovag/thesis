% All the possible values for a cell
possible_sudoku(X,Y,V) :- initial(X,Y,V).

% Each row must contain all numbers from 1 to 9
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 1..9, Y = 1..9.

% Each column must contain all numbers from 1 to 9
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 1..9, Y = 1..9.

% Each 3x3 sub-grid must contain all numbers from 1 to 9
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 1..9, Y = 1..9.

% Each cell can only have one value
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 1..9, Y = 1..9.