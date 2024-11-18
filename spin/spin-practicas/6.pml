// Solucion de Peterson
// Usa una variable turno para indicar a que proceso tiene prioridad si ambos entran a la vez

bool c1 = false;
bool c2 = false;
int turno = 0;

active proctype p1(){
    do
    :: true ->
        c1 = true;
        turno = 1 - turno;
        esperando:
        (c2 == false && turno == 0);
        printf("SECCION CRITICA 1");
        c1 = false;
    od
}

active proctype p2(){
    do
    :: true ->
        c2 = true;
        turno = 1 - turno;
        esperando:
        (c1 == false && turno == 1);
        printf("SECCION CRITICA 2");
        c2 = false;
    od
}

// Checkear propiedades
// Exclusion mututa
ltl excl {
    [](p1@esperando || p2@esperando)
}

//Si solo un proceso quiere entrar en la seccion critica, entonces en algun momento entra
ltl singleEventual {
    ([](c1==false -> <>(c1==true))) && ([](c2==false -> <>(c2==true)))
}

// Si ambos procesos quieren entrar en la seccion critica, entonces eventualmente los dos salen
ltl bothEventual {
    [](c1==false && c2==false) -> (<>(c1==true) && <>(c2==true))
}