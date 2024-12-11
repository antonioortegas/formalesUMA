module ej1

sig Color {}
sig Objeto { color : one Color}
sig Caja { contiene : set Objeto}

fact {
    all obj:Objeto | one caj:Caja | obj in caj.contiene
}

pred show(){
  #Color =3
  #Caja = 2
  #Objeto = 3
}

run show

