#define BAJA 0
#define SUBE 1
#define ABRE 0
#define CIERRA 1

chan ctrACabina = [0] of {bit}
chan ctrAPuerta[3] = [0] of {bit}

init{
    atomic{
        run Puerta(0);
        run Puerta(1);
        run Puerta(2);
        run Cabina();
        run Controlador();
    }
}

proctype Controlador(){
    libre0:
    ctrAPuerta[0]!CIERRA; goto ocupada0;
    ocupada0:
    if
    :: ctrAPuerta[0]!ABRE; goto libre0;
    :: ctrACabina!SUBE; goto ocupada1;
    :: ctrACabina!SUBE; goto ceroados;
    fi
    libre1:
    ctrAPuerta[1]!CIERRA; goto ocupada1;
    ocupada1:
    if
    :: ctrAPuerta[1]!ABRE; goto libre1;
    :: ctrACabina!SUBE; goto ocupada2;
    :: ctrACabina!BAJA; goto libre0;
    fi
    libre2:
    ctrAPuerta[2]!CIERRA; goto ocupada2;
    ocupada2:
    if
    :: ctrAPuerta[2]!ABRE; goto libre2;
    :: ctrACabina!BAJA; goto ocupada1;
    :: ctrACabina!BAJA; goto dosacero;
    fi
    ceroados:
    ctrACabina!SUBE; goto ocupada2;
    dosacero:
    ctrACabina!BAJA; goto ocupada0;
}

proctype Puerta(int num){
    CERRADA:
    if
    :: ctrAPuerta[num]?ABRE -> goto ABIERTA;
    :: ctrAPuerta[num]?CIERRA; goto CERRADA;
    fi
    ABIERTA:
    if
    :: ctrAPuerta[num]?ABRE; goto ABIERTA;
    :: ctrAPuerta[num]?CIERRA; goto CERRADA;
    fi
}

proctype Cabina(){
    PLANTA0:
    if
    :: ctrACabina?SUBE; goto PLANTA1;
    :: ctrACabina?BAJA; goto PLANTA0;
    fi
    PLANTA1:
    if
    :: ctrACabina?SUBE; goto PLANTA2;
    :: ctrACabina?BAJA; goto PLANTA0;
    fi
    PLANTA2:
    if
    :: ctrACabina?SUBE; goto PLANTA2;
    :: ctrACabina?BAJA; goto PLANTA1;
    fi
}

//COPIADOS DE LOS EJERCICIOS DE EJEMPLO
ltl p1{[] !((Puerta[3]@ABIERTA && Puerta[4]@ABIERTA) || (Puerta[4]@ABIERTA && Puerta[5]@ABIERTA) || (Puerta[3]@ABIERTA && Puerta[5]@ABIERTA))}
ltl p2{[] !(Puerta[3]@ABIERTA && !(Cabina[2]@PLANTA0))}
ltl p3{[] (Puerta[3]@ABIERTA -> Cabina[2]@PLANTA0)}

ltl p4_nofair {[]<> (Cabina@PLANTA0)}
ltl p4{([]<> Controlador[1]@ocupada0) -> ([]<> Cabina[2]@PLANTA0)}
