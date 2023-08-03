%% Definition
% Differences between the coordinates of neighboring fields
diff(0,1). diff(0,-1). diff(1,0). diff(-1,0).  

% define the neighbors of a field
neighbor(X1,Y1,X2,Y2) :- field(X1,Y1), field(X2,Y2), diff(DX,DY), |X2-X1| = |DX|, |Y2-Y1| = |DY|.


%% Initialization
%marks the start field as visited at step 0
visited(X,Y,0):- start(X,Y).    


%% Generation
%generate path between visited field and a neighboring field
{at(X1,Y1,S)} 1 :- visited(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2,Y2), S>0.

% if there is a path between 2 fields then the second one marked as visited
visited(X2,Y2,S-1) :- at(X1,Y1,S), neighbor(X1,Y1,X2