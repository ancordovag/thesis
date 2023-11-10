% Define the possible values for the starting cell
start_cell(X,Y) :- index_of_row(X), index_of_column(Y), not end_cell(X,Y).

% Define the possible values for the ending cell
end_cell(X,Y) :- index_of_row(X), index_of_column(Y), not start_cell(X,Y).

% Define the possible values for a cell with a positive number
number_cell(X,Y,N) :- index_of_row(X), index_of_column(Y), digits(N), not start_cell(X,Y), not end_cell(X,Y).

% Define the possible values for a cell with a bend in the path
bend_cell(X,Y) :- index_of_row(X), index_of_column(Y), not start_cell(X,Y), not end_cell(X,Y), not number_cell(X,Y,_).

% Define the possible values for a cell without a bend in the path
straight_cell(X,Y) :- index_of_row(X), index_of_column(Y), not start_cell(X,Y), not end_cell(X,Y), not number_cell(X,Y,_), not bend_cell(X,Y).

% Define the possible values for a cell that is part of the path
path_cell(X,Y) :- index_of_row(X), index_of_column(Y), not start_cell(X,Y), not end_cell(X,Y), not number_cell(X,Y,_), not bend_cell(X,Y), not straight_cell(X,Y).

% Show output predicates
#show start_cell/2.
#show end_cell/2.
#show number_cell/3.
#show bend_cell/2.
#show straight_cell/2.
#show path_cell/2.
% The starting cell must be part of the path
path_cell(X,Y) :- start_cell(X,Y).

% The ending cell must be part of the path
path_cell(X,Y) :- end_cell(X,Y).

% A cell with a positive number must be part of the path
path_cell(X,Y) :- number_cell(X,Y,N).

% A cell with a bend must be part of the path
path_cell(X,Y) :- bend_cell(X,Y).

% A cell without a bend must be part of the path
path_cell(X,Y) :- straight_cell(X,Y).

% The path cannot cross or intersect itself
:- path_cell(X,Y), path_cell(X,Y), (X,Y) != (X',Y').

% The path must start at the starting cell and end at the ending cell
:- path_cell(X,Y), not start_cell(X,Y).
:- path_cell(X,Y), not end_cell(X,Y).

% The path must traverse each remaining cell without crossing or intersecting itself
:- not path_cell(X,Y), (X,Y) != (X',Y').

% Between a cell with a positive number and the next cell with a number or the ending cell, the path must bend exactly as many times as the number indicates
:- number_cell(X,Y,N), not bend_cell(X,Y), count_bends(X,Y,N).

% The path must not bend between the starting cell and the first cell with a number
:- start_cell(X,Y), number_cell(X',Y',N), not bend_cell(X',Y').

% The path must not bend between the last cell with a number and the ending cell
:- number_cell(X,Y,N), end_cell(X',Y'), not bend_cell(X,Y).

% The path must not bend between two consecutive cells without a bend
:- straight_cell(X,Y), straight_cell(X',Y'), (X,Y) != (X',Y').

% The path must not have more than one bend in a cell
:- bend_cell(X,Y), bend_cell(X,Y), (X,Y) != (X',Y').

% The path must not have more than one straight cell in a row or column
:- straight_cell(X,Y), straight_cell(X',Y), (X,Y) != (X',Y).
:- straight_cell(X,Y), straight_cell(X,Y'), (X,Y) != (X,Y').

% The path must not have more than one bend cell in a row or column
:- bend_cell(X,Y), bend_cell(X',Y), (X,Y) != (X',Y).
:- bend_cell(X,Y), bend_cell(X,Y'), (X,Y) != (X,Y').

% The path must not have more than one number cell in a row or column
:- number_cell(X,Y,N), number_cell(X',Y,N), (X,Y) != (X',Y).
:- number_cell(X,Y,N), number_cell(X,Y',N), (X,Y) != (X,Y').