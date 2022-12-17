module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

--data taxi -> el nombre , el kilometraje de su auto , los viajes que tomó , qué condición impone para tomar un viaje

-- Cada viaje se hace en una fecha particular, lo toma un cliente (queremos saber su nombre y dónde vive) y tiene un costo.

{-En cuanto a la condición para tomar un viaje
algunos choferes toman cualquier viaje
otros solo toman los viajes que salgan más de $ 200
otros toman aquellos en los que el nombre del cliente tenga más de n letras
y por último algunos requieren que el cliente no viva en una zona determinada-}

-- Punto 1: Modelar Taxi, Cliente y Viajes

data Taxi = Taxi{
    conductor :: String,
    kilometraje :: Number,
    viajes :: [Viaje],
    condicion :: CondicionViaje
} deriving (Show)

data Cliente = Cliente{
    nombre :: String,
    direccion :: String -- Zona
} deriving (Show)

data Viaje = Viaje {
    fecha :: (Number, Number, Number),
    cliente :: Cliente,
    costo :: Number
} deriving (Show)


-- Punto 2: Modelar las condiciones

type CondicionViaje = Viaje -> Bool

cualquierViaje :: CondicionViaje
cualquierViaje _ = True

viajesCaros :: CondicionViaje
viajesCaros viaje = ((>200) . costo) viaje

nombreLargo :: Number -> CondicionViaje
nombreLargo n viaje = ((>n). length . nombre . cliente) viaje

noVivaEn :: String -> CondicionViaje
noVivaEn zona viaje = ((zona /=) . direccion . cliente) viaje
    
-- Punto 3

lucas = Cliente { nombre = "Lucas" , direccion = "Victoria"}
daniel = Taxi { conductor = "Daniel", kilometraje = 23500, viajes = [Viaje {fecha = (20,04,2007), cliente = lucas, costo = 150}], condicion = (noVivaEn "Olivos" )}
alejandra = Taxi { conductor = "Alejandra", kilometraje = 180000, viajes = [], condicion = cualquierViaje}

-- Punto 4 -> Chofer puede tomar X viaje?

puedeTomarElViaje :: Viaje -> Taxi -> Bool
puedeTomarElViaje viaje taxi = (condicion taxi) viaje

-- Punto 5 -> Saber la liquidación de un chofer, que consiste en sumar los costos de cada uno de los viajes. 
-- Por ejemplo, Alejandra tiene $ 0 y Daniel tiene $ 150.

liquidacion :: Taxi -> Number
liquidacion taxi = (sum . map costo) (viajes taxi)
    
-- Punto 6 -> Me dan una lista de choferes y un viaje
-- a) filtre los choferes que toman ese viaje. Si ningún chofer está interesado, no se preocupen: el viaje no se puede realizar.
-- b) considerar el chofer que menos viaje tenga. Si hay más de un chofer elegir cualquiera.
tomarViaje :: Viaje -> [Taxi] -> Taxi
tomarViaje viaje  = incorporarViaje viaje . choferConMenosViajes . filter (puedeTomarElViaje viaje) 

choferConMenosViajes :: [Taxi] -> Taxi
choferConMenosViajes [chofer] = chofer
choferConMenosViajes (chofer1:chofer2:choferes) = choferConMenosViajes ((elQueMenosViajesHizo chofer1 chofer2):choferes)

elQueMenosViajesHizo :: Taxi -> Taxi -> Taxi
elQueMenosViajesHizo chofer1 chofer2     | cuantosViajes chofer1 > cuantosViajes chofer2 = chofer2
                                        | otherwise  = chofer1

cuantosViajes = length . viajes

incorporarViaje :: Viaje -> Taxi -> Taxi
incorporarViaje viaje taxi = taxi {viajes = viaje : (viajes taxi)}

--Punto 7- a) Modelar al chofer “Nito Infy”

nitoInfy = Taxi { conductor = "Nito Infy", kilometraje = 70000, viajes = repetirViaje (Viaje {fecha = (11,03,2017), cliente = lucas, costo = 50}), condicion = (nombreLargo 2)}

repetirViaje :: Viaje -> [Viaje]
repetirViaje viaje = viaje : repetirViaje viaje

--b) No se puede calcular liquidacion de Nito porque debo sumar los costos de todos los viajes y al ser una lista infinita nunca acabo
-- c) ¿Y saber si Nito puede tomar un viaje de Lucas de $ 500 el 2/5/2017? 
-- Si se puede saber si puede tomar ese viaje y cualquier otro, ya que para ello unicamente verifica el largo del nombre del nuevo cliente, por lo que
-- no nos importa si hay una lista infinita en los viajes realizados.

-- 8) Inferir la funcion gongNeng
gongNeng :: Ord c => c -> (c -> Bool) -> (a -> c) -> [a] -> c
gongNeng arg1 arg2 arg3 = max arg1 . head . filter arg2 . map arg3
