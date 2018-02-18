%7 glass 5 glass
goal_state((4,_)).
start_state((0,0)).

%empty
trans(empty5,(L,X),(Y,X)) :- Y is 0, L>0.
trans(empty7,(X,L),(X,Y)) :- Y is 0, L>0.

%fill
trans(fill7,(L,X),(Y,X)) :- Y is 7, L<7.
trans(fill5,(X,L),(X,Z)) :- Z is 5, L<5.

%transfer LTR
trans(transLTR,(L,R),(Z,X)) :- L + R=<5, X is L + R, Z is 0, L>0, R<5.
trans(transLTR,(L,R),(X,Z)) :- L + R>5, X is L-5+R, Z is 5, L>0, R<5, X<7.

%transfer RTL
trans(transRTL,(L,R),(X,Z)) :- L + R =<7, X is L+R, Z is 0, L<7, R>0.
trans(transRTL,(L,R),(Z,X)) :- L + R > 7, X is R-7+L, Z is 7, L<7, R>0, X<5.



search( Paths, [Node|Path] ) :-
	choose( [Node|Path], Paths, _ ),
	state_of( Node, State ),
	goal_state( State ).
search( Paths, SolnPath ) :-
	choose( Path, Paths, OtherPaths ),
	one_step_extensions( Path, NewPaths ),
	add_to_paths( NewPaths, OtherPaths, AllPaths ),
	search( AllPaths, SolnPath ).

choose( Path, [Path|Paths], Paths ).

add_to_paths( NP, OP, AllP ) :-
	append( OP, NP, AllP ).

one_step_extensions( [Node|Path], NewPaths ) :-
	state_of( Node, State ),
	findall( [NewNode,Node|Path],
		 ( trans( Rule, State, NewState ),
		  make_node( Rule, NewState, NewNode ) ),
		 NewPaths ).

state_of((_,(X,Y)), (X,Y)).

make_node(RuleName, NewState, NewNode):- NewNode = (RuleName, NewState).
