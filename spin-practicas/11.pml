#define BAJA 0
#define SUBE 1
#define ABRE 0
#define CIERRA 1
chan ctrACabina = [0] of {bit}
chan ctrAPuerta [3] = [0] of {bit}

active proctype Cabina() {
    int planta = 0;
    do
    :: ctrACabina?SUBE ->
        if
        :: planta == 2 -> skip;
        :: else -> planta = planta + 1;
        fi;
    :: ctrACabina?BAJA ->
        if
        :: planta == 0 -> skip;
        :: else -> planta = planta - 1;
        fi;
    od;
}

active proctype Puerta(int id) {
    bool abierta = false;
    do
    :: ctrAPuerta[id]?ABRE ->
        if
        :: abierta -> skip;
        :: else -> abierta = true;
        fi;
    :: ctrAPuerta[id]?CIERRA ->
        if
        :: abierta -> abierta = false;
        :: else -> skip;
        fi;
    od;
}

active proctype Controlador() {
    int libre = 0;
    int ocupada = 0;
    bool 0a2 = false;
    bool 2a0 = false;

    do
    :: libre == 0 ->
        
    od;
}