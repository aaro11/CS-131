fact(0,1). 
fact(X,Y) :- X>0, R is X-1, fact(R,Z), Y is X * Z.

rev([],[]).
rev([X|Xs], List) :- append(R, [X], List), rev(Xs, R).

count([], 0).
count([H|T], Z) :- count(T, R), Z is 1 + R.

count(_, [], 0).
count(X, [X|Xs], Z) :- count(X, Xs, R), Z is R+1.
count(Y, [X|Xs], Z) :- \+(X=Y), count(Y, Xs, Z).

dblOdd([],[]).
dblOdd([X], [X,X]).
dblOdd([X,Y|Xs], Z) :- dblOdd(Xs, R), append([X,X], R, Z).

index(0, [X|Xs], X).
index(Y, [X|Xs], Z) :- \+ (Y=:=0), T is Y-1, index(T, Xs, Z). 

dupList([],[]).
dupList([X|Xs], Y) :- append([X,X], R, Y), dupList(Xs, R).

sqrNum([X], [Y]) :- Y is X * X.
sqrNum([X|Xs], Z) :- Y is X * X, append([Y], R, Z), dblNum(Xs, R).

addNum([X], X).
addNum([X|Xs], Z) :- addNum(Xs, R), Z is R+X.

allPos([],0).
allPos([X|Xs], Z) :- (X > 0), allPos(Xs, R), Z is R + 1.
allPos([X|Xs], Z) :- (X < 1), allPos(Xs, Z). 

p(f(Y)) :- q(Y), r(Y).
p(b).
q(h(Z)) :- t(Z).
r(h(a)).
t(a).
