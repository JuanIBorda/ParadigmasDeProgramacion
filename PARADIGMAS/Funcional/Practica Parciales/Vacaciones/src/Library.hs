module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Turista = Turista {
    cansancio :: Number,
    stress :: Number,
    acompanado :: Bool,
    idiomas :: [String]
} deriving (Show, Eq)

nacho = Turista 5  10 False ["Aleman"]

cambiarStress delta turista = turista {stress = stress turista + delta}

cambiarStressPorcentual porciento turista =
  cambiarStress (div (porciento * stress turista) 100) turista

cambiarCansancio delta turista = turista {cansancio = cansancio turista + delta}


-- 2
type Excursion = Turista -> Turista

playa :: Excursion
playa turista   | acompanado turista == False = cambiarCansancio (-5) turista
                | otherwise = turista {stress = stress turista - 1}

apreciarElementoDelPaisaje :: String -> Excursion
apreciarElementoDelPaisaje elemento turista = cambiarStress (-length elemento) turista

salirAHablar :: String -> Excursion
salirAHablar idioma turista = aprenderIdioma idioma turista

aprenderIdioma :: String -> Turista -> Turista
aprenderIdioma idioma turista   | elem idioma (idiomas turista) = turista
                                | otherwise = turista {idiomas = idioma : idiomas turista}

caminar :: Number -> Excursion
caminar minutos turista = (cambiarStress (-intensidad minutos) . cambiarCansancio (intensidad minutos)) turista
    
intensidad :: Number -> Number
intensidad minutos = (div) minutos 4

data Marea =  Tranquila | Moderada | Fuerte

paseoEnBarco :: Marea -> Excursion
paseoEnBarco Tranquila turista = (salirAHablar "aleman". apreciarElementoDelPaisaje "mar" . caminar 10) turista
paseoEnBarco Moderada turista = turista
paseoEnBarco Fuerte turista = (cambiarCansancio 10 . cambiarStress 6) turista
{-paseoEnBarco :: String -> Excursion
paseoEnBarco marea turista  | marea == "fuerte" = turista {cansancio = cansancio turista + 10, stress = stress turista + 6}
                            | marea == "moderada" = turista
                            | otherwise =  (salirAHablar "aleman". apreciarElementoDelPaisaje "mar" . caminar 10) turista
-}
-- Modelos
ana = Turista 0 21 True ["espaniol"]
beto  = Turista 15 15 False ["aleman"]
cathi = beto {idiomas= ["aleman","catalan"]}

-- Que un turista haga una excursion

hacerExcursion :: Turista -> Excursion -> Turista
hacerExcursion turista excursion =  (cambiarStressPorcentual (-10) . excursion) turista


-- 3) Dado delta, definir deltaExcursionSegun 

deltaSegun :: (a -> Number) -> a -> a -> Number
deltaSegun f algo1 algo2 = f algo1 - f algo2

deltaExcursionSegun :: (Turista -> Number) -> Turista -> Excursion -> Number
deltaExcursionSegun f turista excursion = deltaSegun f (hacerExcursion turista excursion) turista

educativa :: Excursion -> Turista -> Bool
educativa excursion turista = ((/=0) . deltaExcursionSegun (length . idiomas) turista) excursion

excursionesDesestresantes :: Turista -> [Excursion] -> [Excursion]
excursionesDesestresantes turista = filter (esDesestresante turista)

esDesestresante :: Turista -> Excursion -> Bool
esDesestresante turista = (<= -3) . deltaExcursionSegun stress turista