% Define the gray areas
gray_area(Area) :- gray_areas(Area).

% Define the possible numbers that can be moved in a gray area
moved_number(Number, Area) :- digits(Number), gray_area(Area).

% Define the sum of numbers in a gray area
sum_of_numbers(Area, Sum) :- gray_area(Area), goal_number(Sum).

% Show output predicates
#show moved_number/2.
#show sum_of_numbers/2.
There are no constraints provided in the problem description for Problem 3.