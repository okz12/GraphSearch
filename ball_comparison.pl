goal_state([_]).

weigh(sel1_3,[B1,B2,B3,B4,B5,B6,_], [B1, B2, B3]) :- B1 + B2 + B3 > B4 + B5 + B6.
weigh(sel3_6,[B1,B2,B3,B4,B5,B6,_], [B4, B5, B6]) :- B1 + B2 + B3 < B4 + B5 + B6.
weigh(sel7,[B1,B2,B3,B4,B5,B6,B7], [B7]) :- B1 + B2 + B3 == B4 + B5 + B6.


weigh(sel1,[B1,B2,_], [B1]) :- B1>B2.
weigh(sel2,[B1,B2,_], [B2]) :- B1<B2.
weigh(sel3,[B1,B2,B3], [B3]) :- B1==B2.

search(Graph, [Node|Path]):-
	choose( [Node|Path], Graph,_),
	state_of(Node, State),
	goal_state(State).
search(Graph, SolnPath):-
	choose(Path, Graph, OtherPaths),
	one_step_extensions(Path, NewPaths),
	add_to_paths(NewPaths, OtherPaths, GraphPlus),
	search(GraphPlus, SolnPath).

/*Compute all the nodes available by applying the state change rule*/
one_step_extensions([Node|Path], NewPaths):-
	state_of(Node, State),
	findall([NewNode, Node|Path],
			(weigh(Rule, State, NewState),
			make_node(Rule, NewState, NewNode)),
			NewPaths).

state_of((_,X), X).

/*choose the path at the beginning of our list of paths*/
choose(Path, [Path|OtherPaths], OtherPaths).

/*breadth first, so add new path to the end of the list of paths*/
add_to_paths(NewPaths, OtherPaths, AllPaths):-
	append(OtherPaths, NewPaths, AllPaths).

/*Make a new node with the rule(path) used to get to the node and the state of the node*/
	make_node(RuleName, NewState, NewNode):-
		NewNode = (RuleName, NewState).
