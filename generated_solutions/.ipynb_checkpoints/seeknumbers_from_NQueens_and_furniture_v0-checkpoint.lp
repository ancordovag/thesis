% Define the constants in each category.
cell_marked_with_white_circle("white circle").
cell_marked_with_black_circle("black circle").
% For each cell W, there is exactly 1 directed path to some cell B.
{construct_path(W, B): cell_marked_with_black_circle(B)}=1 :- cell_marked_with_white_circle(W).
% The path from cell W to cell B exists if and only if cell W is adjacent to cell B.
construct_path(W, B) :- adjacent(W, B).
% The path from cell W to cell B exists if and only if there is a cell C such that cell W is adjacent to cell C and there is a path from cell C to cell B.
construct_path(W, B) :- adjacent(W, C), construct_path(C, B).