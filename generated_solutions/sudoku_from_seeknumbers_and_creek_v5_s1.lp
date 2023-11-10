% Define the domain of the grid
1 { cell(X,Y,V) : V = 1..9 } 1 :- cell(X,Y).

% Define the constraints for each row
:- cell(X,Y,V), cell(X,Z,V), Y != Z.

% Define the constraints for each column
:- cell(X,Y,V), cell(Z,Y,V), X != Z.

% Define the constraints for each 3x3 sub-grid
:- cell(X,Y,V), cell(X+A,Y+B,V), A != 0, B != 0, A <= 2, B <= 2, (X-1) % 3 + A = X, (Y-1) % 3 + B = Y.

% Define the initial values of the grid
cell(X,Y,V) :- initial(X,Y,V).% It cannot be the case that a cell has more than one value
:- cell(X,Y,V1), cell(X,Y,V2), V1 != V2.

% It cannot be the case that a cell is not filled
:- cell(X,Y), not filled(X,Y).

% It cannot be the case that a cell violates the constraints for each row
:- cell(X,Y,V), cell(X,Z,V), Y != Z.

% It cannot be the case that a cell violates the constraints for each column
:- cell(X,Y,V), cell(Z,Y,V), X != Z.

% It cannot be the case that a cell violates the constraints for each 3x3 sub-grid
:- cell(X,Y,V), cell(X+A,Y+B,V), A != 0, B != 0, A <= 2, B <= 2, (X-1) % 3 + A = X, (Y-1) % 3 + B = Y.

% It cannot be the case that a cell does not have an initial value
:- initial(X,Y,V), not cell(X,Y,V).