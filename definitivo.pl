:- dynamic(perguntas/2). %Diz que a lista de perguntas é dinâmica e poderá ser alterada ao longo do programa. 

perguntas('Oi',['Oi, Tudo bem?']).
perguntas('Tudo bem',['Comigo esta tudo bem. Sobre o que vc quer conversar?']).
perguntas(tchau,['Tchau']).
perguntas(_, []).

get_nome(_, Nome):- write('Entre com seu nome: '), read(Nome), !.

procura_pergunta(Entrada,Resposta) :- perguntas(Entrada,Resposta), !. %Procura no banco pela pergunta do usuario.  

sair(Entrada):-
	Entrada = tchau, write('Foi muito bom conversar com vc.'), !. %Procedimento para saída. 

get_response([], Resposta) :- 
	write('Nao entendo o que vc quer dizer.'), nl,
	write('Por favor, escreva uma pergunta e me ensine a resposta.'), nl,
	write('Escreva a Pergunta corretamente: '),
	read(PerguntaNova),
	write('Escreva a Resposta exatamente como vc deseja: '),
	read(RespostaNova),
	asserta(perguntas(PerguntaNova,[RespostaNova])),  % Coloca a pergunta e a resposta nova no banco de perguntas.
	Resposta = 'Estou ficando mais esperto, Continuemos.', !.
	
get_response(Lista, Resposta) :-
	length(Lista, NumItens), %Retorna o numero de itens na lista, neste caso 1.
	Indice is random(NumItens), %Gera um indice que neste caso é 1. 
	nth0(Indice, Lista, Resposta), !. %Pergunta se Resposta é elemento da lista no Indice gerado acima.

conversa:- 
	get_nome(_,Nome),
	repeat,
	nl, write(Nome),write(' diz: '),
	read(Entrada),
	procura_pergunta(Entrada, Lista),
	get_response(Lista, Resposta),
	write('Robo diz: '), write(Resposta), nl,
	sair(Entrada).