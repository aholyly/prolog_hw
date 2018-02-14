
%------------------------------------------------------------------------------
% referans: https://books.google.com.tr/books?id=f-apCAAAQBAJ&pg=PA148&lpg=PA148&dq=prolog+union+intersection&source=bl&ots=-eyLH1KQGr&sig=pKVHmOcJA4cuKXI8Hdc-gVtChKY&hl=tr&sa=X&ved=0ahUKEwiIg_LrsY_YAhVE66QKHY03BuAQ6AEIaDAH#v=onepage&q=prolog%20union%20intersection&f=false
%------------------------------------------------------------------------------
union([],X,X).
union([X|R],Y,Z) :-	member(X,Y),
					!,
					union(R,Y,Z).
union([X|R],Y,[X|Z]) :-	union(R,Y,Z).


intersect([],X,[]).
intersect([X|R],Y,[X|Z]) :-	member(X,Y),
								!,
								intersect(R,Y,Z).
intersect([X|R],Y,Z) :-	intersect(R,Y,Z).


%------------------------------------------------------------------------------
% referans: https://courses.cs.washington.edu/courses/cse505/94au/logic/prolog.html
%------------------------------------------------------------------------------

flatten([],[]).
flatten([X|Xs],Y) :-	flatten(X,XF),
						flatten(Xs,XsF),
						append(XF,XsF,Y).
flatten(X,[X]).