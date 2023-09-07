% Generate all possible combinations of numbers and positions
1 { number(N,X,Y) : constant(X,Y), category(N) } 1 :- category(N), constant(X,Y).

% A number can only appear once in a row
:- number(N,X,Y), number(N,X,Z), Y != Z.

% A number can only appear once in a column
:- number(N,X,Y), number(N,Z,Y), X != Z.

% A number can only appear once in a 3x3 box
:- number(N,X,Y), number(N,Z,W), (X/3)*3 + (Y/3) = (Z/3)*3 + (W/3), (X%3)*3 + (Y%3) = (Z%3)*3 + (W%3), (X,Y) != (Z,W).

% A number cannot appear twice in the same row
not_in_row(N,X) :- number(N,X,Y), number(N,X,Z), Y != Z.

% A number cannot appear twice in the same column
not_in_column(N,Y) :- number(N,X,Y), number(N,Z,Y), X != Z.

% A number cannot appear twice in the same 3x3 box
not_in_box(N,X,Y) :- number(N,X,Y), number(N,Z,W), (X/3)*3 + (Y/3) = (Z/3)*3 + (W/3), (X%3)*3 + (Y%3) = (Z%3)*3 + (W%3), (X,Y) != (Z,W).
% Each cell must contain a number between 1 and 9
1 { cell(X,Y,N) : number(N) } 1 :- cell(X,Y).

% Each row must contain each number between 1 and 9 exactly once
:- cell(X,Y,N), cell(X,Y',N), Y != Y'.

% Each column must contain each number between 1 and 9 exactly once
:- cell(X,Y,N), cell(X',Y,N), X != X'.

% Each 3x3 box must contain each number between 1 and 9 exactly once
:- cell(X,Y,N), cell(X',Y',N), (X/3)*3+1 <= X', X' <= (X/3)*3+3, (Y/3)*3+1 <= Y', Y' <= (Y/3)*3+3, X != X', Y != Y'.