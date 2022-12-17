
-- Nombre: Borda, Juan Ignacio (reemplazar por el tuyo)
-- Legajo: 173239-0 (reemplazar por el tuyo)

-- Parcial Jueves 09 de Junio de 2022
-- Paradigmas de Programación UTN.BA Jueves Mañana

module Library where
import PdePreludat

parcial = "¿Aprobado?"

-- Punto 1: 
-- a)
type Sabores = [Sabor]
type Sabor = String
type Peso = Number
type Temperatura = Number

data Postre = Postre {
    sabor :: Sabores,
    peso :: Peso, -- En gramos
    temperatura :: Temperatura -- En °C
} deriving (Show,Eq)

bizcochoBorracho = Postre{
    sabor = ["fruta","crema"],
    peso = 100,
    temperatura = 25
}

-- b) 
type Hechizo = Postre -> Postre

incendio :: Hechizo
incendio = (perdidaPorcentualDePeso 5 . calentar 1)

immobulus :: Hechizo
immobulus = congelar

wingardiumLeviosa :: Hechizo
wingardiumLeviosa  = perdidaPorcentualDePeso 10 . agregarSabor "concentrado"

diffindo :: Number -> Hechizo
diffindo porcentaje postre = postre {peso = valorDePorcentajeEnPeso porcentaje postre}

riddikulus :: String -> Hechizo
riddikulus saborNuevo = agregarSabor (reverse saborNuevo)

avadaKedavra :: Hechizo
avadaKedavra = perderSabores . immobulus

-- Funciones delegadas

calentar :: Number -> Postre -> Postre
calentar cantidad postre = postre {temperatura = temperatura postre + cantidad}

congelar :: Postre -> Postre
congelar postre = postre {temperatura = 0}

perdidaPorcentualDePeso :: Number -> Postre -> Postre
perdidaPorcentualDePeso porcentaje postre = postre {peso = peso postre - valorDePorcentajeEnPeso porcentaje postre}

valorDePorcentajeEnPeso :: Number -> Postre -> Number
valorDePorcentajeEnPeso porcentaje postre = (div (porcentaje * peso postre) 100)

agregarSabor :: String -> Postre -> Postre 
agregarSabor saborNuevo postre  | elem saborNuevo (sabor postre) = postre
                                | otherwise = postre {sabor = saborNuevo : sabor postre} -- Se puede hacer sin las guardas, pero por si se les cae el postre 2 veces para que no se agregue 2 veces el mismo sabor.

perderSabores :: Postre -> Postre
perderSabores postre = postre {sabor = []}

-- c)
type Mesa = [Postre]

mesaLista :: Mesa -> Hechizo -> Bool
mesaLista mesa  hechizo = (all postreListo . hechizarMesa hechizo) mesa

-- Funciones delegadas 

postreListo :: Postre -> Bool
postreListo postre = tienePeso postre && tieneSabores postre && (not . estaCongelado) postre

tienePeso :: Postre -> Bool
tienePeso = (>0) . peso

tieneSabores :: Postre -> Bool
tieneSabores = (/= 0) . cantidadDeSabores

estaCongelado :: Postre -> Bool
estaCongelado = (==0) . temperatura

hechizarMesa :: Hechizo -> Mesa -> Mesa
hechizarMesa hechizo postre = map hechizo postre

-- Modelos de ejemplo para testear

tartaDeMelaza = Postre{
    sabor = ["melaza"],
    peso = 50,
    temperatura = 0
}

tortaQuemada = Postre{
    sabor = [],
    peso = 80,
    temperatura = 0
}

mesa1 = [bizcochoBorracho,tartaDeMelaza]
mesa2 = mesa1 ++ [tortaQuemada]

-- d)

pesoPromedioDePostresListos :: Mesa -> Hechizo -> Number
pesoPromedioDePostresListos mesa hechizo = (pesoPromedio . filter (postreListo) . hechizarMesa hechizo ) mesa

pesoPromedio :: Mesa -> Number
pesoPromedio mesa   | length mesa == 0 = 0 --Si ningun postre esta listo la mesa queda vacia y su promedio es 0.
                    | otherwise = (flip div (length mesa) . sum . map peso) mesa

-- Punto 2
-- a) 
data Mago = Mago{
    hechizosAprendidos :: [Hechizo],
    cantidadDeHorrorcruxes :: Number
} deriving Show

asistirAClaseDeDefensa :: Mago -> Hechizo -> Postre -> Mago
asistirAClaseDeDefensa mago hechizo postre   | hechizo postre == avadaKedavra postre =  (agregarHorrorcruxes 1 . aprenderHechizo hechizo) mago
                                             | otherwise = aprenderHechizo hechizo mago

-- Funciones Delegadas

aprenderHechizo :: Hechizo -> Mago -> Mago
aprenderHechizo hechizo mago = mago {hechizosAprendidos = hechizo : hechizosAprendidos mago}

agregarHorrorcruxes :: Number -> Mago -> Mago
agregarHorrorcruxes cantidad mago = mago {cantidadDeHorrorcruxes = cantidad + cantidadDeHorrorcruxes mago}

-- b) 
obtenerMejorHechizo :: Postre -> Mago -> Hechizo
obtenerMejorHechizo postre mago = foldl1 (mejorHechizo postre) (hechizosAprendidos mago)

mejorHechizo :: Postre -> Hechizo -> Hechizo -> Hechizo
mejorHechizo postre hechizo1 hechizo2   | mejorPostre (hechizo1 postre) (hechizo2 postre) == hechizo1 postre = hechizo1
                                        | otherwise = hechizo2

mejorPostre :: Postre -> Postre ->  Postre
mejorPostre postre1 postre2 | cantidadDeSabores postre1 > cantidadDeSabores postre2 = postre1
                            | otherwise = postre2

cantidadDeSabores :: Postre -> Number
cantidadDeSabores = length . sabor 

-- Punto 3
-- a) 
infinitosPostres = repeat bizcochoBorracho
magoConInfinitosHechizos = iterate (aprenderHechizo incendio) harryPotter

harryPotter = Mago{
    hechizosAprendidos = [],
    cantidadDeHorrorcruxes = 0
}

-- b) Suponiendo que hay una mesa con infinitos postres, y pregunto si algún hechizo los deja listos ¿Existe alguna consulta que pueda hacer para que me sepa dar una respuesta? Justificar conceptualmente.
{-
 Para que un hechizo deje listos a todos los postres, entonces la mesa debe quedar LISTA, y esto ocurre SOLO si todos los postres estan listos.
 Entonces en el caso de que todos los postres esten listos, nunca acabara  de corroborrar, ya que para que la mesa este lista TODOS tienen que 
 estar listos. Por otro lado en el caso de que alguno de los postres NO este listo, entonces devuelve False y deja de verificar (es un ALL con que
 solo 1 de False ya no necesita corroborrar los demas).
 Por ejemplo en infinitosPostres, con el hechizo incendio nunca acabo de iterar porque siempre devolvera true, mientras que signu
 pruebo con el hechizo immobulus devuelve False en la primer iteracion porque no necesita corroborrar el resto.
-}


-- c) Suponiendo que un mago tiene infinitos hechizos. ¿Existe algún caso en el que se puede encontrar al mejor hechizo? Justificar conceptualmente.
{-
 En el caso de que todos los hechizos sean distintos no puedo encontrar nunca el mejor hechizo, ya que para ello 
 deberia comparar el resultado de cada hechizo con el siguiente, lo cual resulta imposible ya que nunca acaba esta lista y siempre habra un
 siguiente para corroborrar.
-}

