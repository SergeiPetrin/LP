sex(Сергей Петрин, 'm').
sex(Александр Петрин, 'm').
sex(Виктор Петрин, 'm').
sex(Кирилл Петрин, 'm').
sex(Николай Толстой, 'm').
sex(Иван Долгов, 'm').
sex(Санчоус ТотСамый, 'm').
sex(Анатолий Долгов, 'm').
sex(Михаил Голев, 'm').
sex(Василий Голев, 'm').
sex(Михаил Лермонтов, 'm').
sex(Надежда Галахова,'f').
sex(Татьяна Долгова, 'f').
sex(Зинаида Иванова,'f').
sex(Лень Придумывать,'f').
sex(Надежда Галахова,'f').
sex(Кристина ТотСамый,'f').
sex(Валентина Голева,'f').
sex(Анна Петрова,'f').
sex(Нина Пушкина,'f').
sex(Александра Первая,'f').
parents(Сергей Петрин, Александр Петрин, Татьяна Долгова).
parents(Кирилл Петрин, Александр Петрин, Татьяна Долгова).
parents(Николай Толстой, Анатолий Долгов, Валентина Голева).
parents(Татьяна Долгова, Анатолий Долгов, Валентина Голева).
parents(Александр Петрин, Виктор Петрин, Надежда Галахова).
parents(Анатолий Долгов, Иван Долгов, Зинаида Иванова).
parents(Валентина Голева, Василий Голев, Нина Пушкина).
parents(Нина Пушкина, Михаил Лермонтов, Александра Первая).
parents(Василий Голев, Михаил Голев, Анна /Петрова).
parents(Санчоус ТотСамый, Николай Толстой, Лень Придумывать).
parents(Кристина ТотСамый, Николай Толстой, Лень Придумывать).

del( X, [X|T], T).
del( X, [H|T], [H | T1] ) :-
 del( X, T, T1).

find_bro([H|T],B):-sex(H,Sex),(Sex == 'm' -> B is H,!;find_bro(T,B)).

my_pred([],[]).
my_pred([H|T],KS1):-my_pred(T,U),findall(K1,(parents(K1,H,_)->sex(K1,Sex)-> Sex == 'm'),KS1),
                                    findall(K2,(parents(K2,_,H)->sex(K2,Sex)-> Sex == 'm'),KS2),
                                                                             append(KS1,KS2,KS), append(KS,U,KS1).

dbro(X,S):-parents(X,F,M),parents(F,FF,FM), parents(M,MF,MM),
    findall(T,parents(T,FF,FM),FX), length(FX,FN), FN > 1,del(F,FX,FX1),my_pred(FX1,KS),
    findall(T,parents(T,MF,MM),MX), length(MX,MN), MN > 1,del(M,MX,MX1), my_pred(MX1,LS),
    append(KS,LS,S),write(S), nl.

dbro(X,S):-parents(X,F,_),parents(F,FF,FM),
    findall(T,parents(T,FF,FM),FX), length(FX,FN), FN > 1,del(F,FX,FX1),my_pred(FX1,S), write(S), nl.

dbro(X,S):-parents(X,_,M),parents(M,MF,MM),
    findall(T,parents(T,MF,MM),MX), length(MX,MN), MN > 1,del(M,MX,MX1), my_pred(MX1,S), write(S), nl.
