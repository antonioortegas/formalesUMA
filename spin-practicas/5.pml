// Verificación de la sección crítica con dos procesos
// Como las condiciones en promela son bloqueantes, c1==true equivale a esperar a que c1 sea verdadero

bool c1 = true;
bool c2 = true;

active proctype p1(){
    do
    :: true -> c1 = false;
    c2 == true;
    printf("SECCION CRITICA 1");
    c1 = true;
    od
}

active proctype p2(){
    do
    :: true -> c2 = false;
    c1 == true;
    printf("SECCION CRITICA 2");
    c2 = true;
    od
}