mtype = {moneda100, moneda75, chocoLeche, chocoPuro} //Ahora con limite de barritas

chan chocolate = [0] of {mtype}
chan monedas = [0] of {mtype}


active proctype maquina(){
int numBarritasLeche = 10;
int numBarritasPuro = 5;
int dinero = 0;
    control: do
        
        ::monedas?moneda75 -> // Si recibe moneda de 75, entrega chocolate de leche 
            if
            ::(numBarritasLeche > 0) -> chocolate!chocoLeche; numBarritasLeche = numBarritasLeche - 1; dinero = dinero + 75;
            ::else -> monedas!moneda75;
            fi;

        ::monedas?moneda100 ->// Si recibe moneda de 100, entrega chocolate puro
            if
            ::(numBarritasPuro > 0) -> chocolate!chocoPuro; numBarritasPuro = numBarritasPuro - 1; dinero = dinero + 100;
            ::else -> monedas!moneda100;
            fi;
    od
}

active proctype cliente(){
    do
        ::true -> monedas!moneda75;//Si meto moneda de 75, recibo chocolate de leche
            if
            ::chocolate?chocoLeche; //Si meto moneda de 75, recibo chocolate de leche
            ::monedas?moneda75; //Si meto moneda de 75, recibo chocolate de leche
            fi;

        ::true -> monedas!moneda100; //Si meto moneda de 100, recibo chocolate puro
            if
            ::chocolate?chocoPuro; //Si meto moneda de 100, recibo chocolate puro
            ::monedas?moneda100; //Si meto moneda de 100, recibo chocolate puro
            fi;
    od
}

ltl monedas {
    []maquina@control->(((10-maquina:numBarritasLeche)*75) + ((5-maquina:numBarritasPuro)*100)) == maquina:dinero
}