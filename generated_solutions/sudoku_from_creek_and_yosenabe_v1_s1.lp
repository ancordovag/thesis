% Define all possible values for a cell
value(X,Y,V) :- cell(X,Y), V = 1..9.

% Define all possible sub-grids
subgrid(X,Y,G) :- cell(X,Y), G = 1..3.

% Each row must have distinct values
:- value(X,Y,V), value(X,Y',V), Y != Y'.

% Each column must have distinct values
:- value(X,Y,V), value(X',Y,V), X != X'.

% Each sub-grid must have distinct values
:- value(X,Y,V), value(X',Y',V), subgrid(X,Y,G), subgrid(X',Y',G), (X,Y) != (X',Y').

#show value/3.
% Each cell must have a value between 1 and 9
1 { value(X,Y,V) : V = 1..9 } 1 :- cell(X,Y).

% Each row must contain all numbers from 1 to 9
:- value(X,Y,V), value(X,Y,V2), V != V2.

% Each column must contain all numbers from 1 to 9
:- value(X,Y,V), value(X2,Y,V), X != X2.

% Each sub-grid must contain all numbers from 1 to 9
:- value(X,Y,V), value(X2,Y2,V), subgrid(X,Y,G), subgrid(X2,Y2,G), (X,Y) != (X2,Y2).