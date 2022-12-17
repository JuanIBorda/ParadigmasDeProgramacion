module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Mago = Mago {
    nombre::String,
    horrocruxes:: [Horrocrux]
} deriving (Show,Eq)

data Horrocrux = Horrocrux {
    denominacion::String,
    mago::Mago
} deriving (Show,Eq)

diadema = Horrocrux {
    denominacion = "Ravenclow",
    mago = srTenebroso
}  

diario = Horrocrux {
    denominacion = "Diario de Tom Riddle",
    mago = srTenebroso
} 

harry = Horrocrux {
    denominacion = "Harry Postre",
    mago = srTenebroso
}

otroMas = Horrocrux {
    denominacion = "Para Test",
    mago = srTenebroso
}

srTenebroso = Mago {
    nombre = "Voldemort",
    horrocruxes = [diario, diadema, harry]
}

{-destruir:: Horrocrux -> Mago
destruir horrocruxeEliminado  = sufrirConsecuencias (mago horrocruxeEliminado) horrocruxeEliminado

sufrirConsecuencias :: Mago -> Horrocrux -> Mago
sufrirConsecuencias mago horrocruxeEliminado = mago {horrocruxes = filter ((/= (denominacion horrocruxeEliminado)) . denominacion) (horrocruxes mago)}

finalFeliz:: [Horrocrux] -> Bool
finalFeliz  = not . sigueVivo srTenebroso 
-}
{-  ----- OPCION 1 ----- NO UTILIZO DESTRUIR
sigueVivo :: Mago -> [Horrocrux] -> Bool
sigueVivo mago ([]) = tieneAlgunHorrocrux (mago)
sigueVivo mago (x:xs)   | tieneAlgunHorrocrux (mago)  = sigueVivo (sufrirConsecuencias mago x) xs
                        | otherwise = False

tieneAlgunHorrocrux :: Mago -> Bool
tieneAlgunHorrocrux mago = horrocruxes mago /= []

caso1 = [diario, diadema]
caso2 = [diario, diadema, harry]
caso3 = [diario, diadema, harry, otroMas]
casoInfinito = [diario,harry,diadema] ++ (repeat harry)-}


--- OPCION 2 ----
{-
finalFeliz :: [Horrocrux] -> Bool
finalFeliz = not . sigueVivo srTenebroso

sigueVivo :: Mago -> [Horrocrux] -> Bool
sigueVivo mago horrocruxesEliminados = (tieneAlgunHorrocrux . foldl sufrirConsecuencias mago) horrocruxesEliminados

tieneAlgunHorrocrux :: Mago -> Bool
tieneAlgunHorrocrux mago = horrocruxes mago /= []

caso1 = [diario, diadema]
caso2 = [diario, diadema, harry]
caso3 = [diario, diadema, harry, otroMas]
-}