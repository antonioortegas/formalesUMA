//Pruebas de asertos
//Usando el verifier
//Si hay un error, se generara un archivo 'trail' que puede ser servir de traza de ejecucion para reproducirlo
active proctype P ( ) {
    int x = 0 ;
    x ++;
    int y = x ;
    assert ( y == 3) ;
}