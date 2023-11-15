% Define the range of numbers, rows and columns
num(1..9).
row(1..9).
col(1..9).

% Define the 3x3 sub-grids
subgrid(X,Y,I,J) :- num(X), num(Y), num(I), num(J), X = 3*((I-1)/3)+((J-1)/3)+1, Y = 3*((I-1) mod 3)+((J-1) mod 3)+1.

% Each cell in the grid must contain a number
1 { cell(I,J,N) : num(N) } 1 :- row(I), col(J).

% Each number can only appear once in each row
:- row(I), num(N), 1 < #count{ col(J) : cell(I,J,N) }.

% Each number can only appear once in each column
:- col(J), num(N), 1 < #count{ row(I) : cell(I,J,N) }.

% Each number can only appear once in each 3x3 sub-grid
:- subgrid(X,Y,I,J), num(N), 1 < #count{ row(I), col(J) : cell(I,J,N) }.

% The initial state of the grid
cell(I,J,N) :- initial(I,J,N).                    % A number cannot appear more than once in a row
:- row(I), num(N), 1 < #count{ col(J) : cell(I,J,N) }.
% A number cannot appear more than once in a column
:- col(J), num(N), 1 < #count{ row(I) : cell(I,J,N) }.
% A number cannot appear more than once in a 3x3 sub-grid
:- subgrid(X,Y,I,J), num(N), 1 < #count{ row(I), col(J) : cell(I,J,N) }.
% A cell cannot contain more than one number
:- row(I), col(J), 1 < #count{ num(N) : cell(I,J,N) }. 
% A cell cannot be empty
:- row(I), col(J), 0 == #count{ num(N) : cell(I,J,N) }. 
% The initial state of the grid cannot be changed
:- initial(I,J,N), not cell(I,J,N).