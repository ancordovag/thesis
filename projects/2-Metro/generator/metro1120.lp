%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
% Gruppe (1120):  Moritz Rumpf, Lukas Schröder                                %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%
% Generate %
%%%%%%%%%%%%

% Guess solution candidates here!

V{metro(X,Y):mNode(X,Y,_,_)}V:-metros(V).
2{wires(X,Y,X2,Y2):mNode(X2,Y2,_,_)}2:-lNode(X,Y,_).
%2{dada(X,Y,1..3),dada(Y+10,X+10,1..3)}2:-metro(X,Y).

%%%%%%%%
% Test %
%%%%%%%%
z(1..9).

un(X,Y):-X!=Y,z(X), z(Y).

unt(X,Y,X2,Y2):-metro(X,Y),metro(X2,Y2),un(X,X2).	 
unt(X,Y,X2,Y2):-metro(X,Y),metro(X2,Y2),un(Y,Y2).	

tu(A,B,X,Y,X2,Y2):-wires(A,B,X,Y),unt(X,Y,X2,Y2),wires(A,B,X2,Y2).
:-maxLoss(L),metro(X,Y),metro(X2,Y2),(L+1){tu(_,_,X,Y,X2,Y2)} .

:- metro(X,Y),mNode(X,Y,_,A),A+1{wires(_,_,X,Y)}.

h:- wires(A,B,X2,Y2),not 1{metro(X2,Y2)}1.
:-h.

:- metro(X,Y),(L+1) #sum[wires(A,B,X,Y)=K:lNode(A,B,K)],mNode(X,Y,L,_).




%%%%%%%%%%%%
% Optimize %
%%%%%%%%%%%%

dist((EX-MX)*(EX-MX)+(EY-MY)*(EY-MY)):-wires(EX,EY,MX,MY).
#minimize[dist(S)=S].

%#minimize[wires(X,Y,X2,Y2)=((X-X2)*(X-X2)+(Y-Y2)*(Y-Y2))].	% such das, wo die summe aller distanzen am kleinsten ist

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display (only metro/2 and wires/4) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#hide.
#show metro/2.
#show wires/4.
