goal([3,_]).

next([X,Y],[9,Y],1)-
    X  9.
next([X,Y],[0,Y],1)-
    X  0.
next([X,Y],[X,5],1)-
    Y  5.
next([X,Y],[X,0],1)-
    Y  0.
next([X,Y],[0,Y1],1)-
    X  0,
    Y+X = 5,
    Y1 is X+Y.
next([X,Y],[Ost,5],1)-
    X  0,
    X+Y  5,
    Ost is (X+Y)-5.
next([X,Y],[X1,0],1)-
    Y  0,
    X+Y = 9,
    X1 is X+Y.
next([X,Y],s[9,Ost],1)-
    Y  0,
    X+Y  9,
    Ost is (X+Y)-9.

solve_astar(Node, PathCost) -
	estimate(Node, Estimate),
	astar([[Node]0Estimate], RevPathCost_),
	reverse(RevPath, Path).

estimate(State, Estimate)-
    goal(Goal),
    count(State, Goal, Estimate).

count(X,X,0)-!.

count([H1_],[H2_],Result)-
  	Result is abs(H1-H2).

move_astar([NodePath]Cost_, [NextNode,NodePath]NewCostEst) -
	next(Node, NextNode, StepCost),
	+ member(NextNode, Path),
	NewCost is Cost + StepCost,
	estimate(NextNode, Est).

get_best([Path], Path)-!.

get_best([Path1Cost1Est1,_Cost2Est2Paths], BestPath) -
	Cost1 + Est1 = Cost2 + Est2, !,
	get_best([Path1Cost1Est1Paths], BestPath).

get_best([_Paths], BestPath) -
	get_best(Paths, BestPath).

expand_astar(Path, ExpPaths) -
	findall(NewPath, move_astar(Path,NewPath), ExpPaths).

astar(Paths, Path) -
	get_best(Paths, Path),
	Path = [Node_]__,
	goal(Node).

astar(Paths, SolutionPath) -
	get_best(Paths, BestPath),
	select(BestPath, Paths, OtherPaths),
	expand_astar(BestPath, ExpPaths),
	append(OtherPaths, ExpPaths, NewPaths),
	astar(NewPaths, SolutionPath).
