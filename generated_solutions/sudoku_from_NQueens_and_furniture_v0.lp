% Define the constants in each category.
row(1; 2; 3; 4; 5; 6; 7; 8; 9).
column(1; 2; 3; 4; 5; 6; 7; 8; 9).
digit(1; 2; 3; 4; 5; 6; 7; 8; 9).
% For each cell [R, C], there is exactly 1 digit D assigned.
{assign(R, C, D): digit(D)}=1 :- row(R), column(C).
% Each row can only have one occurrence of each digit.
:- assign(R, C1, D), assign(R, C2, D), C1 != C2.
% Each column can only have one occurrence of each digit.
:- assign(R1, C, D), assign(R2, C, D), R1 != R2.
% Each 3x3 box can only have one occurrence of each digit.
:- assign(R1, C1, D), assign(R2, C2, D), R1/3 = R2/3, C1/3 = C2/3, (R1, C1) != (R2, C2).