% The possible values for each cell
1 { value(X,Y,V) : category(C), constant(C,V) } 1 :- field(X,Y).

% The value of each cell is unique within its row
:- value(X,Y,V), value(XX,Y,V), X != XX, same_row(X,Y,XX,Y).

% The value of each cell is unique within its column
:- value(X,Y,V), value(X,YY,V), Y != YY, same_column(X,Y,X,YY).

% The value of each cell is unique within its box
:- value(X,Y,V), value(XX,YY,V), same_box(X,Y,XX,YY).

% The possible values for each cell are the constants in the corresponding category
value(X,Y,V) :- field(X,Y), category(C), constant(C,V).

% The cell (X,Y) is in the same row as cell (XX,YY) if they have the same row constant
same_row(X,Y,XX,YY) :- field(X,Y), field(XX,YY), category(rows), value(X,Y,V), value(XX,YY,V).

% The cell (X,Y) is in the same column as cell (XX,YY) if they have the same column constant
same_column(X,Y,XX,YY) :- field(X,Y), field(XX,YY), category(columns), value(X,Y,V), value(XX,YY,V).

% The cell (X,Y) is in the same box as cell (XX,YY) if they have the same row and column constants
same_box(X,Y,XX,YY) :- field(X,Y), field(XX,YY), category(rows), category(columns), value(X,Y,V1), value(XX,YY,V2), V1 = V2.
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