// Igual, pero con goto
active proctype NONDET ( ) {
    loop: // tag
    if
    :: true -> printf ("1\n")
    :: true ; printf ("2\n")
    :: true -> printf ("3\n")
    fi
    goto loop
}