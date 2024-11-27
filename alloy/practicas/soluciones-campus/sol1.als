/*
Define una signatura Color, una signatura Objeto, y una relaci´on color que asocie a cada objeto un
color. Define la signatura Caja, y una relaci´on contiene que asocie cada caja con el conjunto de objetos
que contiene.
Expresa con sintaxis Alloy, de la forma m´as sencilla posible, la restricci´on“cada objeto est´a en una
y s´olo una caja”.
Muestra que el modelo permite que:
1. en alguna caja todos los objetos sean del mismo color
2. alguna caja tenga m´as de dos objetos, y todos los objetos que contienen son de distinto color
*/

module ejercicio1
//signaturas
sig Color {}
sig Objeto {
	color: one Color
}

sig Caja {
	contiene : set Objeto
}
//hechos
fact{
//cada objeto está en una sola caja
all o: Objeto | one contiene.o

}

//predicados

pred show(){}

run show for 5

//1) alguna caja con todos los objetos del mismo color
pred mismoColorCaja(){
	some c:Caja | one (c.contiene).color
}

run mismoColorCaja for 5

//2) alguna caja con más de dos objetos y todos de distinto color
pred distintoColorCaja(c: Caja){
  	#(c.contiene) > 2
	//tiene tantos objetos como colores diferentes
	#c.contiene = #(c.contiene.color)
	//otra opcion para la segunda restricción
	//all disj o1,o2: c.contiene| o1.color!= o2.color
}
run distintoColorCaja