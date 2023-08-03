%% Header
#const s=3.
subgrid_size(s).
value(1..s*s).
row(1..s*s).
column(1..s*s).
cell(X,Y) :- row(X), column(Y) .

%% Initialization
:- initial(X,Y,V), not sudoku(X,Y,V).

%% Generation
1 {sudoku(X,Y,V) : value(V) }  :- cell(X,Y).

%% Test
% No 2 values in the same cell
:- sudoku(X,Y,V), sudoku(X,Y,Z), V!=Z.
% No repetition in the column
:- sudoku(X,Y,V), sudoku(X,Y',V), Y!=Y'.
% No repetition in the row
:- sudoku(X,Y,V), sudoku(X',Y,V), X!=X'.
% No repetition in the subgrid
map(X,Y,S) :- cell(X,Y), S=(((X-1)/s)*s + (Y-1)/s).
:- sudoku(X,Y,V), sudoku(X',Y',V), X'!=X, Y != Y', cell(X,Y), cell(X',Y'), map(X,Y,S), map(X',Y',S).