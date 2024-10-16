/*
Considera una m´aquina expendedora de barritas de chocolate. Hay dos tipos de barritas, las que
contienen leche, y las que son de chocolate puro. Para comprar una barrita de chocolate con leche, los
usuarios deben introducir 75 c´entimos en la m´aquina. En caso de que se quiera una barrita de chocolate
puro el precio es de 1 euro.
Define dos procesos maquina y cliente con el comportamiento descrito por los sistemas de transiciones que siguen. Sup´on que la m´aquina tiene un n´umero ilimitado de barritas de cada tipo y que el
cliente no se cansa nunca de comer barritas. Utiliza canales de sincronizaci´on de mensajes para modelar
las dos l´ıneas de comunicaci´on entre la maquina y el cliente (chocolate y monedas).
*/

mtype = {euro1, cent75, chocolateConLeche, chocolatePuro};

chan monedas = [0] of {mtype};
chan chocolate = [0] of {mtype};

active proctype maquina(){
    do
    :: monedas ? euro1 ->
        chocolate ! chocolatePuro
    :: monedas ? cent75 ->
        chocolate ! chocolateConLeche
    od
}

active proctype cliente(){
    do
    :: true ->
        monedas ! euro1;
        chocolate ? chocolatePuro
    :: true ->
        monedas ! cent75;
        chocolate ? chocolateConLeche
    od
}