// Multiplica todos los elementos del array e imprime el resultado
# define N 5
active proctype ARRAY ( ) {
    int a [ N ] ;
    int prod = 1 ;
    /* TODO
    * Inicializa el array con valores aleatorios
    * Multiplica todos los elementos del array y guarda el resultado en la variable prod
    * Imprime el resultado
    */
    int i = 0;
    do
    :: i < N -> a[i] = 1; i=i+1;
    :: i < N -> a[i] = 2; i=i+1;
    :: i < N -> a[i] = 3; i=i+1;
    :: i < N -> a[i] = 4; i=i+1;
    :: i < N -> a[i] = 5; i=i+1;
    :: else -> break;
    od
    i = 0;
    do
    :: i < N -> prod = prod * a[i]; i=i+1;
    :: else -> break;
    od
    printf ("El producto es : %d \n", prod)
}