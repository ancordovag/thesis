% Generate all possible starting cells
start(X,Y) :- index_of_row(X), index_of_column(Y).

% Generate all possible ending cells
end(X,Y) :- index_of_row(X), index_of_column(Y).

% Generate all possible cells with a number
number(X,Y,N) :- index_of_row(X), index_of_column(Y), digits(N).

% Generate all possible cells with a bend
bend(X,Y) :- index_of_row(X), index_of_column(Y).

% Generate all possible cells without a bend
straight(X,Y) :- index_of_row(X), index_of_column(Y).

% Generate all possible horizontal paths between two cells
horizontal(X1,Y,X2) :- index_of_row(X1), index_of_row(X2), index_of_column(Y), X1 != X2.

% Generate all possible vertical paths between two cells
vertical(X,Y1,Y2) :- index_of_row(X), index_of_column(Y1), index_of_column(Y2), Y1 != Y2.

% Show output predicates
#show start/2.
#show end/2.
#show number/3.
#show bend/2.
#show straight/2.
#show horizontal/3.
#show vertical/3.
% The starting cell must be visited
:- not visit(X,Y), start(X,Y).

% The ending cell must be visited
:- not visit(X,Y), end(X,Y).

% A cell with a number must be visited
:- number(X,Y,N), not visit(X,Y).

% A cell with a bend must be visited
:- bend(X,Y), not visit(X,Y).

% A cell without a bend must be visited
:- straight(X,Y), not visit(X,Y).

% A horizontal path between two cells must be visited
:- horizontal(X1,Y,X2), not visit(X1,Y), not visit(X2,Y).

% A vertical path between two cells must be visited
:- vertical(X,Y1,Y2), not visit(X,Y1), not visit(X,Y2).

% The path cannot cross or intersect itself
:- visit(X,Y), visit(X,Y), visit(X,Y), visit(X,Y), X != X, Y != Y.

% The path must start at the starting cell
:- visit(X,Y), start(X,Y), not visit(X,Y).

% The path must end at the ending cell
:- visit(X,Y), end(X,Y), not visit(X,Y).

% The path must traverse each remaining cell without crossing or intersecting itself
:- visit(X,Y), not visit(X,Y), not visit(X,Y), not visit(X,Y).

% The path must bend exactly as often as the number in the first cell indicates
:- number(X1,Y,N), number(X2,Y,N), not bend(X1,Y), not bend(X2,Y).

% The path must not bend between the starting cell and the first cell with a number
:- start(X1,Y), number(X2,Y,N), not straight(X1,Y), not straight(X2,Y).