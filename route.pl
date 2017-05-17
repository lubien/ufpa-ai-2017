route(oradea, zerind, 71).
route(oradea, sibiu, 151).
route(zerind, arad, 75).
route(arad, sibiu, 140).
route(arad, timisoara, 118).
route(timisoara, lugoj, 111).
route(lugoj, mehadia, 70).
route(mehadia, dobreta, 75).
route(dobreta, craiova, 120).
route(craiova, rimnicu, 80).
route(rimnicu, sibiu, 80).
route(sibiu, fagaras, 99).
route(rimnicu, pitesti, 97).
route(craiova, pitesti, 138).
route(fagaras, bucharest, 211).
route(pitesti, bucharest, 101).
route(bucharest, giurgiu, 90).
route(bucharest, urziceni, 85).
route(urziceni, hirsova, 98).
route(hirsova, eforie, 86).
route(urziceni, vaslui, 142).
route(vaslui, lasi, 92).
route(lasi, neamt, 87).

distance(A, B, D):- route(A, B, D).
distance(A, B, D):- route(B, A, D).

path(A, B, Vis, Cost, TotalCost-Reversed):- distance(A, B, CostA),
                                            \+ member(A, Vis),
                                            reverse([B|[A|Vis]], Reversed),
                                            TotalCost is Cost + CostA.
path(A, B, Vis, Cost, Res1):- \+ distance(A, B, _),
                              \+ member(A, Vis),
                              distance(A, C, CostA),
                              path(C, B, [A|Vis], Cost + CostA, Res1).

path(A, B, Res):- path(A, B, [], 0, Res).

faster(A, B, Res):- findall(X, path(A, B, X), R),
                    keysort(R, Sorted),
                    [Res|_] = Sorted.
