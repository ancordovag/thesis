% Define the constants in each category.
grid_shape("rectangular").
connection_type("orthogonal").
movement_type("horizontally"; "vertically").
adjacent_cells(4).
% The grid shape can only be rectangular.
:- grid_shape(G), G!="rectangular".
% The connection type can only be orthogonal.
:- connection_type(C), C!="orthogonal".
% The movement type can only be horizontally or vertically.
:- movement_type(M), M!="horizontally", M!="vertically".
% The number of adjacent cells must be 4.
A!=4 :- adjacent_cells(A).