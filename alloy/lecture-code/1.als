sig Planta{
    residentes: set Hombre
}
sig Atico extends Planta{}
sig Bajo extends Planta{}

sig Hombre{
    techo: Planta,
    suelo: Planta,
    casa: Planta -> Planta,
    vecinos: set Hombre
}

sig Inquilino extends Hombre{}
sig Propietario extends Hombre{}
sig VecinoConMascota in Hombre{}

//Restricciones que deben satisfacer todas las instancias del modelo
fact{
//1) El techo y el suelo de un hombre tienen que ser plantas diferentes
all h:Hombre | h.suelo != h.techo

//2) La casa de un hombre es su suelo y su techo
all h: Hombre | (h.suelo->h.techo) = h.casa

//3) Los residentes de una planta son todos los hombres que tienen el suelo en esa planta
/* Esta opción produce instancias en las que hombres que viven en una planta no están 
en la relación residentes. Solo asegura que los que están en p.residentes tengan como suelo p */ 
//all p: Planta| p.residentes.suelo= p 
/*Vemos este problema si analizamos el aserto residentesOk */
/*Esta era mi versión si es correcta */
all p: Planta | p.residentes = suelo.p

/*La versión de otra compañera
//all p: Planta | all h: Hombre | (h.suelo = p) iff (h in p.residentes)

//4) Los vecinos de cada hombre residen en la misma planta
// Todas las personas que viven en la misma plata son vecinas
/* Esta solución produce instancias en las que un hombre que vive en suelo.h1 
no están en la relación vecinosde h1. Se puede obtener el contraejemplo con el aserto vecinosOk*/
//all h1,h2 : Hombre | h2 in h1.vecinos => h1.suelo = h2.suelo
/* Una opción que asegura que todos los hombres que viven en la misma planta son vecinos 
aunque en la descripción de la restricción no indica que tengan que ser todos */
all h: Hombre | h.vecinos = (h.suelo).residentes -h
//5) vecinos es una relación simétrica
all disj h1,h2:Hombre|   h2 in h1.vecinos iff h1 in h2.vecinos
//6) un hombre no es vecino de si mismo
all h:Hombre | h not in h.vecinos
}


assert vecinosOk {
all p: Planta | all disj h1,h2: suelo.p | h1 in h2.vecinos && h2 in h1.vecinos
}
check vecinosOk for 4


assert residentesOk{
	all h:Hombre | h in (h.suelo).residentes
	all p: Planta, h:p.residentes | h.suelo = p

}

check residentesOk for 4

pred show(){
  #vecinos > 2
}

run show for 4
