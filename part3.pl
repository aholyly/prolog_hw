%------------------------------------------------------------------------------
% knowledge base
%------------------------------------------------------------------------------
sessions(a,10,101).
sessions(b,12,104).
sessions(c,11,102).
sessions(d,16,103).
sessions(e,17,103).
sessions(f,15,104).
sessions(g,11,101).

enrollment(1,a).
enrollment(1,b).
enrollment(2,a).
enrollment(3,b).
enrollment(4,c).
enrollment(5,d).
enrollment(6,d).
enrollment(6,a).
enrollment(7,f).
enrollment(7,a).
enrollment(8,b).
enrollment(8,f).
enrollment(9,c).
enrollment(9,d).
enrollment(10,e).
enrollment(10,g).
enrollment(11,f).
enrollment(11,c).
%------------------------------------------------------------------------------

% "Time" of the "Session"
%------------------------------------------------
when(Session,Time) :-	sessions(Session,Time,_).

% "Place" of the "Session"
%------------------------------------------------
where(Session,Place) :-	sessions(Session,_,Place).

% Which "Session" is "Attendee" enrolled
%------------------------------------------------------------
enrolled(Attendee,Session) :-	enrollment(Attendee,Session).

% schedule
%------------------------------------------------------------------
schedule(Attendee,Place,Time) :-	enrolled(Attendee,Conference),
									when(Conference,Time),
									where(Conference,Place).

% Which "place" is used in what "time"
%------------------------------------------------------------------
usage(Place,Time) :-	when(Conference,Time),
						where(Conference,Place).

% "Conference1" and "Conference2" conflict at the same time
%----------------------------------------------------------------------
time_conflict(Conference1,Conference2) :-	when(Conference1,Time1),
											when(Conference2,Time2),
											Conference1 \= Conference2,
											(Time1 =:= Time2;
											Time1+1 =:= Time2;
											Time2+1 =:= Time1).

% "Conference1" and "Conference2" conflict in the same room
%----------------------------------------------------------------------
place_conflict(Conference1,Conference2) :-	where(Conference1,Place1),
											where(Conference2,Place2),
											Conference1 \= Conference2,
											Place1 == Place2.

% "Conference1" and "Conference2" conflict in the same room and at the same time
%-------------------------------------------------------------------------------
conflict(Conference1,Conference2) :-	time_conflict(Conference1,Conference2);
										place_conflict(Conference1,Conference2).

% "Attendee1" and "Attendee2" conflict in the same room and at the same time
%-------------------------------------------------------------------------------
meet(Attendee1,Attendee2) :-	enrolled(Attendee1,Conference1),
								enrolled(Attendee2,Conference2),
								time_conflict(Conference1,Conference2),
								place_conflict(Conference1,Conference2),
								Attendee1 \= Attendee2.