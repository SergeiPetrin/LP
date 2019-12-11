member(X,[X|_]).
member(X,[_|T]) :- 
    member(X,T).

_length([],0).
_length([_|Y], N) :-
    _length(Y, N1), 
    N is 1 + N1.

append([],X,X).
append([X|Y],Z,[X|T]) :-
    append(Y,Z,T).

remove(X,[X|T],T).
remove(X,[Y|T],[Y|R]) :-
    remove(X,T,R).

permute([],[]).
permute(X,[Y|T1]) :-
    remove(Y,X,T),
    permute(T,T1).

sublist(S,R) :-
    append(X,_,S),
    append(_,R,X). 

count([], _Element, 0):-!.
count([Element|Tail], Element, Count):-
    !, count(Tail, Element, CountTail), 
    Count is CountTail + 1.
count([_Element|Tail], Element, Count):-
    count(Tail, Element, Count).

max([N],N)   :- !.
max([H|T],H) :-
    max(T,N1),
    N1<H.
max([H|T],N1) :-
    max(T,N1),
    N1>=H.
