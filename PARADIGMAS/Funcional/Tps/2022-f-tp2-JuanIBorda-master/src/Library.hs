module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero


-- Enunciado 1: Modelar un grupo que asiste a un evento, del cual nos interesa el nombre del encargado del grupo, su edad, y las edades de los acompañantes 
-- (que puede haber cualquier cantidad).

data Grupo = Grupo {
    nombreEncargado :: String,
    edadEncargado :: Number,
    edadAcompaniantes :: [Number]
    } deriving (Eq,Show)


--Enunciado 2: Codificar una función que dado un grupo devuelva su cantidad de integrantes.
--Ejemplo: si tenemos el grupo de “pedro” de 20 años con 2 acompañantes de 18 y 16 años de edad, su cantidad de integrantes es 3.

cantidadDeIntegrantes :: Grupo -> Number
cantidadDeIntegrantes grupo =  length (edadAcompaniantes grupo) + 1 

--Enunciado 3: Codificar lo necesario para que, dados dos grupos, poder averiguar el nombre del encargado del grupo de mayor promedio de edad.
--Ejemplo: si tenemos el grupo de “pedro” visto anteriormente y el grupo de “rosa” de 19 años con 1 acompañante de 21 años, 
--cuando le pase esos dos grupos a la función debe devolver “rosa”, porque el promedio de edades del grupo de rosa es 20 mientras que el de pedro es 18.

mayorPromedioEntre :: Grupo -> Grupo -> String
mayorPromedioEntre grupo1 grupo2    | promedio grupo1 > promedio grupo2 =  nombreEncargado grupo1
                                    | promedio grupo1 < promedio grupo2 =  nombreEncargado grupo2
                                    | otherwise =  "Ambos grupos tienen el mismo promedio"

promedio :: Grupo -> Number
promedio grupo = sumaEdades grupo / cantidadDeIntegrantes grupo 

sumaEdades :: Grupo -> Number
sumaEdades grupo = ( edadEncargado grupo + sum (edadAcompaniantes grupo) )

 
--Habia creado esta funcion para sumar los valores de la Lista pero encontre una funcion que ya lo hace (sum)
--sumar :: Grupo -> Number                                                                                                          
--sumar grupo | head (edadAcompaniantes grupo) > 0 = last (edadAcompaniantes grupo) + sumar (init(edadAcompaniantes grupo))
-- | otherwise = 0




















