% Define the range of possible values for each cell
1 { value(X,Y,N) : cell(X,Y) } 9 :- cell(X,Y).

% A cell is filled with a number if it is an initial cell
filled(X,Y,N) :- initial(X,Y,N).

% A cell is filled with a number if it is filled with a number and that number is the only possible value for that cell
filled(X,Y,N) :- filled(X,Y,N), value(X,Y,N).

% A cell is not filled with a number if it is not filled with any number
not filled(X,Y,N) :- cell(X,Y), not filled(X,Y,_).

% A cell can be filled with a number if it is a cell and that number is a possible value for that cell
value(X,Y,N) :- cell(X,Y), value(X,Y,N).

% A cell can be filled with a number if it is a cell and that number is a possible value for that cell and that number is not filled in any other cell in the same row
value(X,Y,N) :- cell(X,Y), value(X,Y,N), not filled(X,_,N).

% A cell can be filled with a number if it is a cell and that number is a possible value for that cell and that number is not filled in any other cell in the same column
value(X,Y,N) :- cell(X,Y), value(X,Y,N), not filled(_,Y,N).

% A cell can be filled with a number if it is a cell and that number is a possible value for that cell and that number is not filled in any other cell in the same 3x3 block
value(X,Y,N) :- cell(X,Y), value(X,Y,N), not filled(X1,Y1,N), (X-1)//3 = (X1-1)//3, (Y-1)//3 = (Y1-1)//3.

% Show output predicates
#show filled/3.
% It cannot be the case that a cell is not filled
:- cell(X,Y), not filled(X,Y,_).
% It cannot be the case that a cell is filled with a number that is not between 1 and 9
:- filled(X,Y,N), not value(X,Y,N), N < 1.
:- filled(X,Y,N), not value(X,Y,N), N > 9.
% It cannot be the case that a cell is filled with a number that is already present in the same row
:- filled(X,Y,N), filled(X,YY,N), Y != YY.
% It cannot be the case that a cell is filled with a number that is already present in the same column
:- filled(X,Y,N), filled(XX,Y,N), X != XX.
% It cannot be the case that a cell is filled with a number that is already present in the same 3x3 sub-grid
:- filled(X,Y,N), filled(XX,YY,N), X != XX, Y != YY, (X-1)//3 == (XX-1)//3, (Y-1)//3 == (YY-1)//3.