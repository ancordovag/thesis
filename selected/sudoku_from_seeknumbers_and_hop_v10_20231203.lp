                    % Generate cells
cell(X,Y) :- X=1..9, Y=1..9.
% Generate possible values
value(V) :- V=1..9.
% Initially filled cells
sudoku(X,Y,N) :- initial(X,Y,N).
% Possible values for the remaining cells
{ sudoku(X,Y,V) : value(V) } 1 :- cell(X,Y), not initial(X,Y).
% Each number appears once in each row
:- cell(X,_), value(V), #count { Y : sudoku(X,Y,V) } != 1.
% Each number appears once in each column
:- cell(_,Y), value(V), #count { X : sudoku(X,Y,V) } != 1.
% Each number appears once in each 3x3 sub-grid
:- value(V), X1=1..3, Y1=1..3, #count { X,Y : sudoku(X,Y,V), X=X1..X1+2, Y=Y1..Y1+2 } != 1.

% Show output predicate
#show sudoku/3.