sig Maquina{
    estados: some Estado,
}

sig Estado{
    sucesores: set Estado,
}

lone sig MaquinaDeterminista in Maquina{
}

lone sig MaquinaNoDeterminista in Maquina{
}

lone sig MaquinaInalcanzable in Maquina{
}

lone sig MaquinaAlcanzable in Maquina{
}

lone sig MaquinaConectada in Maquina{
}

lone sig MaquinaBloqueada in Maquina{
}

fact{
    //los estados estan asociados a una maquina
    all e: Estado | one m: Maquina | e in m.estados
    //md: cada estado a lo sumo un sucesor
    all md: MaquinaDeterminista | all e: md.estados | e in md.estados implies #e.sucesores<=1
    //mnd: al menos un estado tiene varios sucesores
    all mnd: MaquinaNoDeterminista | some e: mnd.estados | e in mnd.estados and #e.sucesores>1
    //mi: hay al menos un estado inalcanzable
    some mi: MaquinaInalcanzable | some e1: mi.estados | e1 in mi.estados and e1 not in mi.estados.sucesores
}

pred show(){
    #Maquina=1
    #MaquinaDeterminista=0
    #MaquinaNoDeterminista=0
    #MaquinaInalcanzable=1
    #MaquinaAlcanzable=0
    #MaquinaConectada=0
    #MaquinaBloqueada=0
}

run show for 5