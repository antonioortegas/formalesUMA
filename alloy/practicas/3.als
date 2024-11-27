/*
El objetivo de este ejercicio es modelar una serie de edificios con plantas, y ascensores, junto con un
conjunto de personas que puede estar en alguno de los edificios. Para ello:
Define las signaturas Planta, Ascensor, Edificio y Persona, y las relaciones:
1. ascPlanta y ascPersonas que relacionan cada ascensor con la planta en la que se encuentra, y
con el conjunto de personas que est´an en el mismo, respectivamente.
2. edifPlantas y edifAscensores que relacionan cada edificio con sus plantas (al menos debe haber
una planta en cada edificio), y el conjunto de ascensores que tiene, respectivemente.
3. edificio y ascensor que relacionan, respectivamente, cada persona con el edificio y el ascensor
en el que se encuentra. Una persona podr´ıa no estar en ning´un edificio ni en ning´un ascensor.
Expresa con sintaxis Alloy, de la forma m´as sencilla posible, las facts sobre el modelo dise˜nado:
1. Cada planta est´a exactamente en un edificio
2. Cada ascensor est´a exactamente en un edificio
3. El n´umero de ascensores de un edificio es estrictamente menor que el n´umero de plantas del
edificio
4. Si un edificio tiene menos de 3 plantas entonces no tiene ascensores
5. Si un edificio tiene m´as de 3 plantas entonces tiene alg´un ascensor
6. Cada ascensor se encuentra en una planta del edificio al que pertence
7. Si una persona est´a en un ascensor, entonces debe encontrarse tambi´en en el edificio en el que
est´a dicho ascensor
8. La relaci´on ascPersonas contiene exactamente a las personas que est´an en el ascensor
A˜nade restricciones que muestren que:
1. Es posible que una persona est´e en un edificio, pero no est´e en ning´un ascensor
2. Es posible que un ascensor lleve a dos personas
3. Es posible que todos los ascensores de un edificio est´en en la misma planta
4. Es posible que todos los ascensores de un edificio est´en en plantas diferentes
*/
sig Planta{}
sig Ascensor{
    ascPlanta: one Planta,
    ascPersonas: set Persona,
}
sig Edificio{
    edifPlantas: some Planta,
    edifAscensores: set Ascensor,
}
sig Persona{
    edificio: one Edificio,
    ascensor: lone Ascensor,
}

fact{
    //1. Cada planta está exactamente en un edificio
    all planta: Planta | one edifPlantas.planta

    //2. Cada ascensor está exactamente en un edificio
    all ascensor: Ascensor | one edifAscensores.ascensor

    //3. El número de ascensores de un edificio es estrictamente menor que el número de plantas del edificio
    all edificio: Edificio | #edificio.edifAscensores < #edificio.edifPlantas

    //4. Si un edificio tiene menos de 3 plantas entonces no tiene ascensores
    all edificio: Edificio | #edificio.edifPlantas<3 implies #edificio.edifAscensores=0

    //5. Si un edificio tiene más de 3 plantas entonces tiene algún ascensor
    all edificio: Edificio | #edificio.edifPlantas>3 implies #edificio.edifAscensores>0

    //6. Cada ascensor se encuentra en una planta del edificio al que pertenece
    all edificio: Edificio | edificio.edifAscensores.ascPlanta in edificio.edifPlantas

    //7. Si una persona está en un ascensor, entonces debe encontrarse también en el edificio en el que está dicho ascensor
    all persona: Persona | persona.ascensor in persona.edificio.edifAscensores

    //8. La relación ascPersonas contiene exactamente a las personas que están en el ascensor
    all asc: Ascensor | asc.ascPersonas = {persona: Persona | persona.ascensor=asc}
}

pred show(){
    #Persona=3 && #Ascensor=3 && #Edificio=2
}

run show for 5
