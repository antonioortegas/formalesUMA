chan papelMesa = [0] of {bit};
// usado por papel cuando quiere coger cerillas y tabaco de la mesa
chan tabacoMesa = [0] of {bit};
// lo mismo para tabaco
chan cerillasMesa = [0] of {bit};
// lo mismo para cerillas
chan agenteMesa = [0] of {short};
// usado por agente para poner dos nuevos ingredientes en la mesa

init{
    atomic{
        run Mesa();
        run Agente();
        run Papel();
        run Tabaco();
        run Cerillas();
    }
}

proctype Mesa(){
    int fumador;
    esperando:
    agenteMesa?fumador;
    // compruebo quien tiene que fumar, le envio que fume
    tengoIngredientes:
    if
    :: fumador == 1 -> papelMesa!1;
    :: fumador == 2 -> tabacoMesa!1;
    :: fumador == 3 -> cerillasMesa!1;
    fi
    // espero a que fume
    fumadorTerminado:
    if
    :: fumador == 1 -> papelMesa?0;
    :: fumador == 2 -> tabacoMesa?0;
    :: fumador == 3 -> cerillasMesa?0;
    fi
    // reinicio el fumador, aviso al agente y vuelvo a empezar
    fumador = 0;
    agenteMesa!0;
    goto esperando;
}

proctype Agente(){
    libre:
    // poner dos ingredientes en la mesa
    // si por ejemplo el agente pone papel y tabaco, el de las cerillas fuma
    if
    :: true -> agenteMesa!1; agpapel: skip;
    :: true -> agenteMesa!2; agtab: skip;
    :: true -> agenteMesa!3; agcer: skip;
    fi
    // una vez he puesto en la mesa los ingredientes, espero a que se fume y repito
    agenteMesa?0;
    goto libre;
}

proctype Papel(){
    inicio:
    // esperar a que haya cerillas y tabaco en la mesa
    papelMesa?1;
    //cuando termino, aviso y vuelvo a empezar
    fumando:
    papelMesa!0;
    goto inicio;
}

proctype Tabaco(){
    inicio:
    // esperar a que haya cerillas y papel en la mesa
    tabacoMesa?1;
    //cuando termino, aviso y vuelvo a empezar
    fumando:
    tabacoMesa!0;
    goto inicio;
}

proctype Cerillas(){
    inicio:
    // esperar a que haya papel y tabaco en la mesa
    cerillasMesa?1;
    //cuando termino, aviso y vuelvo a empezar
    fumando:
    cerillasMesa!0;
    goto inicio;
}

//COPIADO DE LOS 
// Siempre en el futuro hay un estado en el que la mesa tiene dos 
// ingredientes (cualquier par de ellos).
ltl p1 {[]<>(Mesa:fumador == 1 || Mesa:fumador == 2 || Mesa:fumador == 3)}
ltl p1_laura {[]<> Mesa@tengoIngredientes}
// Siempre en el futuro hay un estado en el que la mesa está vacía.
// y un fumador está fumando.
ltl p2 {[]<>(Mesa@fumadorTerminado && (Tabaco@fumando ||Cerillas@fumando || Papel@fumando))}

// Comprueba, asimismo, que la propiedad Siempre en el futuro hay un estado en el que la mesa tiene
// papel y tabaco no se satisface. Utiliza el simulador y el contraejemplo para entender en que caso la
// propiedad no se cumple. A˜n´adele alguna condici´on de justicia que haga que sea cierta.
ltl p3 {[]<>(Mesa@tengoIngredientes && Mesa:fumador == 3)}


// Condicion de incondicional fuerte
ltl p4 {([]<> Agente@agcer && []<> Agente@agpapel && []<> Agente@agtab) -> []<>(Mesa@tengoIngredientes && Mesa:fumador == 3)}