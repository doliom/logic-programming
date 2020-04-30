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

����(['w','w','w','_','b','b','b']).

������( �����, �������) :-
    �������( [ [�����] ], �������).

�������( [ [���� | ����] | _ ], [���� | ����] ) :- 
    ����( ����).
 
�������( [ [� | ����] | ����], ������� ) :-
    bagof( [�1, � | ���� ],
          ( swap( �, �1), not(member( �1, [� | ����]))),
          �������),
    	append( ����, �������, ����1),  !,
    	�������( ����1, �������);
    	�������( ����, �������).

?- ������(['b','b','b','_','w','w','w'], X).