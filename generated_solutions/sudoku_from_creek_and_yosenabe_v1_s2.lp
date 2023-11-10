% Define all possible numbers
number(1). number(2). number(3). number(4). number(5). number(6). number(7). number(8). number(9).

% Define the cells in the grid
cell(X,Y) :- rows(X), columns(Y).

% Define the initial values of the cells
initial(X,Y,N) :- cell(X,Y), initial(X,Y,N).

% Define the constraints for each row
:- rows(X), number(N), not {initial(X,Y,N) : columns(Y)} = 1.

% Define the constraints for each column
:- columns(Y), number(N), not {initial(X,Y,N) : rows(X)} = 1.

% Define the constraints for each 3x3 subgrid
:- rows(X), columns(Y), number(N), not {initial(X+A,Y+B,N) : A=0..2, B=0..2} = 1.

% Show output predicate initial
#show initial/3.
% Constraint 1: Each cell must contain a number from 1 to 9
1 { cell(X,Y,N) : number(N) } 1 :- rows(X), columns(Y).

% Constraint 2: Each row must contain all numbers from 1 to 9
:- rows(X), number(N), not 1 { cell(X,Y,N) : columns(Y) } 1.

% Constraint 3: Each column must contain all numbers from 1 to 9
:- columns(Y), number(N), not 1 { cell(X,Y,N) : rows(X) } 1.

% Constraint 4: Each 3x3 sub-grid must contain all numbers from 1 to 9
:- rows(X), columns(Y), number(N), not 1 { cell(X1,Y1,N) : rows(X1), columns(Y1), X1 >= X, X1 < X + 3, Y1 >= Y, Y1 < Y + 3 } 1.

% Constraint 5: The initial values must be preserved
:- initial(X,Y,N), not cell(X,Y,N).