% Generate all possible values for each cell
1 { value(X,Y,V) : constant_1(V) } 1 :- cell(X,Y).

% Generate the same_row predicate for each pair of cells in the same row
same_row(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), X = XX, Y != YY.

% Generate the same_column predicate for each pair of cells in the same column
same_column(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), X != XX, Y = YY.

% Generate the same_box predicate for each pair of cells in the same box
same_box(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), X/3 = XX/3, Y/3 = YY/3.
% Each cell must have a value between 1 and 9
1 { value(X,Y,V) : V = 1..9 } 1 :- category(X), category(Y).

% Each row must have unique values
:- value(X,Y,V), value(X,YY,V), Y != YY.

% Each column must have unique values
:- value(X,Y,V), value(XX,Y,V), X != XX.

% Each box must have unique values
:- value(X,Y,V), value(XX,YY,V), same_box(X,Y,XX,YY), X != XX, Y != YY.

% The initial values are given
value(X,Y,V) :- initial_value(X,Y,V).

% Optimization: minimize the number of filled cells
#minimize{ 1 : value(X,Y,V) }.

% The solution is complete when all cells are filled
:- category(X), category(Y), not value(X,Y,V).