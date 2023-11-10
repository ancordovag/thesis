1. You can move from your current field to an adjacent field if there is no wall between them.
2. You cannot move from your current field to an adjacent field if there is a wall between them.
3. The Minotaur can move two fields in any direction if there is no wall blocking its path.
4. The Minotaur cannot move if there is a wall blocking its path in all directions.
5. The Minotaur will try to move right or left if it can become closer to you.
6. The Minotaur will try to move up or down if it cannot move right or left and can become closer to you.
7. The Minotaur will not move if it cannot move right, left, up, or down.
8. You win the game if you reach the goal field without being eaten by the Minotaur.
9. You lose the game if the Minotaur reaches your current field.:- Minotaur(X,Y), Goal(X,Y), not ReachedGoal.
:- Minotaur(X,Y), Player(X,Y), not EatenByMinotaur.
:- Minotaur(X,Y), Player(X,Y), not ReachedGoal, not EatenByMinotaur.
:- Minotaur(X,Y), Player(X,Y), Wall(X,Y).
:- Minotaur(X,Y), Player(X,Y), Wall(X1,Y1), Wall(X2,Y2), Wall(X3,Y3), Wall(X4,Y4), not EatenByMinotaur.
:- Minotaur(X,Y), Player(X,Y), Wall(X1,Y1), Wall(X2,Y2), Wall(X3,Y3), Wall(X4,Y4), not ReachedGoal.
:- Minotaur(X,Y), Player(X,Y), Wall(X1,Y1), Wall(X2,Y2), Wall(X3,Y3), Wall(X4,Y4), not ReachedGoal, not EatenByMinotaur.
:- Minotaur(X,Y), Player(X,Y), not Wall(X1,Y1), not Wall(X2,Y2), not Wall(X3,Y3), not Wall(X4,Y4), not EatenByMinotaur.
:- Minotaur(X,Y), Player(X,Y), not Wall(X1,Y1), not Wall(X2,Y2), not Wall(X3,Y3), not Wall(X4,Y4), not ReachedGoal.
:- Minotaur(X,Y), Player(X,Y), not Wall(X1,Y1), not Wall(X2,Y2), not Wall(X3,Y3), not Wall(X4,Y4), not ReachedGoal, not EatenByMinotaur.