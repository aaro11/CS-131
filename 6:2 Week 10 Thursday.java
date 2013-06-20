/* unification produces a substituion that makes the term equal

E1 = E2

tries to find a substitution s (mapping from variables to terms)
such that s(E1) = s(E2) (the trees are equal)

otherwise, it says "no"
=============================

s is a *unifier* for t1 and t2 if s(t1) = s(t2).

there's always a *most general unifire* (MGU) or substitution for any two terms that unify:

s is an MGU for t1 and t2 if s(t1) = s(t2) and for any other unifier
s', then there exists a substituion s'' such that
   s''(s(t1)) = s'(t1) and s''(s(t2)) = s'(t2)

there's always a unique answer to the query in the langauge

example: f(X,Y) = f(a,Y)

{X->a, Y->a}
{X->a, Y->b}
...
MGU: {X->a}

=============================
Let's define MGU: t=term, c=constant, a=atom, X=variable

MGU(c,c) = {}
MGU(X,X) = {}

MGU(X,t) = {X->t} if X not in t, else "no" [occurs check]
MGU(t,X) = {X->t} if X not in t, else "no"

MGU(a(t1,...,tn), a(t1',...,tn')) = 
  for each i, MGU (ti, ti') = si
  if any of those fails to unify, then return "no"
  otherwise, return if [s1 U s2 U ... U sn] is inconsistent, return "no"
  else return s1 U ... U sn

MGU(_,_) = "no"

example: (this is okay)
g(a, X, X) = g(Y, b, Z)
 - recursively ask
       a = Y
       X = b
       X = Z

      {Y->a, X->b, X->Z} ---> {Y->a, X->b, Z->b}

example:

MGU(X,f(X)) = {X->f(X)}

===================

Key computation step in Prolog is *resolution*:

A *clause* is either a fact or a rule. The head of a clause is either
the fact itself (if a fact) or the head of the rule. The tail of a clause
is nothing (if a fact) or the body of the rule.

resolution(clause, list of goals to be proven):
  clause = renameVars(clause) - rename all vars to fresh names
  s = MGU(head(claue), head(goals))
  return s(append(tail(clause), tail(goals)))

p(f(Y)) :- q(Y), r(Y).

p(b).

q(h(Z)) :- t(Z).

r(h(a)).

t(a).

resolution(p(f(Y)) :- q(Y), r(Y), [p(X)])
  MGU(p(f(Y)), p(X)) = {X-> f(Y)}
  return [q(Y), r(Y)]

resolution(q(h(Z)) :- t(Z), [q(Y), r(Y)])
  MGU(q(h(Z)), q(Y)) = {Y -> h(Z)}
  return [t(Z), r(h(Z)]

resolution(t(a), [t(Z), r(h(Z))]
  MGU(t(a), t(Z)) = {Z->a}
  return [r(h(a))]

resolution(r(h(a)), [r(h(a))]),
  MGU(r(h(a)), r(h(a))) = {}
  return []

========================================
*/


