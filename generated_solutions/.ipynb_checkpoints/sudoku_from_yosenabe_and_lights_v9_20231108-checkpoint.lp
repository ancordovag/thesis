% Generate cells
cell(X,Y) :- X=1..9, Y=1..9.

% Generate values
value(V) :- V=1..9.

% Generate initial values
sudoku(X,Y,V) :- initial(X,Y,V).

% Generate possible values for empty cells
sudoku(X,Y,V) :- cell(X,Y), not initial(X,Y,_), value(V).