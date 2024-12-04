sig Persona{
    pareja: one Persona,
    saludos: set Persona
}

one sig Alice in Persona{

}

one sig Bob in Persona{

}
//una persona no es su propia pareja
//ser pareja es reciproco
//no hay dos personas con la misma pareja
//nadie se saluda a si mismo
//nadie saluda a su pareja
//el saludo es reciproco
//alice es la pareja de bob
//cada persona saluda a un numero diferente de personas
fact{
    all p:Persona | p!=p.pareja
    all disj p1,p2:Persona | p1.pareja=p2 implies p2.pareja=p1
    all p1,p2:Persona | p1.pareja=p2 implies p2 not in p1.saludos
    all p:Persona | p not in p.saludos
    all disj p1,p2:Persona | p1 in p2.saludos implies p2 in p1.saludos
    all disj p1,p2:Persona | p1!=Alice and p2!=Alice implies #p1.saludos!=#p2.saludos
    Alice!=Bob
    Alice.pareja=Bob
    //CHANGE DEPENDING ON THE NUMBER OF COUPLES. UPPER VALUE IS NUMBER OF COUPLES *2
    all p:Persona | #p.saludos>=0 and #p.saludos<=8
}

pred show4couples(){
    #Persona=10
}

pred show3couples(){
    #Persona=8
}

pred show2couples(){
    #Persona=6
}

pred show1couples(){
    #Persona=4
}

//uncomment one to run the desired number of couples
run show4couples for 10 but 10 Int
run show3couples for 8 but 10 Int
run show2couples for 6 but 10 Int
run show1couples for 4 but 10 Int