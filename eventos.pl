evento(los15deSonia,asado,bsas,aireLibre,cumple).
evento(felipito,asado,moron,aireLibre,bautismo).
evento(cumpleDelMes,pizza,bsas,bajoTecho,cumple).
evento(chauChau,pizza,quilmes,aireLibre,despedida).
evento(festival,empanadas,quilmes,aireLibre,aniversario).

fue(juan,los15deSonia).
fue(juan,cumpleDelMes).
fue(ana,los15deSonia).
fue(ana,chauChau).
fue(ana,cumpleDelMes).
fue(pedro,felipito).
fue(marta,cumpleDelMes).

persona(juan,bsas,300).
persona(pedro,quilmes,3000).
persona(luis,bsas,10).
persona(ana,quilmes,500).
persona(marta,moron,3000000000).

%Evento al que fue alguien
eventoConPresencia(Evento):-
    evento(Evento,_,_,_,_),
    fue(Alguien,Evento).

%Evento al que va mas de una persona
eventoConcurrido(Evento):-
    evento(Evento,_,_,_,_),
    fue(Alguien,Evento),
    fue(Otro,Evento),
    Alguien\=Otro.

% no fue nadie
eventoNinguneado(Evento):-
    evento(Evento,_,_,_,_),
    not(fue(Alguien,Evento)).


% no fue nadie 2, NO es inversible, responde diferente
eventoNinguneado2(Evento):-
%    evento(Evento,_,_,_,_),
    not(fue(Alguien,Evento)).

%Persona con mucho dinero que no asiste a eventos al aire libre
personaAmarga(Alguien):-
    persona(Alguien,_,Dinero),
    Dinero > 100000,
    not(fueEventoAlAireLibre(Alguien)).

fueEventoAlAireLibre(Alguien):-
    fue(Alguien,Evento),
    evento(Evento,_,_,aireLibre,_).


predicadoSinNombre(Evento):-
    evento(Evento,_,_,_,_),
    not(falto(Alguien,Evento)).

falto(Alguien,Evento):-
    persona(Alguien,_,_),
    not(fue(Alguien,Evento)).