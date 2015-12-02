%clear previous state and agent data
:- retractall(agentat(_)).
:- retractall(location(_,_)).
:- retractall(counter(_)).
:- retractall(knowClean(_)).
:- retractall(lastDirection(_)).

:- assert(counter(20)).
:- consult('initialstate.pl').

%starts with left direction
lastDirection(left).

%ACTION_SUCK
action(suck) :-
agentat(AgentsLocation),
retract(location(AgentsLocation,_)),
assert(location(AgentsLocation,clean)).

%ACTION_LEFT
action(left) :-
retract(agentat(b)),
assert(agentat(a)),
retract(lastDirection(_)),
assert(lastDirection(left));

retract(agentat(c)),
assert(agentat(b)),
retract(lastDirection(_)),
assert(lastDirection(left));

retract(agentat(d)),
assert(agentat(c)),
retract(lastDirection(_)),
assert(lastDirection(left));

retract(lastDirection(_)),
assert(lastDirection(left)),
agentat(a).

%ACTION_RIGHT
action(right) :-
retract(agentat(a)),
assert(agentat(b)),
retract(lastDirection(_)),
assert(lastDirection(right));

retract(agentat(b)),
assert(agentat(c)),
retract(lastDirection(_)),
assert(lastDirection(right));

retract(agentat(c)),
assert(agentat(d)),
retract(lastDirection(_)),
assert(lastDirection(right));

retract(lastDirection(_)),
assert(lastDirection(right)),
agentat(d).

%ACTION_DONOTHING
action(donothing) :-
display('Doing nothing\n').

%action_selection
simulateOne :-

(knowClean(a),knowClean(b),knowClean(c),knowClean(d)),
action(donothing);

  %location_sensor
  agentat(AgentsLocation),
  %cleanliness_sensor
  (
    location(AgentsLocation,dirty),
    action(suck),
    display('I cleaned my location\n'),
    assert(knowClean(AgentsLocation));

    (knowClean(AgentsLocation)-> true;
    assert(knowClean(AgentsLocation))),

    %go_left/right
    (knowClean(a),knowClean(b),knowClean(c),knowClean(d)),
    action(donothing);
    (((agentat(b);agentat(c);agentat(d)),lastDirection(left));(lastDirection(right),agentat(d))),
    action(left), display('I am going left\n')
    ;
    (((agentat(a);agentat(b);agentat(c)),lastDirection(right));(lastDirection(left),agentat(a))),
    action(right), display('I am going right\n')
    ;
    action(donothing)
  ).

:- simulateMore.
