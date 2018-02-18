head_of_list([H|_],H).

tail_of_list([X|[]],X).
tail_of_list([_|T],X) :- tail_of_list(T,X).

getElem([H|_],1,H).
getElem([_|T],N1,H) :- getElem(T, N, H),
	N1 is N + 1.

middle_of_list(List,X):- length(List,N), Y is (((N-1)//2) + 1)  , getElem(List,Y,X).

is_member(Elem,List) :- head_of_list(List,Elem).
is_member(Elem,[_|T]) :- is_member(Elem,T).

append_([],X,X).
append_([X|Y],Z,[X|W]) :- append_(Y, Z, W).

reverse([],[]).
reverse([H|T],R) :- reverse(T,RevT),  append(RevT,[H],R).

accRev([H|T],A,R) :- accRev(T,[H|A],R).
accRev([],A,A).

del_elem(F, [X|T], X, E) :- append(F2,T,E), reverse(F,F2).
del_elem(F, [Hr|Tr], X, E) :- del_elem([Hr|F], Tr, X, E).
%del_elem(_, X, X, _).
%del_elem(_, X, X, append(F,Tr)) :- del_elem(F, [X|Tr], X, _).
% del_elem(append(F,Hr), Tr, X, E) :- del_elem(append(F,Hr), [Hr|Tr],
% X, E).
%
%del_all_elem(_,L,X,_) :- !is_member(L,X).
% del_all_elem(F, L, X, E) :- del_all_elem(F,P,X,E), del_elem(F, L, X,
% P).

del_elem2(F, [X|T], X, E) :- append(F,T,E).
del_elem2(F, [Hr|Tr], X, E) :- del_elem2(F2, Tr, X, E), append(F,[Hr],F2).

del_elem_all(_,L,X,L) :- not(is_member(X,L)).
del_elem_all(F,L,X,E) :- del_elem2(F, L, X, Y), del_elem_all(F,Y,X,E).

subelem(F, [X|T], X, S, E) :- append(F,[S|T],E).
subelem(F, [Hr|Tr], X, S, E) :- subelem(F2, Tr, X, S, E), append(F,[Hr],F2).
sub_elem_all(_,L,X,_,L) :- not(is_member(X,L)).
sub_elem_all(F,L,X,S,E) :- subelem(F, L, X, S, Y), sub_elem_all(F,Y,X,S,E).


subequal([],_).
subequal([H|X],[H|Y]) :- subequal(X,Y).
sublist_eq(X,Y) :- subequal(X,Y).
sublist_eq(X,[_|Yt]) :- sublist_eq(X,Yt).

sievegt(O,[],_,O).
sievegt(Hd, [X|T], Lim, O) :- sievegt(Hd, T, Lim, O), X<Lim.
sievegt(Hd, [X|T], Lim, O) :- append(Hd,[X],Ne), sievegt(Ne, T, Lim, O), X>=Lim.

sievelt(O,[],_,O).
sievelt(Hd, [X|T], Lim, O) :- sievelt(Hd, T, Lim, O), X>=Lim.
sievelt(Hd, [X|T], Lim, O) :- append(Hd,[X],Ne), sievelt(Ne, T, Lim, O), X<Lim.


partition(OL2, 0, OL1, OL1, OL2).
partition([HI|TI], N1, L, OL1, OL2) :- append(L, [HI], NE), partition(TI, N, NE, OL1, OL2), N1 is N+1.


intersect([],_,O,O).
intersect([H1|T1],L2,X,O) :- append(X,[H1],N), is_member(H1,L2), intersect(T1,L2,N,O).

union([],[],O,O).
union([H1|T1],L2,Z,O) :- not(is_member(H1,Z)), append(Z,[H1],NE), union(T1,L2,NE,O).
union([H1|T1],L2,Z,O) :- is_member(H1, Z), union(T1, L2, Z, O).
union([],[H2|T2],Z,O) :- not(is_member(H2,Z)), append(Z,[H2],NE), union([],T2, NE, O).
union([], [H2|T2],Z,O) :- is_member(H2,Z), union([], T2, Z, O).

subset([], _).
subset([H1|T2],L) :- is_member(H1, L), subset(T2,L).

quicksort([X|Xs],Ys) :-
  div(Xs,X,Left,Right),
  quicksort(Left,Ls),
  quicksort(Right,Rs),
  append(Ls,[X|Rs],Ys).
quicksort([],[]).

div(L, Lim, Left, Right) :- sievelt([], L,Lim, Left), sievegt([], L, Lim, Right).
