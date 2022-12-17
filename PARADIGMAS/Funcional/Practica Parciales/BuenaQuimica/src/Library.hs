module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

data Producto = Producto{
    descripcionTecnica :: String,
    indiceDePeligrosidad :: Number,
    componentes :: [String]
}

nafta = Producto {descripcionTecnica = "" ,indiceDePeligrosidad = 7, componentes = ["petroleo", "etanol"]}
bolitasDeNaftalina = Producto {descripcionTecnica = "" ,indiceDePeligrosidad = 10, componentes = ["petroleo", "etanol","sutil sustancia blanca"]}
paradigmetileno = Producto {descripcionTecnica = "" ,indiceDePeligrosidad = 2, componentes = ["funcionol", "logicol", "objeto"]}
escalonetina = Producto {descripcionTecnica = "" ,indiceDePeligrosidad = 99, componentes = ["acido dibumartineico", "dimariol", "depaultinina","liomessi"]}    

--Punto 1

buenaQuimica :: Producto -> Producto -> Bool
buenaQuimica producto1 producto2 = (tieneLosComponenetesDe producto1 producto2 && descripcionIncluidaDe producto1 producto2) || (tieneLosComponenetesDe producto2 producto1 && descripcionIncluidaDe producto2 producto1) 

descripcionIncluidaDe :: Producto -> Producto -> Bool
descripcionIncluidaDe producto1 producto2 = (descripcionTecnica producto1) == (descripcionTecnica producto2)
-- Si la descripcion del producto1 esta tambien en la descripcion del producto2

tieneLosComponenetesDe :: Producto -> Producto -> Bool 
tieneLosComponenetesDe producto1 producto2 = all (==True) (map (flip elem (componentes producto2)) (componentes producto1)) 
-- Verifica si los componentes del producto1 estan tambien en el producto2

--