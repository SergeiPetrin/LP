shop_open('obuv','vtornik').
shop_open('obuv','sreda').
shop_open('obuv','chetverg').
shop_open('obuv','pyatnica').
shop_open('obuv','subbota').

shop_open('hoz','ponedelnik').
shop_open('hoz','sreda').
shop_open('hoz','chetverg').
shop_open('hoz','pyatnica').
shop_open('hoz','subbota').

shop_open('prod','ponedelnik').
shop_open('prod','vtornik').
shop_open('prod','sreda').
shop_open('prod','pyatnica').
shop_open('prod','subbota').

shop_open('parfum', 'ponedelnik').
shop_open('parfum', 'sreda').
shop_open('parfum', 'pyatnica').

close1('parfum', 'vtornik').
close1('parfum', 'chetverg').
close1('parfum', 'subbota').
close1('obuv','ponedelnik').
close1('hoz','vtornik').
close1('prod','chetverg').


getLenList([],0).
getLenList([_|L],N):- getLenList(L,N1), N is N1+1.

findmax([L|Ls], Max) :-
    findmax(Ls, L, Max).

findmax([], Max, Max).
findmax([L|Ls], Max0, Max) :-
    Max1 is max(L, Max0),
    findmax(Ls, Max1, Max).

num([],N,_):- N is 0.
num([L|_],N,Max) :- N is 1, L = Max.
num([_|Ls],N,Max):- num(Ls,N1,Max), N is N1+1.

day([],_,_,_):-!.
day([L|_],N,L,Num):- N=Num.
day([_|Ls],N,S,Num):- Num1 is Num + 1, day(Ls,N,S,Num1).

poisk(NextDay,PrevDay, S, Name,_,_,_,_,_,_, Name):- member(NextDay,S), member(PrevDay,S).
poisk(NextDay,PrevDay, _, _,S,Name,_,_,_,_, Name):- member(NextDay,S), member(PrevDay,S).
poisk(NextDay,PrevDay, _, _,_,_,S,Name,_,_, Name):- member(NextDay,S), member(PrevDay,S).
poisk(NextDay,PrevDay, _, _,_,_,_,_,S,Name, Name):- member(NextDay,S), member(PrevDay,S).
poisk(\_,_, _, _,_,_,_,_,_,_, 'No'):-!.

elem([L|_],L):-!.

work :-
     L = ['ponedelnik','vtornik','sreda','chetverg', 'pyatnica', 'subbota', 'voskresenye'],
     F = [F0,F1,F2,F3,F4,F5,F6],
     findall(X,shop_open(X,'ponedelnik') ,Pn),
     findall(X,shop_open(X,'vtornik') ,Vt),
     findall(X,shop_open(X, 'sreda') ,Sr),
     findall(X,shop_open(X,'chetverg') ,Ch),
     findall(X,shop_open(X,'pyatnica') ,Pt),
     findall(X,shop_open(X,'subbota') ,Sb),
     findall(X,shop_open(X,'voskresenye') ,Vs),
     getLenList(Pn,F0),
     getLenList(Vt,F1),
     getLenList(Sr,F2),
     getLenList(Ch,F3),
     getLenList(Pt,F4),
     getLenList(Sb,F5),
     getLenList(Vs,F6),

     findmax(F,Max),
     num(F,N,Max),
     day(L,N,NowDay,1),
     N1 is N + 1, N2 is N - 1, N3 is N2 - 1,
     day(L,N1,NextDay,1),
     day(L,N2,PrevDay,1),
     day(L,N3,PrevprevDay,1),

     findall(X,shop_open('obuv',X) ,Ob),
     findall(X,shop_open('hoz',X) ,Hz),
     findall(X,shop_open('prod', X) ,Prd),
     findall(X,shop_open('parfum',X) ,Prf),

     poisk(NextDay,PrevDay, Ob,'obuv',Hz,'hoz',Prd,'prod', Prf, 'parfum', Zhenya),
     poisk(PrevprevDay,PrevDay, Ob,'obuv',Hz,'hoz',Prd,'prod', Prf, 'parfum', Klava),
     findall(X,close1(X,NextDay) ,List1),
     delete(List1,Zhenya,List2),
     delete(List2, Klava, List),
     elem(List,Ira),
     findall(X,shop_open(X,NowDay) ,Result1),
     delete(Result1,Zhenya,Result2),
     delete(Result2, Klava, Result3),
     delete(Result3,Ira,Result),
     elem(Result,Asya),
     write('Ася : '), write(Asya), nl,
     write('Женя : '), write(Zhenya), nl,
     write('Клава : '), write(Klava), nl,
     write('Ира : '), write(Ira), nl,
     !.
