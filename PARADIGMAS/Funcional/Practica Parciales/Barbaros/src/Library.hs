module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Barbaro = Barbaro {
    nombre :: String,
    fuerza :: Number,
    habilidades :: [String],
    objetos :: [Objeto]
}
-- Punto 1 - Definir los siguientes objetos y algunos barbaros de ejemplo
-- 1.1) Definir Espada -> aumentan la fuerza de los bárbaros en 2 unidades por cada kilogramo de peso
type Objeto = Barbaro -> Barbaro

espada :: Number -> Objeto
espada peso barbaro = aumentarFuerza (div peso 2) barbaro

aumentarFuerza :: Number -> Barbaro -> Barbaro
aumentarFuerza cantidad barbaro = barbaro {fuerza = (fuerza barbaro) + cantidad}

-- 1.2) . Los amuletosMisticos puerco-marranos otorgan una habilidad dada a un bárbaro

amuletosMisticos :: String -> Objeto
amuletosMisticos habilidad barbaro = obtenerHabilidad habilidad barbaro

obtenerHabilidad :: String -> Barbaro -> Barbaro
obtenerHabilidad habilidad barbaro  | elem habilidad (habilidades barbaro) = barbaro
                                    | otherwise = barbaro {habilidades = habilidad : (habilidades barbaro)}

-- 1.3) Las varitasDefectuosas, añaden la habilidad de hacer magia, pero desaparecen todos los demás objetos del bárbaro.

varitasDefectuosas ::  Objeto
varitasDefectuosas barbaro = (perderObjetos . obtenerHabilidad "hacer magia")

perderObjetos :: Barbaro -> Barbaro
perderObjetos barbaro = barbaro {objetos = []}

-- 1.4) Una ardilla, que no hace nada.

ardilla :: Objeto
ardilla = id

-- 1.5) Una cuerda, que combina dos objetos distintos, obteniendo uno que realiza las transformaciones de los otros dos 


--cuerda :: Objeto -> Objeto -> Objeto
--cuerda objeto1 objeto2 = objeto1 . objeto2

-- Ejemplos de barbaros para el punto 1
dave = Barbaro "Dave" 100 ["tejer","escribirPoesia"] [ardilla]
barbaro1.1 = Barbaro "Juan" 50 ["programar","hablar"] [espada]