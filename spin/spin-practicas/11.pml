# define BAJA 0
# define SUBE 1
# define ABRE 0
# define CIERRA 1
# define CANCELA 1
chan ctrACabina = [0] of {bit }// el control se comunica con la cabina
chan ctrAPuerta [3] = [0] of {bit }// el control se comunica con cada puerta

init {atomic {
	run Puerta(0);
	run Puerta(1);
	run Puerta(2);
}}


active proctype Cabina(){
	int planta = 0;
	do
	:: ctrACabina?SUBE;
		if 
		:: planta != 2 -> 
			planta++;
			
		fi;
		
	:: ctrACabina?BAJA;
		if
		:: planta != 0 -> 
			planta--;
			
		fi;
		
	od
	
}

proctype Puerta(int id){
	bool abierta = false;
	do
	:: ctrAPuerta[id]?CIERRA;
		abierta = false;
	:: ctrAPuerta[id]?ABRE;
		abierta = true;
		
	od
	
}

active proctype Controlador(){
	int planta = 0;// Planta actual
	bool ocupado = false;// Decide si la cabina esta ocupada
//bool 0a2 = false;// Decide subir 2 plantas de golpe
//bool 2a0 = false;// Decide bajar 2 plantas de golpe
	
	do
	:: !ocupado -> // Estado inicial
		
		ctrAPuerta[planta]!CIERRA;// En cualquier estado de los libres solo puedo cerrar
		ocupado = true;
	:: ocupado 
		
		ctrAPuerta[planta]!ABRE;
		ocupado = false;
	:: ocupado && planta != 2
		planta++;
		ctrACabina!SUBE;
	:: ocupado && planta != 0
		ctrACabina!BAJA;
		planta--;
    :: ocupado && planta == 0
        planta++;
        ctrACabina!SUBE;
        planta++;
        ctrACabina!SUBE;
    :: ocupado && planta == 2
        planta--;
        ctrACabina!BAJA;
        planta--;
        ctrACabina!BAJA;

			
	od
	
}

ltl p1 {![] (Puerta[0]:abierta&&Puerta[1]:abierta ||Puerta[0]:abierta&&Puerta[2]:abierta ||Puerta[1]:abierta&&Puerta[2]:abierta)}
ltl p2 {[] (Puerta[0]:abierta -> (Cabina:planta==0))}
ltl p3 {[] ((Cabina:planta!=0) -> <>(Cabina:planta==0))}
ltl p4 {<>[](Cabina:planta!=0) -> []<>(Cabina:planta==0)}
//En clase proponen: ltl p3 {[]<>(Cabina:planta==0)}

//FAIRNESS
/*
specify the fairness in the non deterministic process (all states are reached), then the condition that must be met on the right
idgaf if that statement is actually right, but i guess its good enough for the test
not like this dumb shit has any real applications
[]<>(controlador@ocupado0) && []<>(controlador@ocupado1) && []<>(controlador@ocupado2) -> []<>(cabina@p0)
|------------------------------------------------------------------------------------|    |------------------|
                                WEAK FAIRNESS                                                 CONDITION
*/