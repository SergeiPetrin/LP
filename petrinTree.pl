male('Александр Петрин').
male('Сергей Петрин').
male('Анатолий Долгов').
male('Виктор Петрин').
male('Иван Долгов').
male('Василий Голев').
male('Михаил Лермонтов').
male('Михаил Голев').

female('Татьяна Долгова').
female('Валентина Голева').
female('Надежда Галахова').
female('Зинаида Иванова').
female('Нина Пушкина').
female('Александра Первая').
female('Анна Петрова').

child('Сергей Петрин', 'Александр Петрин').
child('Сергей Петрин', 'Татьяна Долгова').
child('Татьяна Долгова', 'Анатолий Долгов').
child('Татьяна Долгова', 'Валентина Голева').
child('Александр Петрин', 'Виктор Петрин').
child('Александр Петрин', 'Надежда Галахова').
child('Анатолий Долгов', 'Иван Долгов').
child('Анатолий Долгов', 'Зинаида Иванова').
child('Валентина Голева', 'Василий Голев').
child('Валентина Голева', 'Нина Пушкина').
child('Нина Пушкина', 'Михаил Лермонтов').
child('Нина Пушкина', 'Александра Первая').
child('Василий Голев', 'Михаил Голев').
child('Василий Голев', 'Анна Петрова').

del( X, [X|T], T).
del( X, [H|T], [H | T1] ) :-
 del( X, T, T1).

find_bro([H|T],B):-sex(H,Sex),(Sex == 'm' -> B is H,!;find_bro(T,B)).

my_pred([],[]).
my_pred([H|T],KS1):-my_pred(T,U),findall(K1,(parents(K1,H,_)->sex(K1,Sex)-> Sex == 'm'),KS1),
                                    findall(K2,(parents(K2,_,H)->sex(K2,Sex)-> Sex == 'm'),KS2),
                                                                             append(KS1,KS2,KS), append(KS,U,KS1).

brother(F,M,E,B):-findall(T,parents(T,F,M),X), length(X,N), N > 1,del(E,X,X1),find_bro(X1,B).


dbro(X,S):-parents(X,F,M),parents(F,FF,FM), parents(M,MF,MM),
    findall(T,parents(T,FF,FM),FX), length(FX,FN), FN > 1,del(F,FX,FX1),my_pred(FX1,KS),
    findall(T,parents(T,MF,MM),MX), length(MX,MN), MN > 1,del(M,MX,MX1), my_pred(MX1,LS),
    append(KS,LS,S),write(S), nl.

dbro(X,S):-parents(X,F,_),parents(F,FF,FM),
    findall(T,parents(T,FF,FM),FX), length(FX,FN), FN > 1,del(F,FX,FX1),my_pred(FX1,S), write(S), nl.

dbro(X,S):-parents(X,_,M),parents(M,MF,MM),
    findall(T,parents(T,MF,MM),MX), length(MX,MN), MN > 1,del(M,MX,MX1), my_pred(MX1,S), write(S), nl.
