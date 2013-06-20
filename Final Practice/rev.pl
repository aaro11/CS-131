
rev([], []).

rev([H|T], R) :- rev(T, X), append(X, [H], R).

