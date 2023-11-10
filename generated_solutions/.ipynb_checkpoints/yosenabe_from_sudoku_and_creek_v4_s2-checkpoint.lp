% Define the possible directions
dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).

% Define the possible moves from a cell in a given direction
move(X,Y,DX,DY,P,Q) :- cell(X,Y), dir(DX,DY), P = X+DX, Q = Y+DY.

% Define the possible moves from a cell in any direction
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q).

% Define the possible moves from a cell in any direction until reaching a target cell
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), target(P,Q,_,_).

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), (target(P,Q,_,_) ; area(P,Q,_)).

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell, excluding the starting cell
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), (target(P,Q,_,_) ; area(P,Q,_)), not cell(X,Y).

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell, excluding the starting cell and the number cells
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), (target(P,Q,_,_) ; area(P,Q,_)), not cell(X,Y), not number(X,Y,_).

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell, excluding the starting cell and the number cells, and stopping at the first cell in the direction of the area
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), (target(P,Q,_,_) ; area(P,Q,_)), not cell(X,Y), not number(X,Y,_), not move(P,Q,DX,DY,_,_).

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell, excluding the starting cell and the number cells, and stopping at the first cell in the direction of the area, and stopping at the first cell in the direction of the area if it is a number cell
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), (target(P,Q,_,_) ; area(P,Q,_)), not cell(X,Y), not number(X,Y,_), not move(P,Q,DX,DY,_,_), not number(P,Q,_).

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell, excluding the starting cell and the number cells, and stopping at the first cell in the direction of the area, and stopping at the first cell in the direction of the area if it is a number cell, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), (target(P,Q,_,_) ; area(P,Q,_)), not cell(X,Y), not number(X,Y,_), not move(P,Q,DX,DY,_,_), not number(P,Q,_), not number(P,Q,N), number(X,Y,M), N != M.

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell, excluding the starting cell and the number cells, and stopping at the first cell in the direction of the area, and stopping at the first cell in the direction of the area if it is a number cell, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number and the number is not already in the area
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), (target(P,Q,_,_) ; area(P,Q,_)), not cell(X,Y), not number(X,Y,_), not move(P,Q,DX,DY,_,_), not number(P,Q,_), not number(P,Q,N), number(X,Y,M), N != M, not area(P,Q,A), goal(A,G), G != M.

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell, excluding the starting cell and the number cells, and stopping at the first cell in the direction of the area, and stopping at the first cell in the direction of the area if it is a number cell, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number and the number is not already in the area, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number and the number is not already in the area and the area is not already fulfilled
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), (target(P,Q,_,_) ; area(P,Q,_)), not cell(X,Y), not number(X,Y,_), not move(P,Q,DX,DY,_,_), not number(P,Q,_), not number(P,Q,N), number(X,Y,M), N != M, not area(P,Q,A), goal(A,G), G != M, not sum_area(A,G).

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell, excluding the starting cell and the number cells, and stopping at the first cell in the direction of the area, and stopping at the first cell in the direction of the area if it is a number cell, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number and the number is not already in the area, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number and the number is not already in the area and the area is not already fulfilled, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number and the number is not already in the area and the area is not already fulfilled and the area is not already visited
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), (target(P,Q,_,_) ; area(P,Q,_)), not cell(X,Y), not number(X,Y,_), not move(P,Q,DX,DY,_,_), not number(P,Q,_), not number(P,Q,N), number(X,Y,M), N != M, not area(P,Q,A), goal(A,G), G != M, not sum_area(A,G), not visit_area(A).

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell, excluding the starting cell and the number cells, and stopping at the first cell in the direction of the area, and stopping at the first cell in the direction of the area if it is a number cell, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number and the number is not already in the area, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number and the number is not already in the area and the area is not already fulfilled, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number and the number is not already in the area and the area is not already fulfilled and the area is not already visited, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number and the number is not already in the area and the area is not already fulfilled and the area is not already visited and the area is not already visited in the opposite direction
move(X,Y,P,Q) :- move(X,Y,DX,DY,P,Q), (target(P,Q,_,_) ; area(P,Q,_)), not cell(X,Y), not number(X,Y,_), not move(P,Q,DX,DY,_,_), not number(P,Q,_), not number(P,Q,N), number(X,Y,M), N != M, not area(P,Q,A), goal(A,G), G != M, not sum_area(A,G), not visit_area(A), not visit_area(A,-DX,-DY).

% Define the possible moves from a cell in any direction until reaching a target cell or an area cell, excluding the starting cell and the number cells, and stopping at the first cell in the direction of the area, and stopping at the first cell in the direction of the area if it is a number cell, and stopping at the first cell in the direction of the area if it is a number cell and the number is different from the current number, and stopping at the first cell in the direction of the area