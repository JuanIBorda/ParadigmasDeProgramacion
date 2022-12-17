module Library where
import PdePreludat

-- tipos en Persona
type Nombre = String
type Edad = Number
type Estres = Number
type Preferencia = Persona -> Destino -> Bool
type Amigues = [Persona]

data Persona = Persona {
    nombrePersona :: Nombre,
    edadPersona :: Edad,
    estresPersona :: Estres,
    preferenciasPersona :: [Preferencia],
    amiguesPersona :: Amigues
} deriving Show

instance Eq Persona where
   unaPersona == otraPersona = (nombrePersona unaPersona == nombrePersona otraPersona)

personaGenerica = Persona { nombrePersona = "Random", edadPersona = 100, estresPersona = 50, preferenciasPersona = [], amiguesPersona = []}
contingenteGenerico = [juan, personaGenerica]

-- Punto 1

type Puntos = Number

puntosScoring :: Persona -> Puntos
puntosScoring persona
  | amigosPares persona = edadPersona persona * estresPersona persona
  | mayorACuarenta persona = cantidadAmigues persona * edadPersona persona
  | otherwise = dobleDelNombre persona

-- Funciones para delegar
mayorACuarenta :: Persona -> Bool
mayorACuarenta = (>40) . edadPersona

longitudNombre :: Persona -> Number
longitudNombre = length . nombrePersona

cantidadAmigues :: Persona -> Number
cantidadAmigues = length . amiguesPersona

amigosPares :: Persona -> Bool
amigosPares = even . cantidadAmigues

dobleDelNombre :: Persona -> Number
dobleDelNombre = (*2). longitudNombre


-- Punto 2

-- Parte a

-- Función pedida
tieneNombreFirme :: Persona -> Bool
tieneNombreFirme = (=='P') . primeraLetraNombre

-- Para delegar
primeraLetraNombre :: Persona -> Char
primeraLetraNombre = head . nombrePersona


-- Parte b
personaInteresante :: Persona -> Bool
personaInteresante = (>=2) . cantidadAmigues


-- Punto 3

type LlevaPlata = Bool
type Mes = Number

-- Funciones Destino.

type Destino = Persona -> Persona

puertoMadryn :: Destino
puertoMadryn persona =  persona {estresPersona = 0, amiguesPersona = juan : (amiguesPersona persona)}

marDelPlata ::  Mes -> Destino
marDelPlata mes persona 
  | mes <= 2 =  modificarEstres persona (estresPersona persona + 10)
  | otherwise  = estresMDQNoVerano persona

lasToninas :: LlevaPlata -> Destino
lasToninas llevaPlata persona
  | llevaPlata = modificarEstres persona (mitadEstres persona)
  | otherwise = estresMDQNoVerano persona

laAdela :: Destino
laAdela = id

-- Para delegar

estresMDQNoVerano :: Persona -> Persona
estresMDQNoVerano persona = modificarEstres persona (estresPersona persona - min 20 (edadPersona persona))

mitadEstres :: Persona -> Number
mitadEstres = (`div` 2) . estresPersona

modificarEstres :: Persona -> Estres -> Persona
modificarEstres persona estres = persona {estresPersona = max (min 100 estres) 0}

-- Juan el amigue

juan = Persona{ nombrePersona = "Juan", edadPersona = 37, estresPersona = 80, preferenciasPersona = [], amiguesPersona = [] }


-- Punto 4

--type Preferencia = Persona -> Destino -> Bool

desenchufarse :: Preferencia
desenchufarse persona destino = estresPersona (destino persona) < estresPersona persona

enchufarseEspecial :: Estres -> Preferencia
enchufarseEspecial estresDeseado persona destino =  (estresPersona.destino) persona == estresDeseado

socializar :: Preferencia
socializar persona destino = cantidadAmigues (destino persona) > cantidadAmigues persona

sinPretensiones :: Preferencia
sinPretensiones persona destino = True

-- Punto 5

-- Parte a
cumpleAlgunaPreferencia :: Destino -> Persona -> Bool
cumpleAlgunaPreferencia destino persona = any (cumplePreferencia destino persona) (preferenciasPersona persona)
cumplePreferencia :: Destino -> Persona -> Preferencia -> Bool
cumplePreferencia destino persona preferencia = preferencia persona destino

