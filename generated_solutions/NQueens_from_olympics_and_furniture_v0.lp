% Define the constant in the category.
size(8).
% There is exactly 1 assignment for the size of the chessboard.
{assign(N)}=1 :- size(N).
% The size of the chessboard is a positive integer.
    N>0 :- assign(N).
    % Each row and column can only have one queen.
    {Q1=Q2; R1=R2} = 0 :- assign(Q1,R1), assign(Q2,R2), Q1!=Q2, R1!=R2.
    % No two queens can be on the same diagonal.
    {Q1-Q2=R1-R2; Q1-Q2=R2-R1} = 0 :- assign(Q1,R1), assign(Q2,R2), Q1!=Q2.