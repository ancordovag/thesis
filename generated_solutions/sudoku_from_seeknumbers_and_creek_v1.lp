% Define the possible values for a cell
value(X,Y,V) :- cell(X,Y), V=1..9.

% Define the constraints for each row
:- row(X), value(X,Y,V1), value(X,Y,V2), V1!=V2.

% Define the constraints for each column
:- column(Y), value(X,Y,V1), value(X,Y,V2), V1!=V2.

% Define the constraints for each subgrid
:- subgrid(X,Y), value(X1,Y1,V), value(X2,Y2,V), (X1,Y1) != (X2,Y2).

% Show output predicate value
#show value/3.
% It cannot be the case that a cell has a value that is not between 1 and 9
:- value(X,Y,V), V < 1.
:- value(X,Y,V), V > 9.

% It cannot be the case that a row has duplicate values
:- category(rows), constant_1 = X, constant_2 = Y, value(X,Y,V1), value(X,Y2,V2), Y != Y2, V1 = V2.

% It cannot be the case that a column has duplicate values
:- category(columns), constant_1 = X, constant_2 = Y, value(X,Y,V1), value(X2,Y,V2), X != X2, V1 = V2.

% It cannot be the case that a 3x3 sub-grid has duplicate values
:- category(rows), constant_1 = X, constant_2 = Y, value(X,Y,V1), value(X2,Y2,V2), X != X2, Y != Y2, (X-1)//3 = (X2-1)//3, (Y-1)//3 = (Y2-1)//3, V1 = V2.