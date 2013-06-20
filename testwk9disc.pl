% product of two lists
prod([X], [Y], [R]) :- R is X * Y.
prod([_|Xs], [_|Ys], [R|Rs]) :- prod(Xs, Ys, Rs), R is Xs * Ys. 

% counting an element in a list
count(_, [], 0).
count(X, [X|Xs], Z) :- count(X, Xs, T),  Z is T+1.
count(X, [Y|Xs], Z) :- \+ (X=Y), count(X, Xs, Z).

% length of a list
myLength([], 0).
myLength([_|Xs], Z) :- myLength(Xs, T), Z is T+ 1.

% is a list a set
set([]).
set([X|Xs]) :- \+ (member(X,Xs)), set(Xs).

% all permutations of a list
permute([], []).
permute([X|T], Z) :- permute(T, Rest), add(X, Rest, Z).

% add(X,L,L1).
% adds element X to the beginning of the list L and returns L1
add(X,L,[X|L]).

% add(X,L,L1)
% adds element X to the end of the list L and returns L1
add(X,[],[X]).
add(X,[A|L],[A|L1]):-
add(X,L,L1).
