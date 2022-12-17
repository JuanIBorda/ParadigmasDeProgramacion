module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Participante = Participante {
    nombre :: String,
    experiencia :: Number,
    inteligencia :: Number,
    destrezaFisica :: Number,
    rol :: String
 } deriving Show

data Arma = Arma{
    valorDeCombate :: Number,
    experienciaMinimia :: Number,
    potencia :: Number
} deriving Show

aptitud :: Participante -> Rol -> Number
aptitud participante rol = rol participante

type Rol = Participante -> Number 

indeterminado :: Rol
indeterminado participante = (+(destrezaFisica participante) . inteligencia) participante

soporte :: Rol
soporte participante = (+ (experiencia participante) . (*7) . inteligencia) participante

primeraLinea :: Arma -> Rol
primeraLinea arma participante = 


