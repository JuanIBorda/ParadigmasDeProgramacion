module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Barbaro = Barbaro {
    nombre :: String,
    fuerza :: Number,
    habilidades :: [String],
    objetos :: [Objeto]
} deriving Show
-- Punto 1 - Definir los siguientes objetos y algunos barbaros de ejemplo
-- 1.1) Definir Espada -> aumentan la fuerza de los bárbaros en 2 unidades por cada kilogramo de peso
type Objeto = Barbaro -> Barbaro

espada :: Number -> Objeto
espada peso barbaro = aumentarFuerza (div peso 2) barbaro

aumentarFuerza :: Number -> Barbaro -> Barbaro
aumentarFuerza cantidad barbaro = barbaro {fuerza = (fuerza barbaro) + cantidad}

-- 1.2) . Los amuletosMisticos puerco-marranos otorgan una habilidad dada a un bárbaro

puerco = amuletosMisticos
marranos = amuletosMisticos

amuletosMisticos :: String -> Objeto
amuletosMisticos habilidad barbaro = obtenerHabilidad habilidad barbaro

obtenerHabilidad :: String -> Barbaro -> Barbaro
obtenerHabilidad habilidad barbaro  | elem habilidad (habilidades barbaro) = barbaro
                                    | otherwise = barbaro {habilidades = habilidad : (habilidades barbaro)}

-- 1.3) Las varitasDefectuosas, añaden la habilidad de hacer magia, pero desaparecen todos los demás objetos del bárbaro.


varitasDefectuosas ::  Objeto
varitasDefectuosas  = (perderObjetos . (obtenerHabilidad "hacer magia"))

perderObjetos :: Barbaro -> Barbaro
perderObjetos barbaro = barbaro {objetos = []}

-- 1.4) Una ardilla, que no hace nada.

ardilla :: Objeto
ardilla = id

-- 1.5) Una cuerda, que combina dos objetos distintos, obteniendo uno que realiza las transformaciones de los otros dos 


cuerda :: Objeto -> Objeto -> Objeto
cuerda objeto1 objeto2 = objeto1 . objeto2

-- Punto 2

megafono :: Objeto
megafono  = potenciarBarbaro

potenciarBarbaro :: Barbaro -> Barbaro
potenciarBarbaro barbaro = barbaro {habilidades = [map potenciar (concatenarHabilidades barbaro)]}

concatenarHabilidades :: Barbaro -> String
concatenarHabilidades barbaro = concat (habilidades barbaro)

potenciar :: Char -> Char
potenciar letra =  mayuscula letra
                
esMinuscula :: Char -> Bool
esMinuscula letra = elem letra minusculas

minusculas = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
vocales = ['a','e','i','o','u']
mayuscula 'a' = 'A'
mayuscula 'b' = 'B'
mayuscula 'c' = 'C'
mayuscula 'd' = 'D'
mayuscula 'e' = 'E'
mayuscula 'f' = 'F'
mayuscula 'g' = 'G'
mayuscula 'h' = 'H'
mayuscula 'i' = 'I'
mayuscula 'j' = 'J'
mayuscula 'k' = 'K'
mayuscula 'l' = 'L'
mayuscula 'm' = 'M'
mayuscula 'n' = 'N'
mayuscula 'o' = 'O'
mayuscula 'p' = 'P'
mayuscula 'q' = 'Q'
mayuscula 'r' = 'R'
mayuscula 's' = 'S'
mayuscula 't' = 'T'
mayuscula 'u' = 'U'
mayuscula 'v' = 'V'
mayuscula 'w' = 'W'
mayuscula 'x' = 'X'
mayuscula 'y' = 'Y'
mayuscula 'z' = 'Z'
mayuscula a = a

megafonoBarbarico :: Objeto
megafonoBarbarico = cuerda ardilla megafono -- Es lo mismo que megafono porque ardilla no hace nada, solo estaria haciendo megafono


-- Punto 3
type Evento = Barbaro -> Bool
type Aventura = [Evento]
-- 3.1
invasionDeSuciosDuendes ::Evento
invasionDeSuciosDuendes  = (elem ("Escribir Poesía Atroz") . habilidades)

-- 3.2
cremalleraDelTiempo ::Evento
cremalleraDelTiempo = tienePulgares 

tienePulgares :: Barbaro -> Bool
tienePulgares barbaro = not ((nombre barbaro) ==  "Faffy" || (nombre barbaro) == "Astro")

-- 3.3
ritualDeFechorias :: Evento
ritualDeFechorias = pasaAlgunaPrueba

pasaAlgunaPrueba :: Barbaro -> Bool
pasaAlgunaPrueba barbaro = any ($barbaro) pruebas

pruebas = [saqueo, gritoDeGuerra, caligrafia]

saqueo :: Barbaro -> Bool
saqueo barbaro =  ((>80).fuerza) barbaro && tieneHabilidad "robar" barbaro 

tieneHabilidad :: String -> Barbaro -> Bool
tieneHabilidad habilidad  = (elem habilidad . habilidades)

gritoDeGuerra :: Barbaro -> Bool
gritoDeGuerra barbaro = poderDeGrito barbaro * 4 == cantidadDeObjetos barbaro

poderDeGrito :: Barbaro -> Number
poderDeGrito = length . concatenarHabilidades 

cantidadDeObjetos :: Barbaro -> Number
cantidadDeObjetos = length . objetos 

caligrafia :: Barbaro -> Bool
caligrafia = caligrafiaPerfecta

caligrafiaPerfecta :: Barbaro -> Bool
caligrafiaPerfecta barbaro = ((>3) . length . concat . map (filtrarVocales)) (habilidades barbaro) && all (esMinuscula . head) (habilidades barbaro)

filtrarVocales :: String -> String
filtrarVocales palabra = filter (flip elem vocales) palabra

sobrevivientes :: [Barbaro] -> Aventura -> [Barbaro]
sobrevivientes barbaros aventura = filter (any (aventura)) barbaros

-- Ejemplos de barbaros para el punto 1

dave = Barbaro "Dave" 100 ["tejer","escribirPoesia"] [ardilla]
barbaro1 = Barbaro "Juan" 50 ["programar","hablar"] [espada 10]
barbaro2 = Barbaro "Ignacio" 200 ["correr"] [marranos "saltar"]
barbaro3 = Barbaro "Tomas" 10 ["comer"] [varitasDefectuosas]
barbaro4 = Barbaro "Pablo" 150 ["comer"] [cuerda ardilla (espada 10)]
barbaro5 = Barbaro "Bruno" 20 ["nada"] [ardilla, espada 10, puerco "volar", varitasDefectuosas, cuerda (espada 20) (espada 0)]
barbaro6 = Barbaro "Tomas" 10 ["Escribir Poesía Atroz"] [varitasDefectuosas]
barbaro7 = Barbaro "Faffy" 10 ["Escribir Poesía Atroz"] [varitasDefectuosas]

aventura1 = [invasionDeSuciosDuendes,ritualDeFechorias]