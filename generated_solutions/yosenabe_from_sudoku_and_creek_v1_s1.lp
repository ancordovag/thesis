% Generate all possible combinations of moved numbers
{moved(X,Y) : constant_1(X), constant_2(Y)}.

% Generate all possible combinations of gray areas
{gray(X,Y) : constant_1(X), constant_2(Y)}.

% Generate all possible combinations of goal numbers
{goal(X,Y,Num) : constant_1(X), constant_2(Y), constant_3(Num)}.

% Show output predicates
#show moved/2.
#show gray/2.
#show goal/3.
% Constraint 1: Each gray area must be populated with at least one moved number
    :- gray(X,Y), not moved(X,Y).

% Constraint 2: The ways of any two moved numbers must not cross or meet at any grid cell
    :- moved(X1,Y1), moved(X2,Y2), path(X1,Y1,X2,Y2).

% Constraint 3: An area may be associated with a goal number, and the numbers moved into the area must sum up exactly to the goal
    :- goal(X,Y,Num), not sum_goal(X,Y,Num).

% Constraint 4: A number can be moved through an area, but the move stops at the first cell w.r.t. its direction of the area into which it leads
    :- moved(X1,Y1), gray(X2,Y2), path(X1,Y1,X2,Y2), not stop(X1,Y1,X2,Y2).