%------------------------------------------------------------------------------
% knowledge base
%------------------------------------------------------------------------------
flight(ankara,konya,8).
flight(ankara,izmir,6).
flight(ankara,trabzon,2).
flight(ankara,istanbul,5).

flight(istanbul,izmir,3).
flight(istanbul,ankara,5).
flight(istanbul,trabzon,3).

flight(izmir,ankara,6).
flight(izmir,antalya,1).
flight(izmir,istanbul,3).

flight(konya,kars,5).
flight(konya,ankara,8).
flight(konya,diyarbakir,1).

flight(antalya,izmir,1).
flight(antalya,diyarbakir,5).

flight(diyarbakir,konya,1).
flight(diyarbakir,antalya,5).

flight(edremit,edirne,5).
flight(edremit,erzincan,7).

flight(kars,konya,5).
flight(kars,gaziantep,3).

flight(trabzon,ankara,2).
flight(trabzon,istanbul,3).

flight(edirne,edremit,5).

flight(erzincan,edremit,7).

flight(gaziantep,kars,3).
%------------------------------------------------------------------------------


%------------------------------------------------------------------------------
% PART 1
%------------------------------------------------------------------------------
%------------------------------------------------------------------------------
% Baslangic sehrinden, Cost1 degerinde yeni bir X sehri bulur. Bu sehri helper
% fonskiyon ile Visited listesi icinde tutar. Gidecegimiz sehrin listede olup 
% olmadigini kontrol eder ve yoksa listeye ekleyip recursive olan kendi
% fonskiyonunu cagirir
%------------------------------------------------------------------------------
route_helper(From,To,Cost,Visited) :-	flight(From,To,Cost), From \== To.
route_helper(From,To,Cost,Visited) :-	flight(From,X,Cost1),           
										X \== To,
										From \== To,
										\+member(X,Visited),
										route_helper(X,To,Cost2,[X|Visited]),
										Cost is Cost1+Cost2.

route(From,To,Cost) :-	route_helper(From,To,Cost,[From]).
%------------------------------------------------------------------------------


%------------------------------------------------------------------------------
% PART 2
%------------------------------------------------------------------------------
%------------------------------------------------------------------------------
% Minimum of a list
% referans: https://stackoverflow.com/questions/3965054/prolog-find-minimum-in-a-list
%------------------------------------------------------------------------------
list_min([L|Ls], Min) :-
	list_min(Ls, L, Min).

list_min([], Min, Min).
list_min([L|Ls], Min0, Min) :-
	Min1 is min(L, Min0),
	list_min(Ls, Min1, Min).
%------------------------------------------------------------------------------


%------------------------------------------------------------------------------
% Rotadaki en ucuz yolu belirler. Tum rota kombinasyonlarindaki Cost degerini,
% Costhist listesinde tutar. En son Cost degeri listedeki mininum deger ile degisir.
croute_helper(From,To,Cost,Visited,Costhist) :-	flight(From,To,Cost), From \== To.

croute_helper(From,To,Cost,Visited,Costhist) :-	flight(From,X,Cost1),           
												X \== To,
												From \== To,
												\+member(X,Visited),
												\+member(Cost1,Costhist),
												croute_helper(X,To,Cost2,[X|Visited],[Cost1|Costhist]),
												Cost is Cost1+Cost2,
												list_min(Costhist,Cost).
croute(From,To,Cost) :- croute_helper(From,To,Cost,[From],[Cost]).
%------------------------------------------------------------------------------



