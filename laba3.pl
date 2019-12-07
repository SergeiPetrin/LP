solve(X, Res1, Res2, Res3):- reverse(X, X1), permutation(X1, Y), bw(Y), dfs(s(X1, [], []), s([], [], Y), R1),
                                                                        bfs(s(X1, [], []), s([], [], Y), R2),
                                                                        id(s(X1, [], []), s([], [], Y), R3),
                                                                        reverse_all(R1, Z1), reverse(Z1, Res1),
                                                                        reverse_all(R2, Z2), reverse(Z2, Res2),
                                                                        reverse_all(R3, Z3), reverse(Z3, Res3), !.
reverse_all([], []).
reverse_all([s(X, Y, Z) | T], [s(P, Q, R) | RT]):- reverse(X, P), reverse(Y, Q), reverse(Z, R), reverse_all(T, RT).

bw(X):- bw1(X); bw2(X).
bw1([]).

bw1([X | T]):- X==b, bw2(T).
bw2([]).

bw2([X | T]):- X==w, bw1(T).

first([], []).
first([X | T], X).

prolong([X | T], [Y, X | T]):- move(X, Y), \+(member(Y, [X | T])).
dfs_path([X | T], X, [X | T]).
dfs_path(P, B, R):- prolong(P, P1), dfs_path(P1, B, R).
dfs(A, B, R):- dfs_path([A], B, R).

path([[X | T] | _], X, [X | T]).
path([P | Q], B, R):- findall(X, prolong(P, X), L), append(Q, L, QL), !, path(QL, B, R).
path([_ | Q], B, R):- path(Q, B, R).
bfs(A, B, R):- path([[A]], B, R).

id_path([X | T], X, [X | T], _).
id_path(P, B, R, N):- N > 0, prolong(P, P1), N1 is N - 1, id_path(P1, B, R, N1).
id(s(X, Y, Z), B, R):- length(X, L), N is 3 * L / 2, id_path([s(X, Y, Z)], B, R, N).

move(s([A | AT], B, C), s(AT, B, [A | C])):- first(C, X), X \= A.
move(s(A, [B | BT], C), s(A, BT, [B | C])):- first(C, X), X \= B.
move(s([A | AT], B, C), s(AT, [A | B], C)):- first(C, X), X == A.
