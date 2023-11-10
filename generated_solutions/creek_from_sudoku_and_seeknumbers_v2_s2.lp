% Generate all possible combinations of blackened cells for each hint
1 { black(X,Y) : cell(X,Y) } 1 :- hint(X,Y,N).

% Generate all possible combinations of non-blackened cells for each hint
1 { white(X,Y) : cell(X,Y) } 1 :- hint(X,Y,0).

% Generate all possible combinations of blackened and non-blackened cells for each hint
1 { black(X,Y) : cell(X,Y) } 1 :- hint(X,Y,N), N>0.
1 { white(X,Y) : cell(X,Y) } 1 :- hint(X,Y,N), N>0.

% Generate all possible combinations of blackened and non-blackened cells for each cell
1 { black(X,Y) : cell(X,Y) } 1 :- cell(X,Y).
1 { white(X,Y) : cell(X,Y) } 1 :- cell(X,Y).

% Generate all possible combinations of blackened and non-blackened cells for each adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 { white(XX,YY) : cell(XX,YY) } 1 :- white(X,Y), not neighbour(X,Y,XX,YY).

% Generate all possible combinations of blackened and non-blackened cells for each non-adjacent cell
1 { black(XX,YY) : cell(XX,YY) } 1 :- black(X,Y), not neighbour(X,Y,XX,YY).
1 {
% For each cell, it must be either blackened or white
:- cell(X,Y), not blackened(X,Y), not white(X,Y).

% For each cell, if it is blackened, it must have a hint number
:- blackened(X,Y), not hint(X,Y,_).

% For each cell, if it is white, it cannot have a hint number
:- white(X,Y), hint(X,Y,_).

% For each cell, if it has a hint number, it must be either blackened or white
:- hint(X,Y,_), not blackened(X,Y), not white(X,Y).

% For each cell, if it is blackened, it must have the correct number of blackened neighbors
:- blackened(X,Y), hint(X,Y,N), not blackened_neighbors(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors
:- white(X,Y), blackened_neighbors(X,Y,_).

% For each cell, if it has a hint number, it must have the correct number of blackened neighbors
:- hint(X,Y,N), not blackened_neighbors(X,Y,N).

% For each cell, if it has a hint number, it cannot have any white neighbors
:- hint(X,Y,_), white_neighbors(X,Y,_).

% For each cell, if it is blackened, it cannot have any white neighbors
:- blackened(X,Y), white_neighbors(X,Y,_).

% For each cell, if it is white, it must have at least one white neighbor
:- white(X,Y), not white_neighbors(X,Y,_).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any blackened neighbors that are not adjacent
:- white(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any white neighbors that are not adjacent
:- blackened(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white, it cannot have any white neighbors that are not adjacent
:- white(X,Y), white_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is blackened, it cannot have any blackened neighbors that are not adjacent
:- blackened(X,Y), blackened_neighbors(X,Y,N), not adjacent(X,Y,N).

% For each cell, if it is white