// Al cambiar el ultimo printf por un else, no llega a ejecutarse nunca
// Esto es porque el else se ejecuta si no se cumple ninguna de las condiciones anteriores, y ambas son verdaderas siempre
active proctype NONDET ( ) {
    if
    :: true -> printf ("1\n")
    :: true ; printf ("2\n")
    :: else -> printf ("3\n")
    fi
}