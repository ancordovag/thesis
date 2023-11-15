hop = {"story":"hop",
      "problem":'''The goal of the puzzle is to find a path between predefined start and end points. The path consists of jumps of varying lengths in horizontal or vertical directions, following the pattern 1, 2, 3, 1, 2, 3, and so on. The task is to determine the cells where it lands between these jumps. Some of these cells are already provided, but without a specific order.''',
       
      "Representation in ASP":'''%% INPUT
cols(C). % Number of columns
rows(R). % Number of rows
numsteps(N). % Number of steps necessary
start(X,Y). % Start cell
goal(X,Y). % Goal cell
dot(X,Y). % Predefined intermediate step 
%% OUTPUT
step(X,Y,T) % cell X,Y is visited in timestep T ''',

      "constants":'''rows: 1; ..; R.
                     columns: 1; ..; C.
                     jumps: 1;2;3.''',

      "predicates":'''% Predicate representing the cells where the path lands: land/3. The path lands at the coordinates (X,Y) after a jump of length J.
          step(X,Y,T) ''',

       "input_predicates":''' % Number of columns
           cols(C).
           % Number of rows
            rows(R). 
            % Number of steps necessary
            numsteps(N). 
            % Start cell
            start(X,Y). 
            % Goal cell
            goal(X,Y). 
            % Predefined intermediate step 
            dot(X,Y).  ''',

       "output_predicate":'''% cell X,Y is visited in timestep T 
           step(X,Y,T) ''',

       "rules":'''% generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% start at "start"
step(X,Y,0) :- start(X,Y).
% possible hops
hop(0,1). hop(0,2). hop(0,3). hop(0,-1). hop(0,-2). hop(0,-3).
hop(1,0). hop(2,0). hop(3,0). hop(-1,0). hop(-2,0). hop(-3,0).
% move S % 3 + 1 squares in step S
1 {step(X+A,Y+B,S+1) : hop(A,B), cell(X+A,Y+B)} 1 :- step(X,Y,S), not numsteps(S).
% taken hops
actual_hop(A,B,S) :- step(X,Y,S-1), step(P,Q,S), A=P-X, B=Q-Y.
:- actual_hop(A,B,1), |A+B| > 1. ''',

       "constraints":'''% if last hop was length 1, this one is length 2
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=1, |C+D| != 2.
% if last hop was length 2, this one is length 3
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=2, |C+D| != 3.
% if last hop was length 3, this one is length 1
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=3, |C+D| != 1.
% don't visit one square twice
visited(X,Y) :- step(X,Y,S).
% Every dot must be visited
:- not visited(X,Y), dot(X,Y).
% The goal must be visited
:- not visited(X,Y), goal(X,Y).
% Cannot step a cell twice
:- step(X,Y,S1), step(X,Y,S2), S1 != S2.
% Cannot step into a cell after stepping in goal
:- goal(X,Y), step(X,Y,S), step(P,Q,S+1).

#show step/3.  ''',

       "encoding":'''% generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% start at "start"
step(X,Y,0) :- start(X,Y).
% possible hops
hop(0,1). hop(0,2). hop(0,3). hop(0,-1). hop(0,-2). hop(0,-3).
hop(1,0). hop(2,0). hop(3,0). hop(-1,0). hop(-2,0). hop(-3,0).
% move S % 3 + 1 squares in step S
1 {step(X+A,Y+B,S+1) : hop(A,B), cell(X+A,Y+B)} 1 :- step(X,Y,S), not numsteps(S).
% taken hops
actual_hop(A,B,S) :- step(X,Y,S-1), step(P,Q,S), A=P-X, B=Q-Y.
:- actual_hop(A,B,1), |A+B| > 1.

% if last hop was length 1, this one is length 2
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=1, |C+D| != 2.
% if last hop was length 2, this one is length 3
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=2, |C+D| != 3.
% if last hop was length 3, this one is length 1
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=3, |C+D| != 1.
% don't visit one square twice
visited(X,Y) :- step(X,Y,S).
% Every dot must be visited
:- not visited(X,Y), dot(X,Y).
% The goal must be visited
:- not visited(X,Y), goal(X,Y).
% Cannot step a cell twice
:- step(X,Y,S1), step(X,Y,S2), S1 != S2.
% Cannot step into a cell after stepping in goal
:- goal(X,Y), step(X,Y,S), step(P,Q,S+1).

%Show output predicate
#show step/3. ''',

        "normal_rules":'''% generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% possible jumps of varying lengths in horizontal or vertical directions, following the pattern 1, 2, 3
jump(0,1). jump(0,2). jump(0,3). jump(0,-1). jump(0,-2). jump(0,-3).
jump(1,0). jump(2,0). jump(3,0). jump(-1,0). jump(-2,0). jump(-3,0).
 % The first step is at "start"
step(X,Y,0) :- start(X,Y).
% The next possible step depends of the previous one, given that is in a cell
step(X+A,Y+B,T) :-  possible_step(X,Y,T-1), cell(X+A,Y+B), jump(A,B), not numsteps(S).''',

       "integrity_constraints":'''% taken hops
actual_hop(A,B,S) :- step(X,Y,S-1), step(P,Q,S), A=P-X, B=Q-Y.
:- actual_hop(A,B,1), |A+B| > 1.

% if last hop was length 1, this one is length 2
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=1, |C+D| != 2.
% if last hop was length 2, this one is length 3
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=2, |C+D| != 3.
% if last hop was length 3, this one is length 1
:- actual_hop(A,B,S-1), actual_hop(C,D,S), |A+B|=3, |C+D| != 1.
% don't visit one square twice
visited(X,Y) :- step(X,Y,S).
% Every dot must be visited
:- not visited(X,Y), dot(X,Y).
% The goal must be visited
:- not visited(X,Y), goal(X,Y).
% Cannot step a cell twice
:- step(X,Y,S1), step(X,Y,S2), S1 != S2.
% Cannot step into a cell after stepping in goal
:- goal(X,Y), step(X,Y,S), step(P,Q,S+1). ''', 
       
      "possible_rules":'''% generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% possible jumps of varying lengths in horizontal or vertical directions, following the pattern 1, 2, 3
jump(0,1). jump(0,2). jump(0,3). jump(0,-1). jump(0,-2). jump(0,-3).
jump(1,0). jump(2,0). jump(3,0). jump(-1,0). jump(-2,0). jump(-3,0).
 % The first step is at "start"
possible_step(X,Y,0) :- start(X,Y).
% The next possible step depends of the previous one, given that is in a cell
possible_step(X+A,Y+B,T) :-  possible_step(X,Y,T-1), cell(X+A,Y+B), jump(A,B), not numsteps(S).''',

       
       
      "Generation rules":'''% Generate cells
cell(X,Y) :- X=1..C, cols(C), Y=1..R, rows(R).
% Possible jumps of varying lengths in horizontal or vertical directions, following the pattern 1, 2, 3
jump(0,1). jump(0,2). jump(0,3). jump(0,-1). jump(0,-2). jump(0,-3).
jump(1,0). jump(2,0). jump(3,0). jump(-1,0). jump(-2,0). jump(-3,0).
 % The first step is at "start"
step(X,Y,0) :- start(X,Y).
% The next possible step depends of the previous one, given that is in a cell
{ step(X+A,Y+B,T+1) : jump(A,B) } :-  possible_step(X,Y,T), cell(X+A,Y+B), numsteps(S), T < S.'''

}