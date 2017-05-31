%% Busca Heuristica Russel x Norvig 
%% elf - 2017 
road(arad,zerind,75).
road(arad,sibiu,140).
road(arad,timisoara,118).
road(zerind,oradea,71).
road(oradea,sibiu,151).
road(sibiu,fagaras,99).
road(fagaras,bucharest,211).
road(bucharest,giurgiu,90).
road(bucharest,urziceni,85).
road(urziceni,hirsova,98).
road(urziceni,vaslui,142).
road(hirsova,eforie,86).
road(vaslui,lasi,92).
road(lasi,neamt,87).
road(sibiu,rimnicu,80).
road(rimnicu,pitesti,97).
road(rimnicu,craiova,146).
road(pitesti,craiova,138).
road(pitesti,bucharest,101).
road(timisoara,lugoj,111).
road(lugoj,mehadia,70).
road(mehadia,dobreta,75).
road(dobreta,craiova,120).
%%
h(arad, 	366).	
h(mehadia, 	241).
h(bucharest, 0).	
h(neamt, 	234). 
h(craiova, 	160).	
h(oradea ,	380). 
h(drobeta, 	242).	
h(pitesti, 	100). 
h(eforie ,	161). 	
h(rimnicu, 193).
h(fagaras, 	176).
h(sibiu ,	253).
h(giurgiu, 	77). 	
h(timisoara ,329). 
h(iasi, 	226).	
h(vaslui, 	199). 
h(lugoj, 	244). 	
h(zerind, 	374). 
h(hirsova, 	151).	
h(urziceni, 80).

%% ?- findall(X,h(_,X),L),sum_list(L,S).

prox(X,Y,C):-road(X,Y,C);road(Y,X,C).

% ?- busca(arad,[],[],Cam).
fim(bucharest).
%% busca gulosa com heuristica fraca???
                        % confirma o estado final, reverte o caminho até então e escreve na tela o caminho reverso
busca(X,VIS,OPEN,CAM):- fim(X),reverse(CAM,CAMr),write(CAMr),nl,!.
                        % encontra todas os pares no formato Y-C (ProximaCidade-Custo) ainda não visitados
busca(X,VIS,OPEN,CAM):- findall(Y-C,(prox(X,Y,C), \+member(Y,VIS)),L),
                        % ordena os pares e pega o menor deles
                        sort(2,<,L,Lo),Lo=[Yo-Co|_],
                        % adiciona o menor par à lista de visitados e ao caminho
                        VIS1=[Yo|VIS], CAM1=[Yo|CAM],
                        % passo recursivo
                        busca(Yo,VIS1,OPEN,CAM1). 
% ?- busca(arad,[arad],_,[arad]).

%% busca gulosa 
                                 % confirma o estado final, reverte o caminho até então e escreve na tela o caminho reverso,
                                 % além de retornar via Res o acumulador de distância
busca1(X,VIS,OPEN,CAM,Acc,Res):- fim(X),reverse(CAM,CAMr),write(CAMr), Res is Acc,nl,!.
                                 % encontra todas os pares no formato Y-C (ProximaCidade-Custo) ainda não visitados
                                 % onde este custo C, diferente da função anterior, baseia-se na heuristica (h)
busca1(X,VIS,OPEN,CAM,Acc,Res):- findall(Y-C,(prox(X,Y,_), h(Y,C),\+member(Y,VIS)),L),		 
                                 % ordena os pares e pega o menor deles
                                 sort(2,<,L,Lo),Lo=[Yo-Co|_], 
                                 % acrescenta este novo custo ao acumulador de custos 
                                 Acc1 is Acc + Co,
                                 % adiciona o menor par à lista de visitados e ao caminho
                                 VIS1=[Yo|VIS], CAM1=[Yo|CAM],
                                 % passo recursivo
                                 busca1(Yo,VIS1,OPEN,CAM1, Acc1, Res). 
% ?- busca1(arad,[arad],_,[arad]).


%% A* 
                         % confirma o estado final, reverte o caminho até então e escreve na tela o caminho reverso,
busca2(X,VIS,OPEN,CAM):- fim(X),reverse(CAM,CAMr),write(CAMr),nl,!.
busca2(X,VIS,OPEN,CAM):- 
          % pega o custo passado g(n)
          CAM=[G-Gn|_],
          % encontra todas os pares no formato Y-Cf (ProximaCidade-CustoCalculado) ainda não visitados
          % onde este custo C, diferente da função anterior, baseia-se na
          % soma do custo passado, custo entre cidades e a heuristica (h) e o 
          findall(Y-Cf,(prox(X,Y,C), h(Y,Ch),Cf is Gn+C+Ch, \+member(Y,VIS)),L),
          % ordena os pares e pega o menor deles
          sort(2,<,L,Lo),Lo=[Yo-Co|_], 
          % adiciona o menor par à lista de visitados
          VIS1=[Yo|VIS], 
          % calcula o proximo passo com um custo Cy, soma Cy ao custo passado e adiciona a proxima cidade Yo
          % e o custo Gy à lista de caminho
          prox(X,Yo,Cy), Gy is Gn+Cy, CAM1=[Yo-Gy|CAM],
          % passo recursivo
          busca2(Yo,VIS1,OPEN,CAM1). 
% ?- busca2(arad,[arad],_,[arad-0]).

%%%
/**
EX: 

a) Modifique as versões busca/busca1 para retornar a distancia desde da
cidade inicial ate cada uma delas como abaixo.

b) comente os busca, escrevendo acima de cada linha o 
que a linha seguinte esta fazendo, começando com os parametros 
o que entra e sai   

busca(arad,[],[],Cam).
[zerind,oradea,sibiu,rimnicu,pitesti,bucharest]
Cam = [].

?- busca2(arad,[arad],_,[arad-0]).
[arad-0,sibiu-140,rimnicu-220,pitesti-317,bucharest-418]
true ;
false.

?- busca1(arad,[arad],_,[arad-0]).
[arad-0,sibiu-140,fagaras-239,bucharest-450]
**/
		
						
