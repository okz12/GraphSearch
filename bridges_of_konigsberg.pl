%data structure (pos, (zy,zx,zw, wy, wx))
goal_state((_,(1,1,1,1,1))).

cross(y_z,(y,(0,A,B,C,D)),(z,(1,A,B,C,D))).
cross(z_y,(z,(0,A,B,C,D)),(y,(1,A,B,C,D))).

cross(z_x,(z,(A,0,B,C,D)),(x,(A,1,B,C,D))).
cross(x_z,(x,(A,0,B,C,D)),(z,(A,1,B,C,D))).

cross(z_w,(z,(A,B,0,C,D)),(w,(A,B,1,C,D))).
cross(w_z,(w,(A,B,0,C,D)),(z,(A,B,1,C,D))).

cross(w_y, (w, (A,B,C,S,D)) , (y,(A,B,C,E,D))) :- S<1, E is S+1.
cross(y_w, (y, (A,B,C,S,D)) , (w,(A,B,C,E,D))) :- S<1, E is S+1.

cross(w_x, (w, (A,B,C,D,S)) , (x,(A,B,C,D,E))) :- S<2, E is S+1.
cross(x_w, (x, (A,B,C,D,S)) , (w,(A,B,C,D,E))) :- S<2, E is S+1.

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
			(cross(Rule, State, NewState),
			make_node(Rule, NewState, NewNode)),
			NewPaths).

/*the anonymous variable is the rule//edge leading to the node. can disguard*/
state_of((_,(L,(A,B,C,D,E))), (L,(A,B,C,D,E))).

/*choose the path at the beginning of our list of paths*/
choose(Path, [Path|OtherPaths], OtherPaths).

/*breadth first, so add new path to the end of the list of paths*/
add_to_paths(NewPaths, OtherPaths, AllPaths):-
	append(OtherPaths, NewPaths, AllPaths).

/*Make a new node with the rule(path) used to get to the node and the state of the node*/
	make_node(RuleName, NewState, NewNode):-
		NewNode = (RuleName, NewState).
