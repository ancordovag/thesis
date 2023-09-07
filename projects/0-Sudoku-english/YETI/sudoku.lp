
subgrid_size(3).
number(1..X*X) :- subgrid_size(X).

1 { sudoku(A,B,X) : number(X) } 1 :- number(A), number(B).

:- sudoku(A,B,X), sudoku(A,BB,X), B < BB.
:- sudoku(A,B,X), sudoku(AA,B,X), A < AA.
:- sudoku(A,B,X), sudoku(AA,BB,X), (A,B) != (AA,BB), 
   (A-1)/Z=(AA-1)/Z, (B-1)/Z=(BB-1)/Z, subgrid_size(Z).

sudoku(A,B,X) :- initial(A,B,X).

#show sudoku/3.

