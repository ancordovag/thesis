% Define the possible values for a cell
1 { value(X,Y,V) : cell(X,Y), V=1..9 } 1.

% Define the constraints for rows and columns
:- value(X,Y,V), value(X,YY,V), Y!=YY.
:- value(X,Y,V), value(XX,Y,V), X!=XX.

% Define the constraints for sub-grids
:- value(X,Y,V), value(XX,YY,V), subgrid(X,Y,G), subgrid(XX,YY,G), X!=XX, Y!=YY.

% Define the sub-grids
subgrid(X,Y,G) :- G = (X-1)//3 + 3*((Y-1)//3) + 1.

% Show output predicate value
#show value/3.
% It cannot be the case that a cell has a value that is not between 1 and 9
:- value(X,Y,V), V < 1.
:- value(X,Y,V), V > 9.
% It cannot be the case that a row has duplicate values
:- value(X,Y,V), value(X,YY,V), Y != YY.
% It cannot be the case that a column has duplicate values
:- value(X,Y,V), value(XX,Y,V), X != XX.
% It cannot be the case that a sub-grid has duplicate values
:- value(X,Y,V), value(XX,YY,V), subgrid(X,Y,G), subgrid(XX,YY,G), (X != XX ; Y != YY).