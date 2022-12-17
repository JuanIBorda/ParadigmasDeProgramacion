module Library where
import PdePreludat

-- Parcial Functional Master Series

-- Nombre: Apellido, Nombre (reemplazar por el tuyo)
-- Legajo: 999999-9 (reemplazar por el tuyo)

type Palabra = String
type Verso = String
type Estrofa = [Verso]

esVocal :: Char -> Bool
esVocal = flip elem "aeiouáéíóú"

tieneTilde :: Char -> Bool
tieneTilde = flip elem "áéíóú"


-- Punto 1

riman :: Palabra -> Palabra -> Bool
riman palabra1 palabra2 =  (rimasAsonantes palabra1 palabra2 || rimasConsonantes palabra1 palabra2) && (not . palabasIguales palabra1) palabra2
-- verifica si 2 palabras riman, es decir si son rimasAsontantes o rimasConsonantes

rimasAsonantes :: Palabra -> Palabra -> Bool
rimasAsonantes palabra1 palabra2 = ultimasNVocales palabra1 2 == ultimasNVocales palabra2 2
-- comparo las ultimas 2 vocales

ultimasNVocales :: Palabra -> Number -> String
ultimasNVocales palabra n   | n == 0  || palabra == [] = []
                            | esVocal (last palabra) = ultimasNVocales (init palabra) (n - 1)  ++ [last palabra] 
                            | otherwise = ultimasNVocales (init palabra) n
-- Agarra una palabra y le saca n vocales si es posible
-- Lo hice con N para que sea reutilizable en el caso de que se deseen sacar mas vocales


rimasConsonantes :: Palabra -> Palabra -> Bool
rimasConsonantes palabra1 palabra2 = tomarUltimasNLetras palabra1 3 == tomarUltimasNLetras palabra2 3
-- verifica si las ultimas 3 letras de ambas palabras son iguales

tomarUltimasNLetras :: Palabra -> Number -> String
tomarUltimasNLetras palabra n = drop (length palabra - n) palabra
-- Compara las ultimas 3 letras de ambas palabras y si son iguales devuelve True
-- Lo hice con n para que se pueda reutilizar la funcion en caso de querer quitar otra cantidad de letras

palabasIguales :: Palabra -> Palabra -> Bool
palabasIguales palabra1 palabra2 = palabra1 == palabra2


-- Punto 2 

-- Hay 2 tipos de conjugaciones
-- Por medio de rimas: Me dan 2 versos (conju   nto de palabras)
-- Y tengo que ver si riman las ultimas 2 palabras
-- Haciendo anadiplosis: cuando la primer palabra del verso2 es la misma palabra que la ultiama del verso1
type Conjugacion = Verso -> Verso -> Bool

conjugaPorMedioDeRimas :: Conjugacion
conjugaPorMedioDeRimas verso1 verso2 = riman (ultimaPalabra verso1) (ultimaPalabra verso2)

ultimaPalabra :: Verso -> Palabra
ultimaPalabra = last . words

conjugaPorAnadiplosis :: Conjugacion
conjugaPorAnadiplosis verso1 verso2 = ultimaPalabra verso1 == primerPalabra verso2
-- cuando la primer palabra del verso2 es la misma palabra que la ultiama del verso1 devuelve True

primerPalabra :: Verso -> Palabra
primerPalabra = head . words

--Punto 3
type Patron = Estrofa -> Bool

patronSimple :: Number -> Number -> Patron
patronSimple  nro1 nro2 estrofa  =  conjugaPorMedioDeRimas (estrofa !! (nro1-1)) (estrofa !! (nro2-1)) 

patronEsdrujula :: Patron
patronEsdrujula estrofa = all (versoEsdrujula) estrofa

versoEsdrujula :: Verso -> Bool
versoEsdrujula verso = (tieneTilde . head . flip ultimasNVocales 3 . ultimaPalabra) verso 

