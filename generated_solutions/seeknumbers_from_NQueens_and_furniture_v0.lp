% Define the constants in each category.
employee("Bonita"; "Yvette"; "Tabitha").
price(225; 275; 325).
wood_type("ash"; "poplar"; "sandalwood").
index_of_row(1; 2; 3; 4; 5; 6; 7; 8).
index_of_column(1; 2; 3; 4; 5; 6; 7; 8).
category("employee"; "price"; "wood_type").

% For each employee E, it matches with exactly 1 price P and 1 wood type W.
{match(E, P, W): price(P), wood_type(W)}=1 :- employee(E).

% For each row N1, there is exactly 1 queen assigned at some column N2.
{assign(N1, N2): index_of_column(N2)}=1 :- index_of_row(N1).

% Define the relations among the categories of constants.
relation(C, C1, C2, C3) :- category(C), constant_1(C1), constant_2(C2), constant_3(C3).
% No option in any category will ever be used more than once.
{E1=E2; P1=P2; W1=W2}=0 :- match(E1,P1,W1), match(E2,P2,W2), (E1,P1,W1)!=(E2,P2,W2).
% 1. Bonita’s piece costs $325. 
P=325 :- match(E,P,W), E="Bonita".
% 2. The item made of poplar costs more than Yvette’s piece.
P1>P2 :- match(E1,P1,W1), match(E2,P2,W2), W1="poplar", E2="Yvette".
% 3. Tabitha’s item costs 50 dollars less than the piece made of sandalwood.
P1=P2-50 :- match(E1,P1,W1), match(E2,P2,W2), E1="Tabitha", W2="sandalwood".
% 4. The $275 item is either the piece made of ash or Yvette’s item.
{W="ash"; E="Yvette"}=1 :- match(E,P,W), P=275.

% Each row can only have one queen.
:- assign(N1,N2), assign(N1,N3), N2 < N3.
% Each columns can only have one queen.
:- assign(N2,N1), assign(N3,N1), N2 < N3.
% No two queens can be on the same diagonal.
{Q1-Q2=R1-R2; Q1-Q2=R2-R1} = 0 :- assign(Q1,R1), assign(Q2,R2), Q1!=Q2.

% The path starts at the cell marked with a white circle and ends at the cell marked with a black circle.
first(X,Y) :- cell(X,Y), X=1, Y=1.
final(X,Y) :- cell(X,Y), X=8, Y=8.

% The path traverses each remaining cell of the square grid without ever crossing or intersecting itself.
:- cell(X,Y), not first(X,Y), not final(X,Y), not hint(X,Y), not path(X,Y).

% Between a cell with a (positive) number and the next cell with a number or the cell marked with a black circle, respectively, the path bends exactly as often as the number in the first cell indicates.
:- hint(X,Y,N), not path_bends(X,Y,N).

% The path does not bend between the cell marked with a white circle and the first cell with a number.
:- first(X1,Y1), hint(X2,Y2,_), path_bends(X1,Y1,N), N!=0.

% Every problem instance contains exactly one fact over first/2 and one fact over final/2.
{first(X,Y)}=1 :- cell(X,Y).
{final(X,Y)}=1 :- cell(X,Y).

% The square grid is represented by facts of the following predicates:
cell(X,Y).
first(X,Y).
final(X,Y).
hint(X,Y,N).