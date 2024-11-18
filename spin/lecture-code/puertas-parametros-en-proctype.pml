#define BAJA 0
#define SUBE 1
#define ABRE 0
#define CIERRA 1
chan ctrACabina = [0] of {bit}
chan ctrAPuerta[3] = [0] of {bit}

proctype Puerta(short planta){
    close:
    if
    :: ctrAPuerta[planta] ? CIERRA ; goto close;
    :: ctrAPuerta[planta] ? ABRE ; goto open;
    fi
    open:
    if
    :: ctrAPuerta[planta] ? ABRE ; goto open;
    :: ctrAPuerta[planta] ? CIERRA ; goto close;
    fi
}

active proctype Cabina(){
    short planta = 0;
    do
    :: ctrACabina ? SUBE ->
        if
        :: planta == 2 -> skip
        :: else -> planta++
        fi
    :: ctrACabina ? BAJA ->
        if
        :: planta == 0 -> skip
        :: else -> planta--
        fi
    od
}

init{
    atomic{
        run Puerta(0);
        run Puerta(1);
        run Puerta(2);
    }
}