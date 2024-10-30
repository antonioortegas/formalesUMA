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