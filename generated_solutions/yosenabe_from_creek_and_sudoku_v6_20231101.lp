% A number can be moved from one cell to another
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), area(P,Q,_).

% A number can only be moved to a cell within the same area
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), area(X,Y,A), area(P,Q,A).

% A number can only be moved to a cell that is not already occupied by another number
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), not number(P,Q,_).

% A number can only be moved to a cell that is not already a target cell
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), not target(P,Q,_,_).

% A number can only be moved to a cell that is within the same row or column as the current cell
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), (X = P ; Y = Q).

% A number can only be moved to a cell that is not already occupied by another target cell
possible_target(X,Y,P,Q) :- cell(X,Y), cell(P,Q), number(X,Y,_), not target(_,_,P,Q).