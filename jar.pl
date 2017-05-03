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