-- cumpleAlgunaPreferencia destino persona = any ($ destino) (map ($persona) (preferenciasPersona persona))
-- Anterior definición de la función


type Contingente = [Persona]
destinoApto :: Destino -> Contingente -> Bool
destinoApto destino contingente = all (cumpleAlgunaPreferencia destino) contingente


-- Parte b

destinoPiola :: Contingente -> Destino -> Bool
destinoPiola contingente destino = ((< 100).sumaEstresDePersonas.(aplicarDestinos contingente)) destino

aplicarDestinos :: Contingente -> Destino -> Contingente
aplicarDestinos contingente destino = map destino contingente

sumaEstresDePersonas :: Contingente -> Number
sumaEstresDePersonas = sum . (map estresPersona)


-- Punto 6

-- Parte a
type Paquete = [Destino]

paqueteStress :: Paquete -> Persona -> Estres
paqueteStress paquete persona = (estresPersona . aplicarPaquete paquete) persona

aplicarPaquete :: Paquete -> Persona -> Persona
aplicarPaquete paquete persona = foldl (\pers destino -> destino pers) persona paquete


-- Parte b

algunoLaPasaBien :: Contingente -> Bool
algunoLaPasaBien contingente = any (tieneAmigosEn contingente) contingente

tieneAmigosEn :: Contingente -> Persona -> Bool
tieneAmigosEn contingente persona = any (perteneceAl contingente) (amiguesPersona persona) -- o bien, any (`elem` contingente) (amiguesPersona persona) pero quedaba más complicado de entender
-- Tengo que saber si algun amigo de la persona está en el contingente

perteneceAl :: Contingente -> Persona -> Bool
perteneceAl contingente persona = elem persona contingente


-- Punto 7

contingenteTOC :: Contingente -> Bool
contingenteTOC = (all scoringPar) . filtrarPar

scoringPar :: Persona -> Bool
scoringPar  = even . puntosScoring

filtrarPar :: [a] -> [a]
filtrarPar [] = []
filtrarPar [x] = []
filtrarPar (x1:x2:xs) = x2 : filtrarPar xs


-- Punto 8: Contingente infinito

contingenteInfinito :: Contingente
contingenteInfinito = cycle contingenteGenerico
-- Posible solución? Es un contingente infinito de personas pero las personas se repiten!!


{-

¿es posible determinar si alguna persona de ese contingente infinito la pasa bien? Justifique su respuesta y muestre un ejemplo de consulta.

No es posible saber en todos los casos (al analizar un contingente Infinito) si una persona la pasa bien.
Imaginemos que ninguna persona la pasa bien en el contingente infinito (pero nuestro programa no sabe esto), entonces tendríamos que recorrer la lista infinitamente hasta encontrar alguien que sí la pase bien
No terminaría nunca!

Si no tuviesemos información sobre como fue hecho el contingenteInfinito no podriamos saber si alguno la pasa bien.
Pero si sabemos que las personas se repiten cada n personas entonces podíamos desarrollar:
algunoLaPasaBien (take n contingenteInfinito)


¿es posible saber si un destino es piola para ese contingente infinito? Justifique su respuesta y muestre un ejemplo de consulta.

Esto no es posible en todos los casos, hay 2 casos particulares en los que sí se puede afirmar si es destino piola o no.
Recordemos que un destino es piola cuando la suma del estrés de todas las personas es menor a 100.
Como sabemos que hay infinitas personas, si a todas les aumentó el estrés por lo menos algún punto entonces no será destinoPiola, porque la suma de estrés tenderá a infinito.
Si todas las personas tienen estrés 0, entonces no importa la cantidad de estas, siempre será un destinoPiola.

En base a los destinos planteados:
    Si el contingente infinito fue a mdq en enero/febrero, destinoPiola será False independientemente del estrés inicial de las personas del contingente.
    Si el contingente infinito fue a Puerto Madryn, destinoPiola será True independientemente del estrés inicial de las personas, ya que terminarán todas con 0 stress.

Con el resto de destinos no se puede saber exactamente si destinoPiola será True o no por las razones ya mencionadas anteriormente.
Ya que para estar seguros de si el destino es piola o no el estrés de las personas debe aumentar (al menos por un punto) o bien debe ser reducido a 0 como ya vimos en mdq y puerto madryn.

-}


