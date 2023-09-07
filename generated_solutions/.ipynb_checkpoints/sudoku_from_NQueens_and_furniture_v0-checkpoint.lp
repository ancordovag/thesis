% Define the constants in each category.
row(1; 2; 3; 4; 5; 6; 7; 8; 9).
column(1; 2; 3; 4; 5; 6; 7; 8; 9).
digit(1; 2; 3; 4; 5; 6; 7; 8; 9).
box(1; 2; 3; 4; 5; 6; 7; 8; 9).

% For each row R and column C, there is exactly 1 digit D filled.
{fill(R, C, D): digit(D)}=1 :- row(R), column(C).

% For each row R and column C, there is exactly 1 box B assigned.
{assign_box(R, C, B): box(B)}=1 :- row(R), column(C).
% Each cell can only have one digit.
:- fill(R, C, D1), fill(R, C, D2), D1 != D2.
% Each row can only have one of each digit.
:- fill(R, C1, D), fill(R, C2, D), C1 != C2.
% Each column can only have one of each digit.
:- fill(R1, C, D), fill(R2, C, D), R1 != R2.
% Each box can only have one of each digit.
:- assign_box(R1, C1, B), assign_box(R2, C2, B), fill(R1, C1, D), fill(R2, C2, D), (R1, C1) != (R2, C2).
% Each cell must have a digit from 1 to 9.
fill(R, C, D) :- digit(D), row(R), column(C).
% Each cell must be assigned to a box.
assign_box(R, C, B) :- row(R), column(C), box(B).