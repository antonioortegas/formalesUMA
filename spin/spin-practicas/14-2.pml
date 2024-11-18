mtype = {REQ, req, IND, RSP, rsp, CNF, abo, ABO, aok};
chan an1 = [0] of {mtype}
chan n1n2 = [0] of {mtype}
chan n2b = [0] of {mtype}

chan bn2 = [0] of {mtype}
chan n2n1 = [0] of {mtype}
chan n1a = [0] of {mtype}

proctype A(){
    do
        :: true ->
        enviando_REQ:
        an1!REQ
        n1a?_ -> skip
    od
}

proctype B(){
    do
        :: true->
        n2b?IND
        enviando_RSP:
        bn2!RSP
    od
}

proctype N1(){
    do
        :: an1?REQ ->
        enviando_req:
        n1n2!req
        :: n2n1?rsp ->
        enviando_CNF:
        n1a!CNF
        :: n2n1?abo ->
        if
            :: true ->
            n1n2!req
            :: true ->
            enviando_ABO:
            n1a!ABO
            n1n2!aok
        fi
    od
}

proctype N2(){
    do
        :: n1n2?req ->
        if
            :: true ->
            n2b!IND
            :: true ->
            n2n1!abo
        fi
        :: n1n2?aok ->
        skip
        ::bn2?RSP ->
        n2n1!rsp
    od
}

init{
    atomic{
        run A()
        run N1()
        run N2()
        run B()
    }
}