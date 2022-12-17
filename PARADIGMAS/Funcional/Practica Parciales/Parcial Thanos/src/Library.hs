module Library where
import PdePreludat


{-
Los enanos de Nidavellir nos han pedido modelar los guanteletes que ellos producen en su herrería.
Un guantelete está hecho de un material (“hierro”, “uru”, etc.) y sabemos las gemas que posee.
También se sabe de los personajes que tienen una edad, una energía, una serie de habilidades 
(como por ejemplo “usar espada”, “controlar la mente”, etc), su nombre y en qué planeta viven.
Los fabricantes determinaron que cuando un guantelete está completo -es decir,
tiene las 6 gemas posibles- y su material es “uru”, se tiene la posibilidad de chasquear
un universo que contiene a todos sus habitantes y reducir a la mitad la cantidad de dichos
personajes. Por ejemplo si tenemos un universo en el cual existen
ironMan, drStrange, groot y wolverine, solo quedan los dos primeros que son ironMan y drStrange.
Si además de los 4 personajes estuviera viudaNegra, quedarían también ironMan y drStrange porque
se considera la división entera.
-}

--Punto 1:Modelar Personaje, Guantelete y Universo como tipos de dato e implementar el chasquido de un universo.

type Material = String
type Edad = Number
type Energia = Number
type Habilidades = [String]
type Nombre = String
type Gema = Personaje -> Personaje 
type Deseo = Personaje -> Personaje 


data Personaje = Personaje {
  nombre:: Nombre,
  habilidades:: Habilidades,
  planeta:: String, 
  edad::Edad,
  energia::Energia
} deriving (Eq, Show)

data Guantelete = Guantelete {
    material :: String,
    gemas :: [Gema]
} deriving (Show)

type Universo = [Personaje]

{- Punto 1
Hacer chasquido 
-}

chasquear :: Guantelete -> Universo -> Universo
chasquear guantelete universo | puedeUsarse guantelete =  reducirMitad universo 
 | otherwise = universo 

reducirMitad :: Universo -> Universo
reducirMitad universo = take (length universo `div` 2) universo 

puedeUsarse:: Guantelete -> Bool
puedeUsarse guantelete = ((==6).length.gemas) guantelete && ((=="uru").material) guantelete

aptoParaPendex :: Universo -> Bool
aptoParaPendex  = any $ (<=45).edad

energiaTotal :: Universo -> Energia
energiaTotal = sum.map energia. filter ((>1).length.habilidades)

-- punto 3

laMente :: Number -> Gema 
laMente valor personaje = quitarEnergia valor personaje

quitarEnergia :: Number -> Gema
quitarEnergia valor personaje = personaje {
  energia = energia personaje - valor
}   

elAlma :: String -> Gema
elAlma  habilidad personaje = quitarEnergia 10 personaje {habilidades = filter (/= habilidad) (habilidades personaje)}

elEspacio:: String -> Gema
elEspacio nuevoPlaneta personaje = quitarEnergia 20 personaje {planeta = nuevoPlaneta}

elPoder :: Gema
elPoder personaje = quitarEnergia (energia personaje) personaje {habilidades = restarHabilidades (habilidades personaje) }

restarHabilidades :: Habilidades -> Habilidades
restarHabilidades habilidades   | length habilidades <=2 = []
                                | otherwise = habilidades

elTiempo :: Gema
elTiempo personaje = quitarEnergia 50 personaje {edad = (max 18.div (edad personaje)) 2 }

laGemaLoca :: Gema -> Gema
laGemaLoca gema  = gema.gema 

--Punto 5 

    --o se puede utilizar recursividad. Generar la función utilizar  que dado una lista de gemas y un enemigo ejecuta el
 --poder de cada una de las gemas que lo componen contra el personaje dado. Indicar cómo se produce el “efecto de lado” sobre la víctima.

utilizar :: [Gema] -> Personaje -> Personaje
utilizar listaDeGemas enemigo = foldr ($) enemigo listaDeGemas  


