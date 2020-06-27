evento(los15deSonia,asado,bsas,aireLibre,cumple).
evento(felipito,asado,moron,aireLibre,bautismo).
evento(cumpleDelMes,pizza,bsas,bajoTecho,cumple).
evento(chauChau,pizza,moron,aireLibre,despedida).
evento(festival,empanadas,quilmes,aireLibre,aniversario).

/*
fue2(juan,[los15deSonia, cumpleDelMes,festival]).
fue2(ana,[los15deSonia, cumpleDelMes, chauChau, felipito,festival]).
fue2(pedro,[felipito]).
fue2(marta,[los15deSonia,cumpleDelMes]).

fue(Persona,Evento):-
    fue2(Persona,Eventos),
    member(Evento,Eventos).
*/

fue(juan,los15deSonia).
fue(juan,cumpleDelMes).
fue(ana,los15deSonia).
fue(ana,chauChau).
fue(ana,cumpleDelMes).
fue(pedro,felipito).
fue(marta,cumpleDelMes).
fue(ana,festival).
fue(ana,felipito).
fue(juan,festival).
fue(marta,los15deSonia).

mascota(sultan).



persona(juan,bsas,300).
persona(pedro,quilmes,3000).
persona(luis,bsas,10).
persona(ana,quilmes,500).
persona(marta,moron,3000000000).


persona2(juan,bsas,300,fecha(25,enero,2020),casa(medrano,951)).
persona2(pedro,quilmes,3000,fecha(25,febrero,2020),dpto(rivadavia,4000,3,f)).
persona2(luis,bsas,10,fecha(25,enero,2020),dpto(rivadavia,4000,4,f)).
persona2(ana,quilmes,500,fecha(25,enero,2020),casa(urquiza,100)).
persona2(marta,moron,3000000000,fecha(23,enero,2020),rural(9,1124,sur)).


bueno(Alguien):-
    persona2(Alguien,_,_,_,rural(9,Km,_)),Km>1000.

bueno(Alguien):-
    persona2(Alguien,_,_,_,dpto(_,_,P,_)),P>3.


bueno2(Alguien):-
    persona2(Alguien,_,_,_,Direccion),lejos(Direccion).

lejos(rural(9,Km,_)):-Km>1000.
lejos(dpto(_,_,P,_)):-P>3.






%Evento al que fue alguien
eventoConPresencia(Evento):-
    evento(Evento,_,_,_,_),
    fue(_,Evento).

/*
eventoConPresencia2(Evento):-
    evento(Evento,_,_,_,_),
    fue2(_,Eventos),member(Evento,Eventos).
*/

%Evento al que va mas de una persona
eventoConcurrido(Evento):-
    evento(Evento,_,_,_,_),
    fue(Alguien,Evento),
    fue(Otro,Evento),
    Alguien\=Otro.

% no fue nadie
eventoNinguneado(Evento):-
    evento(Evento,_,_,_,_),
    not(fue(_,Evento)).


% no fue nadie 2, NO es inversible, responde diferente
eventoNinguneado2(Evento):-
%    evento(Evento,_,_,_,_),
    not(fue(_,Evento)).

%Persona con mucho dinero que no asiste a eventos al aire libre
personaAmarga(Alguien):-
    persona(Alguien,_,Dinero),
    Dinero > 100000,
    not(fueEventoAlAireLibre(Alguien)).

fueEventoAlAireLibre(Alguien):-
    fue(Alguien,Evento),
    evento(Evento,_,_,aireLibre,_).

eventoAsistenciaPerfecta(Evento):-
    evento(Evento,_,_,_,_),
    not(falto(_,Evento)).

falto(Alguien,Evento):-
    persona(Alguien,_,_),
    not(fue(Alguien,Evento)).


eventoAsistenciaPerfecta2(Evento):-
    evento(Evento,_,_,_,_),
    forall(persona(Alguien,_,_),fue(Alguien,Evento)).



eventoConSoloPersonas(Evento):-
    evento(Evento,_,_,_,_),
    forall(fue(Alguien,Evento),persona(Alguien,_,_)).


eventoLocal(Evento):-
    evento(Evento,_,Ciudad,_,_),
    forall(fue(Alguien,Evento),persona(Alguien,Ciudad,_)).

eventoOtraCiudad(Evento):-
    evento(Evento,_,Ciudad,_,_),
    forall(fue(Alguien,Evento),(persona(Alguien,OtraCiudad,_),OtraCiudad\=
    Ciudad)).


leGustaElAireLibreEnSuCiudad(Alguien):-
    persona(Alguien,Ciudad,_) ,
    forall(evento(Evento,_,Ciudad,aireLibre,_), fue(Alguien,Evento)).


popular(Alguien):-
    %fue2(Alguien,Eventos),
    persona(Alguien,_,_),
    findall(Evento,fue(Alguien,Evento),Eventos),  
    length(Eventos,Cantidad),
    Cantidad > 3.


/*
seEncuentran(Persona1,Persona2):-
    fue2(Persona1,Eventos1),
    fue2(Persona2,Eventos2),
    interseccion(Eventos1,Eventos2,EnComun),
    noVacia(EnComun).
*/

seEncuentran(Persona1,Persona2):-
    fue(Persona1,E),
    fue(Persona2,E).

