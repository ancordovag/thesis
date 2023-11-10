yosenabe = {"story":"yosenabe",
            "problem":'''The task of this project is to solve the Japanese grid puzzle Yosenabe using ASP. Given a grid, the task is to move each number surrounded by a frame into one of the gray areas along a straight line, respecting the following conditions:
1. The ways of any two moved numbers must not cross or meet at any grid cell.
2. Each gray area must be populated with at least one moved number.
3. An area may be associated with a (positive) goal number, shown within it. If so, the numbers moved into the area must sum up exactly to the goal.
While a number can be moved through an area, you may assume that a move stops at the first cell w.r.t. its direction of the area into which it leads.''',
            "Representation in ASP":'''%% INPUT
            cell(X,Y) % There is a cell with coordinates (X,Y)
            number(X,Y,N) % In the cell (X,Y) there is a number N            
            area(X,Y,A) % The cell (X,Y) belongs to the area A             
            goal(A,G) % The area A has a goal G to fulfill
            %% OUTPUT
            target(X,Y,P,Q) % The number is moved from (X,Y) to (P,Q)''',
            "constants": '''rows: 1; ..; R.
                         columns: 1; ..; C.
                         numbers: 1;...; N.
                         area: gray area.''',
            "predicates":'''% Predicate representing the position of a number in the grid
            position(X,Y,N)
            % Predicate representing the direction of an area
            direction(A,D)
            % Predicate representing the goal number of an area
            goal(A,G)
            % Predicate representing the sum of numbers in an area
            sum(A,S)''',
            "input_predicates":'''% There is a cell with coordinates (X,Y)
            cell(X,Y)
            % In the cell (X,Y) there is a number N 
            number(X,Y,N)
            % The cell (X,Y) belongs to the area A 
            area(X,Y,A)
            % The area A has a goal G to fulfill
            goal(A,G)''',
            "output_predicate":'''% 
            target(X,Y,P,Q)''',
            "rules":'''% All the posible directions
            dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% No different targets for the same number
:- target(X,Y,I,J), I != I', target(X,Y,I',J).         
% No different targets for the same number
:- target(X,Y,I,J), J != J', target(X,Y,I,J').         
% Only horizontal or vertical movements
:- target(X,Y,I,J), X != I, Y != J.                         
% Only one target point to one cell
:- target(X,Y,I,J), target(X',Y',I,J), cell(X,Y) != cell(X',Y').    

% The paths are not crossed
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y<=Y', Y'<=J, X'<=X, X<=I'.
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y>=Y', Y'>=J, X'<=X, X<=I'.
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y<=Y', Y'<=J, X'>=X, X>=I'.
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y>=Y', Y'>=J, X'>=X, X>=I'.
:- target(X,Y,I,J), target(X',Y,I',J), I>I', X<X'.
:- target(X,Y,I,J), target(X,Y',I,J'), J>J', Y<Y'.

% Each gray area must be populated with at least one moved number.
counttarget(T,A) :- T = #count{number(X,Y,Z): number(X,Y,Z), target(X,Y,I,J), area(I,J,A)}, area(_,_,A).
:- T = 0, counttarget(T,A).

% The areas have values
total(A,S) :- S = #sum{ Z : number(X,Y,Z), target(X,Y,I,J), area(I,J,A)}, goal(A,V).
:- total(A,S), S != V, goal(A,V).

#show target/4.''',
            "constraints":'''% For each number, there is a target related to only one area
1 { target(X,Y,I,J) : area(I,J,A) } 1 :- number(X,Y,Z). ''',
            
            "normal_rules":'''% All the posible directions
            dir(0,1). dir(0,-1). dir(1,0). dir(-1,0). 
            counttarget(T,A) :- T = #count{number(X,Y,Z): number(X,Y,Z), target(X,Y,I,J), area(I,J,A)}, area(_,_,A).
            target(X,Y,I,J) :- area(I,J,A), number(X,Y,Z).''',
            "integrity_constraints":'''% No different targets for the same number
:- target(X,Y,I,J), I != I', target(X,Y,I',J).         
% No different targets for the same number
:- target(X,Y,I,J), J != J', target(X,Y,I,J').         
% Only horizontal or vertical movements
:- target(X,Y,I,J), X != I, Y != J.                         
% Only one target point to one cell
:- target(X,Y,I,J), target(X',Y',I,J), cell(X,Y) != cell(X',Y'). 

% The paths are not crossed
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y<=Y', Y'<=J, X'<=X, X<=I'.
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y>=Y', Y'>=J, X'<=X, X<=I'.
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y<=Y', Y'<=J, X'>=X, X>=I'.
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y>=Y', Y'>=J, X'>=X, X>=I'.
:- target(X,Y,I,J), target(X',Y,I',J), I>I', X<X'.
:- target(X,Y,I,J), target(X,Y',I,J'), J>J', Y<Y'. 
% The total should match the goal
:- total(A,S), S != V, goal(A,V).''',

            "possible_rules":'''% All the posible directions
            dir(0,1). dir(0,-1). dir(1,0). dir(-1,0). 
            counttarget(T,A) :- T = #count{number(X,Y,Z): number(X,Y,Z), target(X,Y,I,J), area(I,J,A)}, area(_,_,A).
            possible_target(X,Y,I,J) :- area(I,J,A), number(X,Y,Z).''',

            "Generation rules":'''% For each number, there is a target related to only one area
1 { target(X,Y,I,J) : area(I,J,A) } 1 :- number(X,Y,Z).  ''',
            
            "encoding":'''% All the posible directions
            dir(0,1). dir(0,-1). dir(1,0). dir(-1,0).
% No different targets for the same number
:- target(X,Y,I,J), I != I', target(X,Y,I',J).         
% No different targets for the same number
:- target(X,Y,I,J), J != J', target(X,Y,I,J').         
% Only horizontal or vertical movements
:- target(X,Y,I,J), X != I, Y != J.                         
% Only one target point to one cell
:- target(X,Y,I,J), target(X',Y',I,J), cell(X,Y) != cell(X',Y').    

% The paths are not crossed
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y<=Y', Y'<=J, X'<=X, X<=I'.
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y>=Y', Y'>=J, X'<=X, X<=I'.
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y<=Y', Y'<=J, X'>=X, X>=I'.
:- target(X,Y,I,J), target(X',Y',I',J'), X = I, Y'=J', Y>=Y', Y'>=J, X'>=X, X>=I'.
:- target(X,Y,I,J), target(X',Y,I',J), I>I', X<X'.
:- target(X,Y,I,J), target(X,Y',I,J'), J>J', Y<Y'.

% Each gray area must be populated with at least one moved number.
counttarget(T,A) :- T = #count{number(X,Y,Z): number(X,Y,Z), target(X,Y,I,J), area(I,J,A)}, area(_,_,A).
:- T = 0, counttarget(T,A).

% The areas have values
total(A,S) :- S = #sum{ Z : number(X,Y,Z), target(X,Y,I,J), area(I,J,A)}, goal(A,V).
:- total(A,S), S != V, goal(A,V).

% For each number, there is a target related to only one area
1 { target(X,Y,I,J) : area(I,J,A) } 1 :- number(X,Y,Z).

#show target/4. '''
}