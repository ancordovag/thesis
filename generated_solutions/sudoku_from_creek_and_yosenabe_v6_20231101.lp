% All the possible values for each cell
possible_sudoku(X,Y,V) :- initial(X,Y,V).

% Each row must contain all numbers from 1 to 9
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 1..9.

% Each column must contain all numbers from 1 to 9
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, Y = 1..9.

% Each 3x3 sub-grid must contain all numbers from 1 to 9
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 1..3, Y = 1..3.
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 4..6, Y = 1..3.
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 7..9, Y = 1..3.
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 1..3, Y = 4..6.
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 4..6, Y = 4..6.
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 7..9, Y = 4..6.
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 1..3, Y = 7..9.
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 4..6, Y = 7..9.
possible_sudoku(X,Y,V) :- V = #count{N : sudoku(X,Y,N)}, X = 7..9, Y = 7..9.