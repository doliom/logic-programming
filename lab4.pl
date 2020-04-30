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

цель(['w','w','w','_','b','b','b']).

решить( Старт, Решение) :-
    вширину( [ [Старт] ], Решение).

вширину( [ [Верш | Путь] | _ ], [Верш | Путь] ) :- 
    цель( Верш).
 
вширину( [ [В | Путь] | Пути], Решение ) :-
    bagof( [В1, В | Путь ],
          ( swap( В, В1), not(member( В1, [В | Путь]))),
          НовПути),
    	append( Пути, НовПути, Пути1),  !,
    	вширину( Пути1, Решение);
    	вширину( Пути, Решение).

?- решить(['b','b','b','_','w','w','w'], X).