sig Llave{

}
sig Cliente{
    llave: lone Llave,
}

sig Hotel{
    hab: set Habitacion
}

sig Habitacion{
    llaves: set Llave,
    llaveActual: one Llave,
    ocupacion: lone Cliente
}

fact{
    // una hab solo esta en un hotel
    all h:Habitacion | one hot:Hotel | h in hot.hab

    //las habitaciones no comparten llaves (cada llave solo pertenece a una habitacion)
    all disj h1, h2: Habitacion | h1.llaves & h2.llaves = none

    //una habitacion tiene al menos una llave
    all h: Habitacion | #h.llaves > 0

    //la llave actual es una de ellas
    all h:Habitacion | h.llaveActual in h.llaves

    //cada cliente ocupa como mucho una habitacion
    all c:Cliente | lone h:Habitacion | c in h.ocupacion

    // si un cliente ocupa una habitacion, la llave actual de la habitacion es la llave del cliente
    all h:Habitacion | #h.ocupacion>0 implies h.llaveActual=h.ocupacion.llave
}

pred show(){
    #Habitacion = 3
    #Hotel = 2
    #Llave = 5
}

run show for 5