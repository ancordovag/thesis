% Generate all possible combinations of blackened cells for each hint
1 { black(X,Y) : cell(X,Y) } 1 :- hint(X,Y,N).

% Generate a predicate to check if a cell is white
white(X,Y) :- cell(X,Y), not black(X,Y).

% Generate a predicate to check if a cell is connected to another white cell
connected(X,Y) :- white(X,Y), connected(X,Y,_).

% Generate a predicate to check if a cell is connected to another white cell in a specific direction
connected(X,Y,D) :- white(X,Y), neighbour(X,Y,XX,YY,D), white(XX,YY), not connected(XX,YY,D).

% Generate a predicate to check if a cell is connected to another white cell in any direction
connected(X,Y) :- white(X,Y), connected(X,Y,_).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified direction
connected(X,Y,D) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D!=DD, not connected(XX,YY,D).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, not connected(XX,YY,D1,D2).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, not connected(XX,YY,D1,D2,D3).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, not connected(XX,YY,D1,D2,D3,D4).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, not connected(XX,YY,D1,D2,D3,D4,D5).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6,D7).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7,D8) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, D8!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6,D7,D8).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7,D8,D9) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, D8!=DD, D9!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6,D7,D8,D9).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, D8!=DD, D9!=DD, D10!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, D8!=DD, D9!=DD, D10!=DD, D11!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, D8!=DD, D9!=DD, D10!=DD, D11!=DD, D12!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, D8!=DD, D9!=DD, D10!=DD, D11!=DD, D12!=DD, D13!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, D8!=DD, D9!=DD, D10!=DD, D11!=DD, D12!=DD, D13!=DD, D14!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, D8!=DD, D9!=DD, D10!=DD, D11!=DD, D12!=DD, D13!=DD, D14!=DD, D15!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, D8!=DD, D9!=DD, D10!=DD, D11!=DD, D12!=DD, D13!=DD, D14!=DD, D15!=DD, D16!=DD, not connected(XX,YY,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16).

% Generate a predicate to check if a cell is connected to another white cell in any direction except the specified directions
connected(X,Y,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17) :- white(X,Y), neighbour(X,Y,XX,YY,DD), white(XX,YY), D1!=DD, D2!=DD, D3!=DD, D4!=DD, D5!=DD, D6!=DD, D7!=DD, D8!=DD, D9!=DD, D10!=DD, D11!=DD, D12!=DD, D13!=DD, D14!=DD, D15!=DD, D
% It cannot be the case that a cell is not visited
:- cell(X,Y), not visited(X,Y).
% It cannot be the case that a hint is not satisfied
:- hint(X,Y,N), not satisfied(X,Y,N).
% A cell is satisfied if the number of blackened cells adjacent to it is equal to the hint number
satisfied(X,Y,N) :- count_blackened(X,Y,C), C = N.
% Count the number of blackened cells adjacent to a given cell
count_blackened(X,Y,C) :- blackened(X+1,Y), blackened(X,Y+1), blackened(X+1,Y+1), C = 3.
count_blackened(X,Y,C) :- blackened(X+1,Y), blackened(X,Y+1), C = 2.
count_blackened(X,Y,C) :- blackened(X+1,Y), blackened(X+1,Y+1), C = 2.
count_blackened(X,Y,C) :- blackened(X,Y+1), blackened(X+1,Y+1), C = 2.
count_blackened(X,Y,C) :- blackened(X+1,Y), C = 1.
count_blackened(X,Y,C) :- blackened(X,Y+1), C = 1.
count_blackened(X,Y,C) :- blackened(X+1,Y+1), C = 1.
count_blackened(X,Y,C) :- C = 0.