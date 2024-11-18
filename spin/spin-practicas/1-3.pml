// Cambiando el if por un do, se ejecutará una de las opciones aleatoriamente de forma indefinida
active proctype NONDET ( ) {
    do
    :: true -> printf ("1\n")
    :: true ; printf ("2\n")
    :: true -> printf ("3\n")
    od
}