-- PERSONAS Y CONTINGENTES PARA TESTING --

-- Punto 1

personaAmiguesPar = Persona {nombrePersona = "Ignacio",edadPersona = 25,estresPersona = 10,preferenciasPersona = [],amiguesPersona = [personaGenerica,personaGenerica,personaGenerica,personaGenerica]}

personaMasDe40 = Persona { nombrePersona = "Jere",edadPersona = 41 ,estresPersona = 43 ,preferenciasPersona = [],amiguesPersona =  [personaGenerica]}

rigoberta = Persona { nombrePersona = "Rigoberta", edadPersona = 31,estresPersona = 20,preferenciasPersona = [],amiguesPersona = [personaGenerica]}

-- Punto 2

paulina = Persona{nombrePersona = "Paulina",edadPersona = 31,estresPersona = 3,preferenciasPersona = [],amiguesPersona = [personaGenerica,personaGenerica,personaGenerica]}

-- Punto 3

punto3Persona1 = personaGenerica {estresPersona = 20}
punto3Persona2 = personaGenerica {estresPersona = 50, edadPersona = 18}
punto3Persona3 = personaGenerica {estresPersona = 15, edadPersona = 18}
punto3Persona4 = personaGenerica {estresPersona = 50, edadPersona = 45} 
punto3Persona5 = personaGenerica {estresPersona = 75}
punto3Persona6 = personaGenerica {estresPersona = 75}
punto3Persona7 = personaGenerica {estresPersona = 40}
punto3Persona8 = personaGenerica {estresPersona = 80}

-- Punto 4

punto4Persona1 = personaGenerica {preferenciasPersona = [desenchufarse]}
punto4Persona2 = personaGenerica {preferenciasPersona = [desenchufarse]}
punto4Persona3 = personaGenerica {estresPersona = 40, preferenciasPersona = [enchufarseEspecial 20], edadPersona = 50}
punto4Persona4 = personaGenerica {estresPersona = 45, preferenciasPersona = [enchufarseEspecial 20]}
punto4Persona5 = personaGenerica {preferenciasPersona = [socializar]}
punto4Persona6 = personaGenerica {preferenciasPersona = [socializar]}
punto4Persona7 = personaGenerica {preferenciasPersona = [sinPretensiones]}

-- Punto 5

ariel = Persona {nombrePersona = "Ariel",edadPersona = 21,estresPersona = 45,preferenciasPersona = [desenchufarse, socializar],amiguesPersona = []}

carola = Persona {nombrePersona = "Carola",edadPersona = 21,estresPersona = 45,preferenciasPersona = [socializar],amiguesPersona = []}

pedro = Persona {nombrePersona = "Pedro",edadPersona = 38,estresPersona = 50,preferenciasPersona = [sinPretensiones, enchufarseEspecial 10],amiguesPersona = []}

punto5Contingente1 = [ariel,pedro]
punto5Contingente2 = [carola,pedro]

-- punto 6

-- Parte a

gustavo = Persona {nombrePersona = "Gustavo",edadPersona = 25,estresPersona = 90,preferenciasPersona = [],amiguesPersona = []}

paquete1 = [marDelPlata 3, laAdela, lasToninas False]
paquete2 = []

-- Parte b

personaAmigueJuan = Persona {nombrePersona = "Gervasio",edadPersona = 007,estresPersona = 50,preferenciasPersona = [],amiguesPersona = [juan]}

punto6Contingente1 = [personaAmigueJuan, personaAmigueJuan, juan]

punto6Contingente2 = [personaAmigueJuan,personaAmigueJuan]

-- Punto 7

fabiana = Persona {nombrePersona = "Fabiana",edadPersona = 41,estresPersona = 50,preferenciasPersona = [],amiguesPersona = [juan]}

veronica = Persona {nombrePersona = "Veronica",edadPersona = 11,estresPersona = 51,preferenciasPersona = [],amiguesPersona = [juan]}

punto7Contingente1 = [pedro]

punto7Contingente2 = [ariel]

punto7Contingente3 = [fabiana, veronica, rigoberta, juan]

punto7Contingente4 = [juan, fabiana, rigoberta]