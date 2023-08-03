% The categories in Constants include person and job. We use different variables P and J to represent person and job.
% We assign a person P to a job J, where P belongs to person and J belongs to job.
%assign(P, J).
% Define the constants in each category.
person("Roberta"; "Thelma"; "Steve"; "Pete").
%person(Roberta). person(Thelma). person(Steve). person(Pete).
job("chef"; "guard"; "nurse"; "telephone operator"; "police officer"; "teacher"; "actor"; "boxer").
% For each person P, it is assigned to exactly 1 job J.
{assign(P, J): job(J)}=1 :- person(P).
% No option in any category will ever be used more than once.
{P1=P2; J1=J2}=0 :- assign(P1,J1), assign(P2,J2), (P1,J1)!=(P2,J2).
% 1. There are four people: Roberta, Thelma, Steve, and Pete.
{P="Roberta"; P="Thelma"; P="Steve"; P="Pete"}=4 :- assign(P,J).
% 2. Among them, they hold eight different jobs.
{J="chef"; J="guard"; J="nurse"; J="telephone operator"; J="police officer"; J="teacher"; J="actor"; J="boxer"}=8 :- assign(P,J).
% 3. Each holds exactly two jobs.
{assign(P,J) : job(J)}=2 :- person(P).
% 4. The jobs are: chef, guard, nurse, telephone operator, police officer (gender not implied), teacher, actor, and boxer.
{J="chef"; J="guard"; J="nurse"; J="telephone operator"; J="police officer"; J="teacher"; J="actor"; J="boxer"}=1 :- assign(P,J).
% 5. The job of nurse is held by a male.
{J="nurse"; P="male"}=1 :- assign(P,J).
% 6. The husband of the chef is the telephone operator.
{P1="husband"; J1="chef"; P2="wife"; J2="telephone operator"}=1 :- assign(P1,J1), assign(P2,J2).
% 7. Roberta is not a boxer.
J!="boxer" :- assign("Roberta",J).
% 8. Pete has no education past the ninth grade.
J!="teacher" :- assign("Pete",J).
% 9. Roberta, the chef, and the police officer went golfing together.
{P="Roberta"; J="chef"; J="police officer"}=1 :- assign(P,J).