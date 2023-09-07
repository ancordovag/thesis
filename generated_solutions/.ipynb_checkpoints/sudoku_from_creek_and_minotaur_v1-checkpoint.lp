% Generate all possible combinations of numbers and positions
1 { number(N,X,Y) : constant(X,Y), category(rows,X), category(columns,Y) } 1 :- constant(X,Y), category(rows,X), category(columns,Y), N = 1..9.

% The number N cannot appear twice in the same row
:- number(N,X,Y), number(N,X,Z), Y != Z, category(rows,X), category(columns,Y), category(columns,Z), not_in_row(N,X).

% The number N cannot appear twice in the same column
:- number(N,X,Y), number(N,Z,Y), X != Z, category(rows,X), category(rows,Z), category(columns,Y), not_in_column(N,Y).

% The number N cannot appear twice in the same 3x3 box
:- number(N,X,Y), number(N,Z,W), X != Z, Y != W, (X-1)//3 = (Z-1)//3, (Y-1)//3 = (W-1)//3, category(rows,X), category(rows,Z), category(columns,Y), category(columns,W), not_in_box(N,X,Y).

% Define a cell as filled if it contains a number
filled(X,Y) :- number(N,X,Y), category(rows,X), category(columns,Y).

% Define a cell as empty if it does not contain a number
empty(X,Y) :- not filled(X,Y), category(rows,X), category(columns,Y).
% Each cell must contain a number between 1 and 9
1 { cell(X,Y,N) : number(N) } 1 :- cell(X,Y).

% Each row must contain each number between 1 and 9 exactly once
:- cell(X,Y,N), cell(X,Y',N), Y != Y'.

% Each column must contain each number between 1 and 9 exactly once
:- cell(X,Y,N), cell(X',Y,N), X != X'.

% Each 3x3 box must contain each number between 1 and 9 exactly once
:- cell(X,Y,N), cell(X',Y',N), (X/3)*3+1 <= X', X' <= (X/3)*3+3, (Y/3)*3+1 <= Y', Y' <= (Y/3)*3+3, X != X', Y != Y'.