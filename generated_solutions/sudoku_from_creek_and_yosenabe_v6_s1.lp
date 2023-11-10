% Define the domain of the grid
1 { cell(X,Y,V) : V = 1..9 } 1 :- cell(X,Y).

% Each row should contain all numbers from 1 to 9
:- cell(X,Y,V), cell(X,Y',V), Y != Y'.

% Each column should contain all numbers from 1 to 9
:- cell(X,Y,V), cell(X',Y,V), X != X'.

% Each 3x3 sub-grid should contain all numbers from 1 to 9
:- cell(X,Y,V), cell(X+A,Y+B,V), A != 0, B != 0, A <= 2, B <= 2, X' = X + A, Y' = Y + B, cell(X',Y',V).

% The initial grid should be partially filled
:- initial(X,Y,V), not cell(X,Y,V).

% The grid should be filled with numbers from 1 to 9
:- cell(X,Y,V), V != 1..9.

% The same number should not appear twice in the same row
:- cell(X,Y,V), cell(X,Y',V), Y != Y'.

% The same number should not appear twice in the same column
:- cell(X,Y,V), cell(X',Y,V), X != X'.

% The same number should not appear twice in the same 3x3 sub-grid
:- cell(X,Y,V), cell(X+A,Y+B,V), A != 0, B != 0, A <= 2, B <= 2, X' = X + A, Y' = Y + B, cell(X',Y',V).