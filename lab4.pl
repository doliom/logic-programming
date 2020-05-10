append([],B,B).

append([H|Tail],B,[H|NewTail]):-
	append(Tail,B,NewTail).

swap(A,B):-
	append(Begin,['_','w'|Tail],A),
	append(Begin,['w','_'|Tail],B).

swap(A,B):-
	append(Begin,['b','_'|Tail],A),
	append(Begin,['_','b'|Tail],B).

swap(A,B):-
	append(Begin,['_','b','w'|Tail],A),
	append(Begin,['w','b','_'|Tail],B).

swap(A,B):-
	append(Begin,['b','w','_'|Tail],A),
	append(Begin,['_','w','b'|Tail],B).

goal(['w','w','w','_','b','b','b']).

solve( Start, Solution) :-
    bfs( [ [Start] ], Solution).

bfs( [ [Node | Path] | _ ], [Node | Path] ) :- 
    goal( Node).
 
bfs( [ [N | Path] | Paths], Solution ) :-
    bagof( [N1, N | Path ],
          ( swap( N, N1), not(member( N1, [N | Path]))),
          NewPaths),
    	append( Paths, NewPaths, Paths1),  !,
    	bfs( Paths1, Solution);
    	bfs( Paths, Solution).

?- solve(['b','b','b','_','w','w','w'], X).