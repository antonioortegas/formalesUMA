#define CARA 1
#define CRUZ 0
#define REL 1
#define REQ 0

chan enter[2] = [0] of {bit};
chan release = [0] of {bit};

init{
    atomic{
        run arbitro();
        run p(0);
        run p(1);
    }
}

proctype p(int i){
    ncritico:
    //espero a que me dejen entrar
    enter[i]?REQ;
    //HAGO COSAS
    critico:
    printf("Proc %d in critical section\n", i);
    //aviso de que he salido
    release!REL;
    goto ncritico;
}

proctype arbitro(){
    unlock:
    // elijo car o cruz
    if
    :: true ->
        enter[0]!REQ;
    :: true ->
        enter[1]!REQ;
    fi
    // espero a que salga de la sección crítica
    lock:
    release?REL;
    goto unlock;
}

//LTL
// verificar que no se satisface viveza. ie, hay ejecuciones en los que uno de los dos procesos no entra nunca en SC
// Para eso, decimos que siempre hay un momento en el futuro en el que p[i] entra en SC
// no se cumplira, porque puede que uno de los dos procesos no entre nunca en SC, siempre entre el otro
ltl p1 {[]<> (p[3]@critico)}
// para arreglarlo, usamos justicia. es decir, podamos de las ejecuciones a comprobar aquellos casos en los que 
// uno de los dos procesos bloquea al otro infinitamente
// Por eso usamos "cuando el arbitro saca caras y cruces infinitamente, entonces en algún momento p[i] entra en SC"
// con esto, estamos haciendo que solo se verifiquen aquellas ejecuciones "justas" en las que ambos procesos entran en SC
ltl p2 {(([]<>arbitro@lock) && ([]<>arbitro@lock)) -> ([]<> (p[1]@critico))}