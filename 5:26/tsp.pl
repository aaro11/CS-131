
dist(losAngeles, seattle, 1130).
dist(losAngeles, sanFrancisco, 390).
dist(losAngeles, sanDiego, 130).
dist(seattle, sanDiego, 1260).
dist(seattle, sanFrancisco, 810).
dist(sanFrancisco, sanDiego, 510).

symmetricDist(X,Y,L) :- dist(X,Y,L).
symmetricDist(X,Y,L) :- dist(Y,X,L).


sum([], 0).

sum([_], 0).

sum([H1,H2|T], L) :- symmetricDist(H1,H2,D),
	sum([H2|T], Drest), L is D + Drest.
	

tsp(Cities, Tour, Length) :-
	permutation(Cities, [Head|Rest]),
	append([Head|Rest], [Head], Tour),
	sum(Tour, Length).

	