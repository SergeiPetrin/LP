ubject('LP','Логическое программирование').
subject('MTH','Математика').
subject('FP','Функциональное программирование').
subject('INF','Информатика').
subject('ENG','Английский язык').
subject('PSY','Физика').
student(102,'Петрин',[grade('LP',3),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',5),grade('PSY',4)]).
student(101,'Сазонов',[grade('LP',5),grade('MTH',4),grade('FP',3),grade('INF',4),grade('ENG',2),grade('PSY',4)]).
student(104,'Купцов',[grade('LP',4),grade('MTH',5),grade('FP',5),grade('INF',4),grade('ENG',3),grade('PSY',3)]).
student(102,'Ильминский',[grade('LP',3),grade('MTH',4),grade('FP',3),grade('INF',3),grade('ENG',3),grade('PSY',5)]).
student(104,'Хренов',[grade('LP',3),grade('MTH',3),grade('FP',3),grade('INF',5),grade('ENG',5),grade('PSY',2)]).
student(101,'Син',[grade('LP',5),grade('MTH',3),grade('FP',5),grade('INF',5),grade('ENG',4),grade('PSY',2)]).
student(103,'Суслов',[grade('LP',4),grade('MTH',4),grade('FP',2),grade('INF',3),grade('ENG',4),grade('PSY',3)]).
student(102,'Кронберг',[grade('LP',4),grade('MTH',5),grade('FP',5),grade('INF',3),grade('ENG',3),grade('PSY',4)]).
student(103,'Камеш',[grade('LP',4),grade('MTH',5),grade('FP',3),grade('INF',3),grade('ENG',4),grade('PSY',4)]).
student(103,'Гамов',[grade('LP',3),grade('MTH',5),grade('FP',3),grade('INF',4),grade('ENG',3),grade('PSY',4)]).
student(103,'Лагода',[grade('LP',3),grade('MTH',5),grade('FP',4),grade('INF',3),grade('ENG',5),grade('PSY',4)]).
student(104,'Егорова',[grade('LP',5),grade('MTH',4),grade('FP',4),grade('INF',5),grade('ENG',3),grade('PSY',4)]).
student(103,'Карых',[grade('LP',3),grade('MTH',2),grade('FP',3),grade('INF',2),grade('ENG',5),grade('PSY',4)]).
student(101,'Лысиков',[grade('LP',5),grade('MTH',5),grade('FP',2),grade('INF',4),grade('ENG',4),grade('PSY',2)]).
student(104,'Онищенко',[grade('LP',5),grade('MTH',4),grade('FP',5),grade('INF',4),grade('ENG',4),grade('PSY',4)]).
student(101,'Шичко',[grade('LP',5),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',5),grade('PSY',4)]).
student(102,'Токарев',[grade('LP',4),grade('MTH',3),grade('FP',2),grade('INF',3),grade('ENG',3),grade('PSY',4)]).
student(104,'Тояков',[grade('LP',5),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',2),grade('PSY',4)]).
student(103,'Андреев',[grade('LP',3),grade('MTH',3),grade('FP',5),grade('INF',5),grade('ENG',5),grade('PSY',4)]).
student(102,'Цапков',[grade('LP',4),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',4),grade('PSY',3)]).
student(102,'Патрикеева',[grade('LP',5),grade('MTH',4),grade('FP',5),grade('INF',2),grade('ENG',3),grade('PSY',4)]).
student(103,'Скворцов',[grade('LP',3),grade('MTH',4),grade('FP',3),grade('INF',4),grade('ENG',4),grade('PSY',4)]).
student(101,'Конарев',[grade('LP',4),grade('MTH',5),grade('FP',4),grade('INF',4),grade('ENG',5),grade('PSY',4)]).
student(102,'Драчев',[grade('LP',4),grade('MTH',3),grade('FP',4),grade('INF',4),grade('ENG',3),grade('PSY',4)]).
student(104,'Бердикин',[grade('LP',4),grade('MTH',2),grade('FP',5),grade('INF',2),grade('ENG',5),grade('PSY',3)]).
student(102,'Васильев',[grade('LP',5),grade('MTH',2),grade('FP',5),grade('INF',5),grade('ENG',4),grade('PSY',5)]).
student(103,'Эссаулов',[grade('LP',4),grade('MTH',5),grade('FP',4),grade('INF',5),grade('ENG',4),grade('PSY',4)]).
student(102,'Савров',[grade('LP',3),grade('MTH',4),grade('FP',5),grade('INF',3),grade('ENG',4),grade('PSY',5)]).

listsum([], 0).
listsum([Head|Tail], Result) :-
    listsum(Tail, SumOfTail),
    Result is Head + SumOfTail.

getLenList([],0).
getLenList([_|L],N):- getLenList(L,N1), N is N1+1.


firstpart :-
    findall(X,student(_,X,[grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]),L0),
    getLenList(L0,F),
    findall(X,student(_,_,[grade('LP',X),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]),L1),
    listsum(L1,Res1),
    LP is Res1 / F,
    findall(X,student(_,_,[grade('LP',_),grade('MTH',X),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]),L2),
    listsum(L2,Res2),
    MTH is Res2 / F,
    findall(X,student(_,_,[grade('LP',_),grade('MTH',_),grade('FP',X),grade('INF',_),grade('ENG',_),grade('PSY',_)]),L3),
    listsum(L3,Res3),
    FP is Res3 / F,
    findall(X,student(_,_,[grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',X),grade('ENG',_),grade('PSY',_)]),L4),
    listsum(L4,Res4),
    INF is Res4 / F,
    findall(X,student(_,_,[grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',X),grade('PSY',_)]),L5),
    listsum(L5,Res5),
    ENG is Res5 / F,
    findall(X,student(_,_,[grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',X)]),L6),
    listsum(L6,Res6),
    PSY is Res6 / F,
   write("LP is : "), write(LP), nl, write("MTH is :  "),write(MTH), nl, write("FP is :  "),write(FP), nl, write("INF is : "),write(INF), nl, write("ENG is : "),write(ENG), nl, write("PSY is : "),write(PSY), nl,
   !.

set([], []).
set([H | T1], [H | T2]):-
 delete(T1, H, Tres),
 set(Tres, T2).

map([], []).
map([H|T], [H|T1]) :- subtract(T, [H], T2), map(T2, T1).

forgrup(NumG,X) :-
  findall(F,student(NumG,F,[grade('LP',2),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]) ,LP),
  findall(F,student(NumG,F,[grade('LP',_),grade('MTH',2),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]) ,MTH),
  findall(F,student(NumG,F,[grade('LP',_),grade('MTH',_),grade('FP',2),grade('INF',_),grade('ENG',_),grade('PSY',_)]) ,FP),
  findall(F,student(NumG,F,[grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',2),grade('ENG',_),grade('PSY',_)]) ,INF),
  findall(F,student(NumG,F,[grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',2),grade('PSY',_)]) ,ENG),
  findall(F,student(NumG,F,[grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',2)]) ,PSY),
  append(LP,MTH,MY1),
  append(MY1,FP,MY2),
  append(MY2,INF,MY3),
  append(MY3,ENG,MY4),
  append(MY4,PSY,MY),
  map(MY,NEWMY),
  getLenList(NEWMY,X),
  !.

secondpart:-
    forgrup(101,X1), write("Luser's of 101 : "), write(X1), nl,
    forgrup(102,X2), write("Luser's of 102 : "), write(X2), nl,
    forgrup(103,X3), write("Luser's of 103 : "), write(X3), nl,
    forgrup(104,X4), write("Luser's of 104 : "), write(X4), nl,
    !.


thirdpart:-
    findall(_,student(_,_,[grade('LP',2),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]) ,LP),
    getLenList(LP,NLP),
    write("LP is : "), write(NLP), nl,

    findall(_,student(_,_,[grade('LP',_),grade('MTH',2),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',_)]) ,MTH),
    getLenList(MTH,NMTH),
    write("MTH is : "), write(NMTH), nl,

    findall(_,student(_,_,[grade('LP',_),grade('MTH',_),grade('FP',2),grade('INF',_),grade('ENG',_),grade('PSY',_)]) ,FP),
    getLenList(FP,NFP),
    write("FP is : "), write(NFP), nl,

    findall(_,student(_,_,[grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',2),grade('ENG',_),grade('PSY',_)]) ,INF),
    getLenList(INF,NINF),
    write("INF is : "), write(NINF), nl,

    findall(_,student(_,_,[grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',2),grade('PSY',_)]) ,ENG),
    getLenList(ENG,NENG),
    write("ENG is : "), write(NENG), nl,

    findall(_,student(_,_,[grade('LP',_),grade('MTH',_),grade('FP',_),grade('INF',_),grade('ENG',_),grade('PSY',2)]) ,PSY),
    getLenList(PSY,NPSY),
    write("PSY is : "), write(NPSY), nl,
    !.

