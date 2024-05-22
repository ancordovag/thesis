                    % Generate cells
cell(X,Y) :- X=1..9, Y=1..9.
% Generate possible values
value(V) :- V=1..9.
% Initially filled cells
sudoku(X,Y,N) :- initial(X,Y,N).
% Possible values for the remaining cells
{ sudoku(X,Y,V) : value(V) } 1 :- cell(X,Y), not initial(X,Y).

% Each number appears exactly once in each row
1 { sudoku(X,Y,V) : cell(X,Y) } 1 :- value(V).
% Each number appears exactly once in each column
1 { sudoku(X,Y,V) : cell(X,Y) } 1 :- value(V).
% Each number appears exactly once in each 3x3 sub-grid
1 { sudoku(3*I+J,3*K+L,V) : I=0..2, J=0..2, K=0..2, L=0..2 } 1 :- value(V).

% Show output predicate
#show sudoku/3.