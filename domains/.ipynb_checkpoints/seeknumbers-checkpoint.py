seeknumbers = {"story":"seeknumbers",
               "problem":'''Given a square grid, the goal is to construct a directed path by linking horizontally or vertically adjacent cells such that:
    - the path starts at the cell marked with a white circle and ends at the cell marked with a black circle,
    - the path traverses each remaining cell of the square grid without ever crossing or intersecting itself,
    - between a cell with a (positive) number and the next cell with a number or the cell marked with a black circle, respectively, the path bends exactly as often as the number in the first cell indicates, and
    - the path does not bend between the cell marked with a white circle and the first cell with a number.''',

               "Short Problem":'''Given a square grid, the goal is to construct a directed path by linking horizontally or vertically adjacent cells such that the path starts at the cell marked with a white circle and ends at the final cell.''',
               
"constants":'''% A grid is composed by rows and columns.
rows: 1; 2; ...; R;
columns: 1; 2; ...; C;''',
         "Representation in ASP":'''%% INPUT
cell(X,Y).   % the cell (X,Y) belongs to the grid
first(X,Y).  % the first cell of the path (marked with a white circle) is (X,Y)
final(X,Y).  % the final cell of the path (marked with a black circle) is (X,Y)
hint(X,Y,N). % the cell (X,Y) contains the hint number N
%% OUTPUT
path(X,Y,XX,YY) % path between cell(X,Y) and cell(XX,YY)''',
               
"predicates":'''% Every cell cell(X,Y) should be traversed, that means visited
visited(X,Y)
% There should be a path between cells. Lets create a path between generic cell(X,Y) and cell(XX,YY)
path(X,Y,XX,YY)''',
               
"input_predicates":'''% the cell (X,Y) belongs to the grid
cell(X,Y).
% the first cell of the path (marked with a white circle) is (X,Y)
first(X,Y).
% the final cell of the path (marked with a black circle) is (X,Y)
final(X,Y).
% the cell (X,Y) contains the hint number N.
hint(X,Y,N).''',
               
"output_predicate":'''% There should be a path between cells. Lets create a path between generic cell(X,Y) and cell(XX,YY)
path(X,Y,XX,YY) ''',
               
"rules":'''% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, cell(X,Y), cell(XX,YY).

% Generates one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not final. 
1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- cell(X,Y), not final(X,Y).

% Path is the same as edge, without specifying vertical or horizontal, expressed by variable D.
path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

% The first cell is visited
visited(X,Y) :- first(X,Y).

% If a cell (X,Y) is visited, and there is an edge between (X,Y) and (XX,YY), then cell (X,Y) is also visited
visited(XX,YY) :- visited(X,Y), edge(X,Y,XX,YY,_).

% xhint is a counter that starts with N in the cell (XX,YY) when there is an edge between hint cell (X,Y) and saves direction D
xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY,D).
% xhintand cell (XX,YY), and it is 0 in the cell (XX,YY) when 
xhint(XX,YY,0,D) :- first(X,Y),  edge(X,Y,XX,YY,D).

% If there is no hint in cell (X,Y), then the next connected cell has the same counter if the direction if the same
xhint(XX,YY,N,DD) :- xhint(X,Y,N,D), not hint(X,Y,_), edge(X,Y,XX,YY,DD), D=DD.
% If there is no hint in cell (X,Y), but the direction of the cell (X,Y) and the next one is not the same, then the counter xhint decreases by one
xhint(XX,YY,N-1,DD) :- xhint(X,Y,N,D), N>=1, not hint(X,Y,_), edge(X,Y,XX,YY,DD), D!=DD.

% Show output predicate
#show path/4.''',
               
    "constraints" : '''% It cannotbe the case that there is not incoming edge to a cell if that cell is not the first one
:- not 1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1, cell(XX,YY), not first(XX,YY).
% it cannot be the case that a cell is not visited
:- cell(X,Y), not visited(X,Y).
% It cannot be the case that the counter xhint is not 0 in the cell of a hint
:- hint(X,Y,_), not xhint(X,Y,0,_).
% It cannot be the case that the counter xhint is not 0 in the final cell
:-  final(X,Y), not xhint(X,Y,0,_).''',
               
               "normal_rules":'''% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, cell(X,Y), cell(XX,YY). 

% Generates one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not final. 
edge(X,Y,XX,YY,D) :- neighbour(X,Y,XX,YY,D), cell(X,Y), not final(X,Y).

% Path is the same as edge, without specifying vertical or horizontal, expressed by variable D.
possible_path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

% The first cell is visited
visited(X,Y) :- first(X,Y).

% If a cell (X,Y) is visited, and there is an edge between (X,Y) and (XX,YY), then cell (X,Y) is also visited
visited(XX,YY) :- visited(X,Y), edge(X,Y,XX,YY,_).

% xhint is a counter that starts with N in the cell (XX,YY) when there is an edge between hint cell (X,Y) and saves direction D
xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY,D).
% xhintand cell (XX,YY), and it is 0 in the cell (XX,YY) when 
xhint(XX,YY,0,D) :- first(X,Y),  edge(X,Y,XX,YY,D).

% If there is no hint in cell (X,Y), then the next connected cell has the same counter if the direction if the same
xhint(XX,YY,N,DD) :- xhint(X,Y,N,D), not hint(X,Y,_), edge(X,Y,XX,YY,DD), D=DD.
% If there is no hint in cell (X,Y), but the direction of the cell (X,Y) and the next one is not the same, then the counter xhint decreases by one
xhint(XX,YY,N-1,DD) :- xhint(X,Y,N,D), N>=1, not hint(X,Y,_), edge(X,Y,XX,YY,DD), D!=DD.''',
               
               "integrity_constraints":'''% It cannot be the case that there is not incoming edge to a cell if that cell is not the first one
:- not edge(X,Y,XX,YY,D), cell(XX,YY), not first(XX,YY).
% it cannot be the case that a cell is not visited
:- cell(X,Y), not visited(X,Y).
% It cannot be the case that the counter xhint is not 0 in the cell of a hint
:- hint(X,Y,_), not xhint(X,Y,0,_).
% It cannot be the case that the counter xhint is not 0 in the final cell
:-  final(X,Y), not xhint(X,Y,0,_). ''',
               
               "possible_rules":'''% The possible path between 2 cells, given that the starting cell is no the final one and the destiny cell is not the first
               possible_path(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), not final(X,Y), not first(XX,YY).''',

               "Generation rules":''' % Define the neighbours of a cell X,Y
               neighbour(X,Y,XX,YY) :- cell(X,Y), cell(XX,YY), |XX-X| + |YY-Y| = 1.
               { path(X,Y,XX,YY) } 1 :- neighbour(X,Y,XX,YY), not final(X,Y), not first(XX,YY).
               % Show output predicate
                #show path/4.''',
               
               "encoding":'''% Generates a predicate called neighbour that specify if it is vertical (v) or horizontal (h). 4 rules, one for each direction.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, cell(X,Y), cell(XX,YY).

% Generates one edge between cell (X,Y) and one of its neighbours (XX,YY), if (X,Y) is not final. 
1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- cell(X,Y), not final(X,Y).

% Path is the same as edge, without specifying vertical or horizontal, expressed by variable D.
path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

% It cannotbe the case that there is not incoming edge to a cell if that cell is not the first one
:- not 1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1, cell(XX,YY), not first(XX,YY).

% The first cell is visited
visited(X,Y) :- first(X,Y).

% If a cell (X,Y) is visited, and there is an edge between (X,Y) and (XX,YY), then cell (X,Y) is also visited
visited(XX,YY) :- visited(X,Y), edge(X,Y,XX,YY,_).

% it cannot be the case that a cell is not visited
:- cell(X,Y), not visited(X,Y).

% xhint is a counter that starts with N in the cell (XX,YY) when there is an edge between hint cell (X,Y) and saves direction D
xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY,D).

% xhint in cell (XX,YY), and it is 0 in the cell (XX,YY)
xhint(XX,YY,0,D) :- first(X,Y),  edge(X,Y,XX,YY,D).

% If there is no hint in cell (X,Y), then the next connected cell has the same counter if the direction if the same
xhint(XX,YY,N,DD) :- xhint(X,Y,N,D), not hint(X,Y,_), edge(X,Y,XX,YY,DD), D=DD.

% If there is no hint in cell (X,Y), but the direction of the cell (X,Y) and the next one is not the same, then the counter xhint decreases by one
xhint(XX,YY,N-1,DD) :- xhint(X,Y,N,D), N>=1, not hint(X,Y,_), edge(X,Y,XX,YY,DD), D!=DD.

% It cannot be the case that the counter xhint is not 0 in the cell of a hint
:- hint(X,Y,_), not xhint(X,Y,0,_).

% It cannot be the case that the counter xhint is not 0 in the final cell
:-  final(X,Y), not xhint(X,Y,0,_).

% Show output predicate
#show path/4.''',

               "lines":'''% Define a neighbour relationship between cell (X,Y) and cell (XX,YY) with direction D (either vertical 'v' or horizontal 'h'), where (XX,YY) is immediately above (for 'v'), below (for 'v'), to the right (for 'h'), or to the left (for 'h') of (X,Y).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, cell(X,Y), cell(XX,YY).

% Ensure that for each cell (X,Y) that is not the final cell, there is exactly one outgoing edge (XX,YY) with direction D (either vertical 'v' or horizontal 'h') to a neighbouring cell (XX,YY).
1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- cell(X,Y), not final(X,Y).

 % Define a path between cell (X,Y) and cell (XX,YY) if there exists an edge between them.
path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

% Ensure that each cell (XX,YY) that is not the starting cell has at least one incoming edge from a neighbouring cell.
:- not 1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1, cell(XX,YY), not first(XX,YY).

% Mark the starting cell (X,Y) as visited.
visited(X,Y) :- first(X,Y).

% Mark cell (XX,YY) as visited if there exists a path from a previously visited cell (X,Y) to cell (XX,YY).
visited(XX,YY) :- visited(X,Y), edge(X,Y,XX,YY,_).

% Ensure that all cells in the grid are visited. If a cell (X,Y) is not visited, it violates the constraint.
:- cell(X,Y), not visited(X,Y).

% Define an X-hint between cell (XX,YY) and a cell containing the hint number N if there exists an edge between (X,Y) and (XX,YY) with direction D.
xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY,D).

% Define an X-hint between cell (XX,YY) and a cell containing the hint number 0 if (X,Y) is the starting cell and there exists an edge between (X,Y) and (XX,YY) with direction D.
xhint(XX,YY,0,D) :- first(X,Y),  edge(X,Y,XX,YY,D).

% Define an X-hint between cell (XX,YY) and a cell containing the hint number N if there exists an X-hint between another cell (X,Y) and a cell containing the hint number N with direction D, and there is an edge between (X,Y) and (XX,YY) with direction DD, where D is the same as DD.
xhint(XX,YY,N,DD) :- xhint(X,Y,N,D), not hint(X,Y,_), edge(X,Y,XX,YY,DD), D=DD.

% Define an X-hint between cell (XX,YY) and a cell containing the hint number (N-1) if there exists an X-hint between another cell (X,Y) and a cell containing the hint number N with direction D, and N is greater than or equal to 1, and there is an edge between (X,Y) and (XX,YY) with direction DD, where D is different from DD.
xhint(XX,YY,N-1,DD) :- xhint(X,Y,N,D), N>=1, not hint(X,Y,_), edge(X,Y,XX,YY,DD), D!=DD.

% Ensure that if a cell (X,Y) contains a hint number, there must be an X-hint from (X,Y) with hint number 0.
:- hint(X,Y,_), not xhint(X,Y,0,_).

% Ensure that if the final cell (X,Y) is specified, there must be an X-hint from (X,Y) with hint number 0.
:-  final(X,Y), not xhint(X,Y,0,_).

% Show output predicate
#show path/4.''',

               "lines_nlp":'''% Generate a mapping between all the cells that are neighbours. A cell have normally 4 neighbours: the cell above, the one below, the one to the right and the one to the left, if those cells are in the grid.
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y+1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X, YY=Y-1, D=v, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X+1, YY=Y, D=h, cell(X,Y), cell(XX,YY).
neighbour(X,Y,XX,YY,D) :- XX=X-1, YY=Y, D=h, cell(X,Y), cell(XX,YY).

% Among all their neighbours, there is an edge between a cell and one that neighbour, if the cell is not the final one. 
1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1 :- cell(X,Y), not final(X,Y).

The output predicate path is matching the edges one to one
path(X,Y,XX,YY) : edge(X,Y,XX,YY,_).

% It cannotbe the case that there is not incoming edge to a cell if that cell is not the first one
:- not 1 { edge(X,Y,XX,YY,D) : neighbour(X,Y,XX,YY,D) } 1, cell(XX,YY), not first(XX,YY).

% The first cell is visited
visited(X,Y) :- first(X,Y).

% A cell is visited if there is an incoming edge from a cell already visited
visited(XX,YY) :- visited(X,Y), edge(X,Y,XX,YY,_).

% It cannot be the case that a cell is not visited
:- cell(X,Y), not visited(X,Y).

% A counter for each cell, starting with the value of the hint in the position of the next cell visited
xhint(XX,YY,N,D) :- hint(X,Y,N), edge(X,Y,XX,YY,D).

% The counter is 0 in the position of the cell next to the first one
xhint(XX,YY,0,D) :- first(X,Y),  edge(X,Y,XX,YY,D).

% If there is no hint in cell (X,Y), then the next connected cell has the same counter if the direction if the same
xhint(XX,YY,N,DD) :- xhint(X,Y,N,D), not hint(X,Y,_), edge(X,Y,XX,YY,DD), D=DD.

% If there is no hint in cell (X,Y), but the direction of the cell (X,Y) and the next one is not the same, then the counter xhint decreases by one
xhint(XX,YY,N-1,DD) :- xhint(X,Y,N,D), N>=1, not hint(X,Y,_), edge(X,Y,XX,YY,DD), D!=DD.

% It cannot be the case that the counter xhint is not 0 in the cell of a hint
:- hint(X,Y,_), not xhint(X,Y,0,_).

% It cannot be the case that the counter xhint is not 0 in the final cell
:-  final(X,Y), not xhint(X,Y,0,_).

% Show output predicate
#show path/4.'''
}