% Define the constants in each category.
index_of_row(1; 2; 3; 4; 5; 6; 7; 8).
index_of_column(1; 2; 3; 4; 5; 6; 7; 8).
% For each index_of_row Ir, it matches with exactly 1 index_of_column Ic.
{assign(Ir, Ic): index_of_column(Ic)}=1 :- index_of_row(Ir).
% No two queens can be in the same row or column.
{Ir1=Ir2; Ic1=Ic2}=0 :- assign(Ir1, Ic1), assign(Ir2, Ic2), (Ir1, Ic1) != (Ir2, Ic2).
% No two queens can be in the same diagonal.
{Ir1-Ic1=Ir2-Ic2; Ir1+Ic1=Ir2+Ic2}=0 :- assign(Ir1, Ic1), assign(Ir2, Ic2), (Ir1, Ic1) != (Ir2, Ic2).