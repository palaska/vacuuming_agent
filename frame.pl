%define dynamic predicates
:- dynamic location/2.
:- dynamic lastDirection/1.
:- dynamic knowClean/1.
:- dynamic agentat/1.
:- dynamic counter/1.

%perform 20 reflexive actions
simulateMore :-
counter(0);

display('Current state -- A: '),
location(a,XX),
display(XX),
display(' | B: '),
location(b,YY),
display(YY),
display(' | C: '),
location(c,ZZ),
display(ZZ),
display(' | D: '),
location(d,QQ),
display(QQ),
display(' | Agent at: '),
agentat(RR),
display(RR),
display(' | Agent says: '),

simulateOne,
retract(counter(X)),
Y is X - 1,
assert(counter(Y)),
simulateMore.
