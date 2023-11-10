% All the possible values for each cell
possible_sudoku(X,Y,V) :- initial(X,Y,_), V = 1..9.

% Each row must contain all numbers from 1 to 9
possible_sudoku(X,Y,V) :- V = 1..9, X = 1..9, #count{N : sudoku(X,N,V)} = 1.

% Each column must contain all numbers from 1 to 9
possible_sudoku(X,Y,V) :- V = 1..9, Y = 1..9, #count{N : sudoku(N,Y,V)} = 1.

% Each 3x3 sub-grid must contain all numbers from 1 to 9
possible_sudoku(X,Y,V) :- V = 1..9, X = 1..9, Y = 1..9, #count{N : sudoku(X,Y,N), (X-1)//3 = (I-1)//3, (Y-1)//3 = (J-1)//3, sudoku(I,J,V)} = 1.