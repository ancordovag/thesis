% All cells can have any value from 1 to 9
possible_sudoku(X,Y,V) :- initial(X,Y,_), V = 1..9.