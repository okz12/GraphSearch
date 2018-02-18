goal_state((1,2,3,8,0,4,7,6,5)).

move(left, (A,0,C,D,E,F,G,H,I) , (0,A,C,D,E,F,G,H,I)).
move(left, (A,B,0,D,E,F,G,H,I) , (A,0,B,D,E,F,G,H,I)).
move(left, (A,B,C,D,0,F,G,H,I) , (A,B,C,0,D,F,G,H,I)).
move(left, (A,B,C,D,E,0,G,H,I) , (A,B,C,D,0,E,G,H,I)).
move(left, (A,B,C,D,E,F,G,0,I) , (A,B,C,D,E,F,0,G,I)).
move(left, (A,B,C,D,E,F,G,H,0) , (A,B,C,D,E,F,G,0,H)).

move(right, (0,B,C,D,E,F,G,H,I) , (B,0,C,D,E,F,G,H,I)).
move(right, (A,0,C,D,E,F,G,H,I) , (A,C,0,D,E,F,G,H,I)).
move(right, (A,B,C,0,E,F,G,H,I) , (A,B,C,E,0,F,G,H,I)).
move(right, (A,B,C,D,0,F,G,H,I) , (A,B,C,D,F,0,G,H,I)).
move(right, (A,B,C,D,E,F,0,H,I) , (A,B,C,D,E,F,H,0,I)).
move(right, (A,B,C,D,E,F,G,0,I) , (A,B,C,D,E,F,G,I,0)).

move(up, (A,B,C,0,E,F,G,H,I) , (0,B,C,A,E,F,G,H,I)).
move(up, (A,B,C,D,0,F,G,H,I) , (A,0,C,D,B,F,G,H,I)).
move(up, (A,B,C,D,E,0,G,H,I) , (A,B,0,D,E,C,G,H,I)).
move(up, (A,B,C,D,E,F,0,H,I) , (A,B,C,0,E,F,D,H,I)).
move(up, (A,B,C,D,E,F,G,0,I) , (A,B,C,D,0,F,G,E,I)).
move(up, (A,B,C,D,E,F,G,H,0) , (A,B,C,D,E,0,G,H,F)).


move(down, (0,B,C,D,E,F,G,H,I) , (D,B,C,0,E,F,G,H,I)).
move(down, (A,0,C,D,E,F,G,H,I) , (A,E,C,D,0,F,G,H,I)).
move(down, (A,B,0,D,E,F,G,H,I) , (A,B,F,D,E,0,G,H,I)).
move(down, (A,B,C,0,E,F,G,H,I) , (A,B,C,G,E,F,0,H,I)).
move(down, (A,B,C,D,0,F,G,H,I) , (A,B,C,D,H,F,G,0,I)).
move(down, (A,B,C,D,E,0,G,H,I) , (A,B,C,D,E,I,G,H,0)).

h1((A,B,C,D,E,F,G,H,I), N) :- diff(A,1,N1), diff(B,2,N2), diff(C,3,N3), diff(D,8,N4), diff(E,0,N5), diff(F,4,N6), diff(G,7,N7), diff(H,6,N8), diff(I,5,N9), N is N1+N2+N3+N4+N5+N6+N7+N8+N9.
diff(X1,X1,0).
diff(X1,X2,1) :- X1=\=X2.

state_change(Rule, (A,B,C,D,E,F,G,H,I), (A2,B2,C2,D2,E2,F2,G2,H2,I2), 1, HCost) :- move( Rule,(A,B,C,D,E,F,G,H,I), (A2,B2,C2,D2,E2,F2,G2,H2,I2)), h2((A2,B2,C2,D2,E2,F2,G2,H2,I2), HCost).

%%% Manhattan distance
h2((A,B,C,D,E,F,G,H,I), P) :-
     a(A,Pa), b(B,Pb), c(C,Pc),
     d(D,Pd), e(E,Pe), f(F,Pf),
     g(G,Pg), h(H,Ph), i(I,Pi),
     P is Pa+Pb+Pc+Pd+Pe+Pf+Pg+Ph+Pg+Pi.

a(0,0). a(1,0). a(2,1). a(3,2). a(4,3). a(5,4). a(6,3). a(7,2). a(8,1).
b(0,0). b(1,0). b(2,0). b(3,1). b(4,2). b(5,3). b(6,2). b(7,3). b(8,2).
c(0,0). c(1,2). c(2,1). c(3,0). c(4,1). c(5,2). c(6,3). c(7,4). c(8,3).
d(0,0). d(1,1). d(2,2). d(3,3). d(4,2). d(5,3). d(6,2). d(7,2). d(8,0).
e(0,0). e(1,2). e(2,1). e(3,2). e(4,1). e(5,2). e(6,1). e(7,2). e(8,1).
f(0,0). f(1,3). f(2,2). f(3,1). f(4,0). f(5,1). f(6,2). f(7,3). f(8,2).
g(0,0). g(1,2). g(2,3). g(3,4). g(4,3). g(5,2). g(6,2). g(7,0). g(8,1).
h(0,0). h(1,3). h(2,3). h(3,3). h(4,2). h(5,1). h(6,0). h(7,1). h(8,2).
i(0,0). i(1,4). i(2,3). i(3,2). i(4,1). i(5,0). i(6,1). i(7,2). i(8,3).

search(Graph, [Node|Path]):-
	choose( [Node|Path], Graph,_),
	state_of(Node, State),
	goal_state(State).
search(Graph, SolnPath):-
	choose(Path, Graph, OtherPaths),
	one_step_extensions(Path, NewPaths),
	add_to_paths(NewPaths, OtherPaths, GraphPlus),
	search(GraphPlus, SolnPath).


one_step_extensions([Node|Path], NewPaths) :-
	state_of(Node, State),
	gcost_of(Node, GPath),
	findall( [NewNode, Node|Path],
		 (   state_change(Rule,State,NewState,GCost,HCost),
		     Gactual is GPath + GCost,
		     FCost is Gactual + HCost,
		     make_node( Rule, NewState, Gactual, FCost, NewNode) ),
		 NewPaths).

state_of((_,(A,B,C,D,E,F,G,H,I),_,_), (A,B,C,D,E,F,G,H,I)).
gcost_of((_,(_,_,_,_,_,_,_,_,_),GC,_), GC).

make_node( Rule, NewState, Gactual, FCost, NewNode):-
	NewNode = (Rule, NewState, Gactual, FCost).

