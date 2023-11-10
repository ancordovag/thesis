% Each cell should contain a value between 1 and 9
1 { cell(X,Y,V) : V=1..9 } 1 :- cell(X,Y).

% Each row should contain unique values
:- row(R), V=1..9, not 1 { cell(X,R,V) : X=1..9 } 1.

% Each column should contain unique values
:- column(C), V=1..9, not 1 { cell(C,Y,V) : Y=1..9 } 1.

% Each sub-grid should contain unique values
:- subgrid(SG), V=1..9, not 1 { cell(X,Y,V) : in_subgrid(X,Y,SG) } 1.

% Define the sub-grid that a cell belongs to
in_subgrid(X,Y,SG) :- X=1..3, Y=1..3, SG=1.
in_subgrid(X,Y,SG) :- X=4..6, Y=1..3, SG=2.
in_subgrid(X,Y,SG) :- X=7..9, Y=1..3, SG=3.
in_subgrid(X,Y,SG) :- X=1..3, Y=4..6, SG=4.
in_subgrid(X,Y,SG) :- X=4..6, Y=4..6, SG=5.
in_subgrid(X,Y,SG) :- X=7..9, Y=4..6, SG=6.
in_subgrid(X,Y,SG) :- X=1..3, Y=7..9, SG=7.
in_subgrid(X,Y,SG) :- X=4..6, Y=7..9, SG=8.
in_subgrid(X,Y,SG) :- X=7..9, Y=7..9, SG=9.

% Show output predicate cell
#show cell/3.
% It cannot be the case that a cell contains a value that is not between 1 and 9
:- cell(X,Y,V), V < 1, V > 9.
% It cannot be the case that a row contains duplicate values
:- row(R), cell(X1,R,V), cell(X2,R,V), X1 != X2.
% It cannot be the case that a column contains duplicate values
:- column(C), cell(C,Y1,V), cell(C,Y2,V), Y1 != Y2.
% It cannot be the case that a sub-grid contains duplicate values
:- subgrid(SG), cell(X1,Y1,V), cell(X2,Y2,V), X1 != X2, Y1 != Y2, in_subgrid(X1,Y1,SG), in_subgrid(X2,Y2,SG).