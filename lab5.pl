goal([3,_]).
 
next([X,Y],[9,Y],1):-
    X < 9.
next([X,Y],[0,Y],1):-
    X > 0.
next([X,Y],[X,5],1):-
    Y < 5.
next([X,Y],[X,0],1):-
    Y > 0.
next([X,Y],[0,Y1],1):-
    X > 0,
    Y+X =< 5,
    Y1 is X+Y.
next([X,Y],[Ost,5],1):-
    X > 0,
    X+Y > 5,
    Ost is (X+Y)-5.
next([X,Y],[X1,0],1):-
    Y > 0,
    X+Y =< 9,
    X1 is X+Y.
next([X,Y],[9,Ost],1):-
    Y > 0,
    X+Y > 9,
    Ost is (X+Y)-9.

solve(Node, Path/Cost) :-
  estimate(Node, Estimate),
  astar([[Node]/0/Estimate], Path/Cost/_).

estimate(State, Estimate):-
    goal(Goal),
    estimate_count(State, Goal, Estimate).

estimate_count(X,X,0):-!.

estimate_count([H1|_],[H2|_],Result):-
    Result is abs(H1-H2).

astar(Paths, Path) :-
  choose_min(Paths, Path),
  Path = [Node|_]/_/_,
  goal(Node).

astar(Paths, Solution) :-
  choose_min(Paths, BestPath),
  select(BestPath, Paths, OtherPaths),
  expand_astar(BestPath, ExpPaths),
  append(OtherPaths, ExpPaths, NewPaths),
  astar(NewPaths, Solution).

next_step([Node|Path]/Cost/_, [NextNode,Node|Path]/NewCost/Est) :-
  next(Node, NextNode, StepCost),
  \+ member(NextNode, Path),
  NewCost is Cost + StepCost,
  estimate(NextNode, Est).

expand_astar(Path, ExpPaths) :-
  findall(NewPath, next_step(Path,NewPath), ExpPaths).

choose_min([Path], Path) :- !.

choose_min([Path1/Cost1/Est1,_/Cost2/Est2|Paths], BestPath) :-
  Cost1 + Est1 =< Cost2 + Est2, !,
  choose_min([Path1/Cost1/Est1|Paths], BestPath).

choose_min([_|Paths], BestPath) :-
  choose_min(Paths, BestPath).