mtype = {REQ, req, IND, RSP, rsp, CNF, abo, ABO, aok};
chan an1 = [0] of {mtype}
chan n1n2 = [0] of {mtype}
chan n2b = [0] of {mtype}

chan bn2 = [0] of {mtype}
chan n2n1 = [0] of {mtype}
chan n1a = [0] of {mtype}

proctype A(){
    do
        :: true->
        an1!REQ
        enviadoREQ:
        n1a?CNF ->
        skip
    od
}

proctype B(){
    do
        :: n2b?IND ->
        bn2!RSP
        enviadoRSP:
    od
}

proctype N1(){
    do
        :: an1?REQ ->
        n1n2!req
        enviadoreq:
        :: n2n1?rsp ->
        n1a!CNF
        enviadoCNF:
    od
}

proctype N2(){
    do
        :: n1n2?req ->
        n2b!IND
        enviadoIND:
        :: bn2?RSP ->
        n2n1!rsp
        enviadorsp:
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