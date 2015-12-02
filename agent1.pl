%clear previous state and agent data
:- retractall(agentat(_)).
:- retractall(location(_,_)).
:- retractall(counter(_)).

:- assert(counter(20)).
:- consult('initialstate.pl').

%ACTION_SUCK
action(suck) :-
agentat(AgentsLocation),
retract(location(AgentsLocation,_)),
assert(location(AgentsLocation,clean)).

%ACTION_LEFT
action(left) :-
retract(agentat(b)), assert(agentat(a));
retract(agentat(c)), assert(agentat(b)) ;
retract(agentat(d)), assert(agentat(c));
agentat(a).

%ACTION_RIGHT
action(right) :-
retract(agentat(a)), assert(agentat(b));
retract(agentat(b)), assert(agentat(c));
retract(agentat(c)), assert(agentat(d));
agentat(d).

%action_selection
simulateOne :-
%location_sensor
agentat(AgentsLocation),
%cleanliness_sensor
(location(AgentsLocation,dirty), action(suck),
  display('I cleaned my location\n');
  location(AgentsLocation,clean),

  %go_left/right
  random(RandNum),
  (
    RandNum>=0.5,
    action(left), display('I am going left\n')
    ;
    RandNum<0.5,
    action(right), display('I am going right\n')
  )
).

:- simulateMore.
