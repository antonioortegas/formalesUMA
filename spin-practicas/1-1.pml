// Promela no es determinista con los ifs
// Si varios ifs son verdaderos, se ejecutará uno aleatoriamente, dependiendo de la semilla
// La salida de este programa puede ser 1, 2 o 3
// La semilla se genera aleatoriamente, pero se puede especificar con el argumento de spin -n<semilla>
active proctype NONDET ( ) {
    if
    :: true -> printf ("1\n")
    :: true ; printf ("2\n")
    :: printf ("3\n")
    fi
}