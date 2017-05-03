prox((X, Y), (4, Y)):- X < 4.
prox((X, Y), (X, 3)):- Y < 3.
prox((X, Y), (0, Y)):- X > 0.
prox((X, Y), (X, 0)):- Y > 0.
prox((X, Y), (A, B)):- Y < 3
	, A is X - min(X, 3 - Y)
	, B is min(3, X + Y).
prox((X, Y), (A, B)):- X < 4
	, A is min(4, X + Y)
	, B is Y - min(4 - X, Y).
	
fim((0, 2)).
fim((2, 0)).

cam((X, Y), (X1, Y1), [V | Vis]):- fim(V), reverse([V| Vis], R), write(R),!.
cam((X, Y), (X1, Y1), Vis):- prox((X, Y), (X1, Y1)), \+ member((X1, X1), Vis).
cam((X, Y), (X2, Y2), Vis):- prox((X, Y), (X1, Y1)), \+ member((X1, X1), Vis)
	, Vis1 = [(X1, Y1)| Vis]
	, cam((X1, Y1), (X2, Y2), Vis1).
