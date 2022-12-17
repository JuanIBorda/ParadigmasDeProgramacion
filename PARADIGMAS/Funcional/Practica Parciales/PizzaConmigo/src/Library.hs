module Library where
import PdePreludat

doble :: Number -> Number
doble numero = numero + numero

-- Punto 1) 
-- a) Modelado de Pizza 

data Pizza = Pizza{
    ingredientes :: [String],
    tamanio :: Number,
    calorias :: Number
} deriving Show

individual = 4
chica = 6
grande = 8
gigante = 10

-- b) funcion cosntante GrandeDeMuzza que es una pizza que tiene “salsa”, “mozzarella” y “orégano”, tiene 8 porciones, y tiene 350 calorías.

grandeDeMuzza = Pizza {ingredientes = ["salsa", "mozzarella", "oregano"], tamanio = grande, calorias = 350} 

-- Punto 2) 
-- a) nivel de satisfaccion si tiene palmito
-- b) cantidad de ingredientes * 80, siempre y cuando tenga menos de 500 calorías, en caso contrario es la mitad del cálculo.

nivelDeSatisfaccion :: Pizza -> Number
nivelDeSatisfaccion pizza   | tiene "palmito" pizza = 0
                            | calorias pizza < 500 = ((*80) . cantidadDeIngredientes)  pizza
                            | otherwise = ((*40) . cantidadDeIngredientes)  pizza

tiene :: String -> Pizza -> Bool -- Me dice si tiene un X ingrediente una pizza
tiene ingrediente pizza = elem ingrediente (ingredientes pizza)

cantidadDeIngredientes :: Pizza -> Number
cantidadDeIngredientes = length . ingredientes

-- Punto 3)
-- Calcular el valor de una pizza que es 120 veces la cantidad de ingredientes, multiplicado por su tamaño.

valorDePizza :: Pizza -> Number
valorDePizza pizza = ((*(tamanio pizza)) . (*120) . cantidadDeIngredientes) pizza

--Punto 4) Implementar Funciones
-- Agrega un ingrediente a una pizza y agrega en calorías el doble de la cantidad de letras que tiene dicho ingrediente
nuevoIngrediente :: String -> Pizza -> Pizza
nuevoIngrediente ingrediente pizza =  (agregarCalorias (((*2).length) ingrediente) . agregarIngrediente ingrediente) pizza 

agregarIngrediente :: String -> Pizza -> Pizza
agregarIngrediente ingrediente pizza    | tiene ingrediente pizza = pizza
                                        | otherwise = pizza {ingredientes = ingrediente : (ingredientes pizza)}

agregarCalorias :: Number -> Pizza -> Pizza
agregarCalorias cantidad pizza = pizza {calorias = calorias pizza + cantidad}

-- agrega 2 porciones al tamaño. En el caso de ya tener el máximo de porciones, las mismas siguen siendo dicho máximo
agrandar :: Pizza -> Pizza
agrandar pizza = agregarPorciones 2 pizza

agregarPorciones :: Number -> Pizza -> Pizza
agregarPorciones porciones pizza    | tamanio pizza == gigante = pizza
                                    | otherwise = pizza {tamanio = tamanio pizza + 2}

{- mezcladita : es la combinación de 2 gustos de pizza, donde ocurre que la primera se le mezcla
a la segunda, es decir, los ingredientes se le suman (sacando los repetidos) y de las calorías
se le suma la mitad de la primera pizza a combinar. Por ejemplo, si mezclamos una pizza chica
de provolone con jamón con una gigante napolitana, queda una gigante napolitana con
provolone y jamón. (Sí, este punto se pensó con hambre).-}

mezcladita :: Pizza -> Pizza -> Pizza
mezcladita pizza1  = (agregarCalorias (div (calorias pizza1) 2) . mezclarPizza pizza1) 

mezclarPizza :: Pizza -> Pizza -> Pizza
mezclarPizza pizza1 pizza2 = foldl (flip agregarIngrediente) pizza2 (ingredientes pizza1)


--Punto 5)

type Pedido = [Pizza]

satisfaccionDePedido :: Pedido -> Number
satisfaccionDePedido  = (sum . map nivelDeSatisfaccion) 


--Punto 6) Modelar las pizzerias
type Pizzeria = Pedido -> Pedido
-- a) pizzeriaLosHijosDePato : A cada pizza del pedido le agrega palmito

pizzeriaLosHijosDePato :: Pizzeria
pizzeriaLosHijosDePato  = map (agregarIngrediente "palmito")

-- b) pizzeriaElResumen : Dado un pedido, entrega las combinaciones de una pizza con la siguiente. Es decir, la primera con la segunda, 
-- la segunda con la tercera, etc. (y, por lo tanto, termina enviando un pedido que tiene una pizza menos que el
-- pedido original, por el resultado de la combinación de pares de pizzas). Si el pedido tiene una sola pizza, no produce cambios. 
--Nota: En esta definición puede usarse recursividad, aunque no es necesario. pro-tip: función zip o zipWith.

pizzeriaElResumen :: Pizzeria

pizzeriaElResumen (pizza:[]) = [pizza]
pizzeriaElResumen (pizza1:pizza2:pizzas) = [mezclarPizza pizza1 pizza2] ++ pizzeriaElResumen (pizza2:pizzas)

-- c) PizzeriaEspecial 

pizzeriaEspecial :: Pizza -> Pizzeria
pizzeriaEspecial pizzaPredilecta  = map (mezclarPizza pizzaPredilecta)

pizzeriaPescadito :: Pizzeria
pizzeriaPescadito  = pizzeriaEspecial anchoasBasica 

-- d) 
pizzeriaGourmet :: Number -> Pizzeria
pizzeriaGourmet nivelDeExquisites pedido = filter ((>nivelDeExquisites) . nivelDeSatisfaccion) pedido

pizzeriaLaJauja :: Pizzeria
pizzeriaLaJauja  = pizzeriaGourmet 399 

-- Punto 7 a)

sonDignasDeCalleCorrientes :: Pedido -> [Pizzeria] -> [Pizzeria]
sonDignasDeCalleCorrientes pedido pizzerias = filter ((satisfaccionDePedido pedido <) . satisfaccionDePedido . ($pedido) ) pizzerias

-- b)
sumar :: Number -> Number
sumar = ((+2) . (+5))

-- :: Pedido -> [Pizzeria] -> Pizzeria
--mejorPizzeria pedido pizzerias = (mayorSatisfaccion . sonDignasDeCalleCorrientes pedido) pizzerias

--mayorSatisfaccion :: [Pizzeria] -> Pizzeria
--mayorSatisfaccion (pizzeria1:pizzerias)  | any (() . satisfaccionDePedido . ($pedido) )

--Punto 8

yoPidoCualquierPizza x y z = any (odd . x . fst) z && all (y . snd) z

-- Punto 9

-- Modelos de prueba
-- Pizzas
napolitana = Pizza {ingredientes = ["salsa", "mozzarella", "oregano", "tomate", "jamon"], tamanio = gigante, calorias = 240} 
provoloneConJamon = Pizza {ingredientes = ["provolone", "jamon"], tamanio = chica, calorias = 400} 
anchoasBasica = Pizza {ingredientes = ["salsa", "anchoas"], tamanio = grande, calorias = 270} 
--Pedidos
pedido1 = [grandeDeMuzza,napolitana,provoloneConJamon]