%% Busca cega = sem informação 
%% problema dos jaros - elf 
/*
1.	(X,Y) --> (4,Y) se X < 4
2.	(X,Y) --> (X,3) se Y < 3
3.	(X,Y) --> (0,Y) se X > 0
4.	(X,Y) --> (X,0) se Y > 0
5.	(X,Y) --> (X - min(X, 3-Y), min(3, X+Y)) se Y < 3
6.	(X,Y) --> (min(4, X+Y), Y - min(4-X, Y)) se X < 4
*/ 

prox((X,Y),(4,Y) ):- X < 4. % enche
prox((X,Y),(X,3) ):- Y < 3.
prox((X,Y),(0,Y) ):- X > 0. % esvazia 
prox((X,Y),(X,0) ):- Y > 0.
prox((X,Y),(X1,Y1)):- Y < 3, X1 is (X - min(X, 3-Y)), Y1 is min(3, X+Y). % troca 
prox((X,Y),(X1,Y1)):- X < 4, X1 is min(4, X+Y), Y1 is (Y - min(4-X, Y)).

%% estado inicial e final 
%fim((0,2)).
fim((2,0)).
%%
%% ?- busca(+Inicial,+Vis).
%% ?- busca((0,0),[(0,0)]). 
%%
%%  busca todas soluções por retrocesso, não entra em ciclo... 
%%  
busca((X,Y),Vis,Res):-prox((X,Y),(X1,Y1)),
                  \+ member((X1,Y1),Vis), fim((X1,Y1)),
                  reverse([(X1,Y1)|Vis],Res). 
busca((X,Y),Vis,Res1):-prox((X,Y),(X1,Y1)), 
                  \+ member((X1,Y1),Vis),Vis1=[(X1,Y1)|Vis],
				  busca((X1,Y1),Vis1, Res1).

%% Exercício: 
%% 1. modifique o prog para retornar as soluções
%% 2. usando findall/3 faça uma consula que encontra todas as soluções
%% 3. usando findall/3 + sort, encontre uma solução de menor comprimento
%% 
%% DICAS: 
%%   (use length/2 para calcular o comprimento, e guarde com findall 
%% numa lista 5-[(0,0),..(0,2),(2,0)], 7-[(0,0),.. ..(2,0)]
%% ?- L=[5-a, 7-b, 1-c, 1-c, 18-d],sort(2,>=,L, Lo).
%% sort com >= ou =< deixa os repetidos, > < remove os repetidos  
%% OBS: PROLOG reserva => <= para implementar regras lógica 
%%  

all_solutions(S):- busca((0, 0), [(0, 0)], R), findall(R, member((2, 0), R), S).
smallest_solution(S):- all_solutions(R),
                       map_list_to_pairs(length, R, Pairs),
                       keysort(Pairs, Sorted),
                       [S|_] = Sorted.