patronAnafora :: Patron
patronAnafora verso = all (== ((primerPalabra . head) verso)) verso

patronCadena :: Conjugacion -> Patron
patronCadena _ (verso1:[]) = True   
patronCadena conjugacion (verso1:verso2:versos) | conjugacion verso1 verso2 = patronCadena conjugacion (verso2:versos) 
                                                | otherwise = False

patronCombinaDos ::  Patron -> Patron -> Patron
patronCombinaDos patron1 patron2 estrofa = patron1 estrofa && patron2 estrofa

--3 

aabb :: Patron
aabb estrofa = patronSimple 1 2 estrofa && patronSimple 3 4 estrofa

abab :: Patron
abab estrofa = patronSimple 1 3 estrofa && patronSimple 2 4 estrofa

abba :: Patron 
abba estrofa = patronSimple 1 4 estrofa && patronSimple 2 3 estrofa

hardcorde :: Patron
hardcorde  = patronCombinaDos (patronCadena conjugaPorMedioDeRimas) patronEsdrujula 

-- 3 c
-- No se puede saber si un patron es hardcorde con una estrofa infinita ya que no puedo saber si es un patronEsdrujula,
-- debido a que para ello debo analizar TODAS las ultimas palabras de cada verso y no puedo hacer eso. Tampoco podria hacer 
-- PatronCadena porque no acabaria nunca la recursividad.

-- ¿En aabb?En el caso de un patron aabb Si se podria saber con una estrofa infinita, ya que unicamente nos interesan las posiciones 1 2 3 y 4
-- El resto de posiciones no interesan y por lo tanto no importa si son infinitas o no.

--Punto 4 
type Artista = String

data PuestaEnEscena = PuestaEnEscena{
    publicoExaltado :: Bool,
    potencia :: Number,
    estrofa :: Estrofa,
    artista :: Artista
}

type Estilo = PuestaEnEscena -> PuestaEnEscena

gritar :: Estilo
gritar  = aumentarPotenciaPorcentual 50

aumentarPotenciaPorcentual n puesta = puesta {potencia = potencia puesta + (div (n * potencia puesta) 100)}

responderUnAcote :: Bool -> Estilo
responderUnAcote efectividad puesta =  (aumentarPotenciaPorcentual 20 puesta) {publicoExaltado = efectividad} 

tirarTecnicas :: Patron -> Estilo
tirarTecnicas patron puesta = (aumentarPotenciaPorcentual 10 puesta) {publicoExaltado = patron (estrofa puesta)}


freestyle :: Artista -> Estrofa -> Estilo -> PuestaEnEscena 
freestyle artista estrofa  estilo = estilo (puestaBase{estrofa = estrofa, artista = artista})
 
puestaBase = PuestaEnEscena{
    publicoExaltado = False,
    potencia = 1,
    estrofa = [""],
    artista = ""
}

--Punto 5
type Condicion = PuestaEnEscena -> Bool
type Jurados = [Criterio]
type Criterio = (Condicion,Number)

alToke :: Jurados
alToke =  [(aabb . estrofa ,0.5), (patronCombinaDos (patronSimple 1 4) patronEsdrujula . estrofa , 1) , (((==True) . publicoExaltado) , 1 ) ,((>1.5) . potencia ,2)]

puntaje :: PuestaEnEscena -> Jurados -> Number
puntaje puesta = puntajeFinal . valoraciones . cirteriosNumbereresantes puesta

puntajeFinal :: [Number] -> Number
puntajeFinal = max 3 . sum
 
valoraciones :: [Criterio] -> [Number]
valoraciones = map snd
    
cirteriosNumbereresantes :: PuestaEnEscena -> Jurados -> [Criterio]
cirteriosNumbereresantes puesta = filter (($ puesta) . fst)

--patronCombineaDos patronEsdrujula (patronSimple 1 4) . estrofa , 1) 
-- (((==True) . publicoExaltado) , 1 )
--((>1.5) . potencia ,2)