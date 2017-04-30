time(0..maxstep).

% Define
pos(R,X,0) :- pos(R,X).

% Generate
edge(X,@getLinkage(X)) :- node(X).

%each time step, robot choose to move 1 step or stay at the current position.
{move(R,X,Y,T) : robot(R), edge(X,Y)}1 :- pos(R,X,T),time(T).

% if the robot does not move, the robot position should not change.
move(R,T) :- move(R,_,_,T).
pos(R,X,T+1) :- pos(R,X,T), not move(R,T), time(T).

% robot move one step, the robot position changes accordingly.
pos(R,Y,T+1) :- move(R,X,Y,T),pos(R,X,T), time(T).

%robot can not stop at one position longer than one step time if the position is not the target position.
:- pos(R,X,T1), pos(R,X,T2),T1!=T2, not target(R,X).

%avoid robots collision
:- move(R1,_,X,T), move(R2,_,X,T), R1!=R2.
:- move(R1,_,X,T), pos(R2,X,T+1),R1!=R2.

%robot can not move if there is no way to go
:- move(R,X,Y,T),  @link_exists(X,Y)==0.

%robot can not swap position.
:- move(R1,X,Y,T),move(R2,Y,X,T),R1!=R2.

%robot can not move to the direction which blocked by obstacle.
:- move(R,_,X,T), @barrier_exists(X,T+1)==1.

%avoid cllision with obstacle
:- move(R,X,Y,T), @barrier_exists(Y,T)==1,@barrier_exists(X,T+1)==1.

%robot can not move to position where is already visited to avoid cycle.
:- move(R,_,X,T1),move(R,_,X,T2), T1 != T2.

% stop moving once arrived
:- move(R,X,_,T), pos(R,X,T), target(R,X).

% test
arrive :- pos(R,X,T),target(R,X).
:- not arrive.

%compute the total time cost
arrive(R,T) :- pos(R,X,T),target(R,X).
robotArrive(R,C) :- C = #min{T: arrive(R,T),robot(R)}, robot(R).
totalTime(C) :- C = #sum {T,R: robotArrive(R,T),robot(R),time(T)}.

%compute the elucidean distance betweem two position. Compute the total path length.
dis(R,T,P1,P2,DT):- pos(R,P1,T), pos(R,P2,T+1), P1!=P2,loc(P1,X1,Y1),loc(P2,X2,Y2), DT=(X1-X2)*(X1-X2) + (Y1-Y2)*(Y1-Y2).
totalPathDis(D) :-  D = #sum { DT,R,T: dis(R,T,P1,P2,DT),robot(R),time(T)}. 

% optimized the plan by choose the minimum distance and shortest time-consuming path.
#minimize{ T@1: totalTime(T)}.
#minimize{ D@2: totalPathDis(D)}.

% Display
#show move/4.
%#show pos/3.
#show robotArrive/2.
#show totalPathDis/1.
