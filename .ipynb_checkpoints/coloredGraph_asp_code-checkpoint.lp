% Define the constants in each category.
node(1; 2; 3; 4; 5; 6).
edge(1..17).
color("red"; "green"; "blue").
% For each node N, it is assigned exactly 1 color C.
{assign_color(N, C): color(C)}=1 :- node(N).
% For each pair of nodes N1 and N2, there is exactly 1 edge E connecting them.
{connect(N1, N2, E): edge(E)}=1 :- node(N1), node(N2), N1 != N2.
% No option in any category will ever be used more than once.
{N1=N2; C1=C2; E1=E2}=0 :- assign_color(N1,C1), assign_color(N2,C2), connect(N1,N2,E1), (N1,C1,E1)!=(N2,C2,E2).
% 1. Node 1 is red.
C="red" :- assign_color(N,C), N=1.
% 2. Nodes 2 and 3 are connected by edge 1.
connect(2,3,1).
% 3. Node 4 is green.
C="green" :- assign_color(N,C), N=4.
% 4. Nodes 1 and 5 are connected by edge 2.
connect(1,5,2).
% 5. Node 6 is blue.
C="blue" :- assign_color(N,C), N=6.
% 6. Nodes 2 and 4 are not connected.
{connect(2,4,E); connect(4,2,E)}=0.
% 7. Nodes 3 and 5 are connected by edge 3.
connect(3,5,3).
% 8. Nodes 1 and 6 are not connected.
{connect(1,6,E); connect(6,1,E)}=0.
% 9. Nodes 4 and 5 are not connected.
{connect(4,5,E); connect(5,4,E)}=0.
% 10. Nodes 2 and 6 are connected by edge 4.
connect(2,6,4).
% 11. Nodes 1 and 3 are not connected.
{connect(1,3,E); connect(3,1,E)}=0.
% 12. Nodes 3 and 6 are connected by edge 5.
connect(3,6,5).
% 13. Nodes 2 and 5 are not connected.
{connect(2,5,E); connect(5,2,E)}=0.
% 14. Nodes 1 and 4 are connected by edge 6.
connect(1,4,6).
% 15. Nodes 4 and 6 are not connected.
{connect(4,6,E); connect(6,4,E)}=0.
% 16. Nodes 3 and 4 are connected by edge 7.
connect(3,4,7).
% 17. Nodes 5 and 6 are connected by edge 8.
connect(5,6,8).