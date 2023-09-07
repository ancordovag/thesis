% Define the possible digits
digit(1). digit(2). digit(3). digit(4). digit(5). digit(6). digit(7). digit(8). digit(9).

% Define the possible rows and columns
row(1). row(2). row(3). row(4). row(5). row(6). row(7). row(8). row(9).
col(1). col(2). col(3). col(4). col(5). col(6). col(7). col(8). col(9).

% Define the possible boxes
box(1). box(2). box(3). box(4). box(5). box(6). box(7). box(8). box(9).

% Define the possible values for each cell
1 { match(Ir,Ic,D) : digit(D) } 1 :- row(Ir), col(Ic).

% Define the constraint that the same number cannot appear twice in the same row
:- match(Ir,Ic,D), match(Ir,Ic2,D), col(Ic), col(Ic2), Ic != Ic2.

% Define the constraint that the same number cannot appear twice in the same column
:- match(Ir,Ic,D), match(Ir2,Ic,D), row(Ir), row(Ir2), Ir != Ir2.

% Define the constraint that the same number cannot appear twice in the same box
:- match(Ir,Ic,D), match(Ir2,Ic2,D), row(Ir), row(Ir2), col(Ic), col(Ic2), box(B), box(Ir,Ic,B), box(Ir2,Ic2,B), (Ir,Ic) != (Ir2,Ic2).

% Define the box predicate to determine which cells are in the same box
box(Ir,Ic,B) :- row(Ir), col(Ic), B = (Ir-1)//3*3 + (Ic-1)//3 + 1.
% Constraint 1: The same number cannot appear twice in the same row
:- match(Ir1,Ic,D), match(Ir2,Ic,D), Ir1 = Ir2.

% Constraint 2: The same number cannot appear twice in the same column
:- match(Ir,Ic1,D), match(Ir,Ic2,D), Ic1 = Ic2.

% Constraint 3: The same number cannot appear twice in the same 3x3 box
:- match(Ir1,Ic1,D), match(Ir2,Ic2,D), Ir1/3 = Ir2/3, Ic1/3 = Ic2/3, (Ir1 != Ir2 ; Ic1 != Ic2).

% Show the output predicate
#show match/3.