
eval(const(C), C).

eval(plus(E1, E2), C) :- eval(E1, C1), eval(E2, C2),
	C is C1 + C2.

