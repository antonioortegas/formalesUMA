sig SistemaFicheros {
    raiz: one Objeto, // one es por defecto, pero lo indico igualmente
    contenido: set Objeto, // puede estar vacío, pero si hay algo, es un conjunto
    padre: Objeto set -> one Objeto // las relaciones -> (ternarias) son por defecto set en ambos lados
}

sig Objeto {

}

fact {
    // la raiz no esta contenida en ningún objeto. es decir, no tiene padre
    all s: SistemaFicheros | no s.raiz.(s.padre)
}

pred show() {
    #raiz = 1    
}

run show for 5