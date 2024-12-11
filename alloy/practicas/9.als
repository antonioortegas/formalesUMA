module filosofos

sig Tenedor{

}

sig Filosofo{
    izda: one Tenedor,
    dcha: one Tenedor,
}

fact{
    all t:Tenedor | one izda.t and one dcha.t
    all f:Filosofo | f.izda != f.dcha
}

pred show(){
    #Filosofo = 5
    #Tenedor = 5
}

run show for 5 but 6 Int