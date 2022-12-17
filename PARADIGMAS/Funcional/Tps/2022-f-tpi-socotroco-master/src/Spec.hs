module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do

  
  describe "Tests de los puntos de scoring" $ do
    it "Si tiene cantidad par de amigues, los puntos de scoring deben ser (Stress * Edad)" $ do      
      puntosScoring personaAmiguesPar `shouldBe` 250
    it "Si tiene mas de 40 anios, los puntos de scoring deben ser (edad * cantidad de amigues)" $ do
      puntosScoring personaMasDe40 `shouldBe` 41
    it "Si no se cumplen las condiciones anteriores, los puntos de scoring deben ser: (Cantidad de letras nombre * 2)" $ do
      puntosScoring rigoberta `shouldBe` 18
  

  describe "Tests de los nombres firmes" $ do
    it "tieneNombreFirme da True cuando el nombre de la persona comienza con 'P' " $ do      
      tieneNombreFirme paulina  `shouldBe` True
      tieneNombreFirme rigoberta `shouldBe` False

  describe "Test de Persona Interesante" $ do
    it "personaInteresante da True si tiene mas de un amigue" $ do
      personaInteresante rigoberta `shouldBe` False
      personaInteresante paulina `shouldBe` True
      
      
  describe "Tests de Vacaciones" $ do
    it "Si una persona va a mdq en verano gana 10 puntos de estrés" $ do
      estresPersona (marDelPlata 1 punto3Persona1) `shouldBe` 30

    it "Si una persona va a mdq pero no en verano disminuye tanto como la edad hasta un máximo de 20" $ do
    
      estresPersona (marDelPlata 3 punto3Persona2) `shouldBe` 32

    it "Si una persona va a mdq pero no en verano disminuye tanto como la edad hasta un máximo de 20" $ do
      estresPersona (marDelPlata 3 punto3Persona3) `shouldBe` 0
    
    it "Si una persona va a Las Toninas con plata disminuye el nivel de estres a la mitad" $ do
      estresPersona (lasToninas True punto3Persona5) `shouldBe` 37

    it "Si una persona va a Las Toninas sin plata es lo mismo que irse a mdq en no verano" $ do
     estresPersona (lasToninas False punto3Persona6) `shouldBe` 55
    
    it "Si una persona va a Puerto Madryn disminuye su estres a cero y hace que tengas como amigue a Juan" $ do
      estresPersona (puertoMadryn punto3Persona7) `shouldBe` 0
      length (amiguesPersona (puertoMadryn punto3Persona7)) `shouldBe` 1

    it "Si una persona va a la Adela no pasa nada" $ do
      estresPersona (laAdela punto3Persona8) `shouldBe` 80

  describe "Tests de preferencias" $ do
    it "Si la persona quiere desenchufarse y va a mdqVerano" $ do
     desenchufarse punto4Persona1 (marDelPlata 1) `shouldBe` False

    it "Si la persona quiere desenchufarse y va a mdqNoVerano" $ do
       
     desenchufarse punto4Persona2 (marDelPlata 3) `shouldBe` True

    it "Si la persona quiere enchufarse y va a mdqNoVerano" $ do

     enchufarseEspecial 20 punto4Persona3 (marDelPlata 3) `shouldBe` True

    it "Si la persona quiere enchufarse y va a mdqNoVerano" $ do
     enchufarseEspecial 20 punto4Persona4 (marDelPlata 3) `shouldBe` False

    it "Si la persona quiere Socializar y va a Puerto Madryn" $ do
      socializar punto4Persona5 puertoMadryn `shouldBe` True

    it "Si la persona quiere Socializar y va a La Adela" $ do
      socializar punto4Persona6 laAdela `shouldBe` False
      
    it "Si la persona no tiene pretensiones y va a La Adela" $ do
      sinPretensiones punto4Persona7 laAdela `shouldBe` True
  
  
  describe "Tests de Contingentes" $ do
    it "Es destino apto si todos las personas del contingente tienen preferencia por el destino" $ do
      destinoApto (marDelPlata 3) punto5Contingente1 `shouldBe` True
    it "No es destino apto si no todas las personas del contingente tienen preferencia por el destino" $ do
      destinoApto (marDelPlata 3) punto5Contingente2 `shouldBe` False

    it "Es destino piola cuando el total de estres de un contingente viajero suma menos de 100" $ do
      destinoPiola punto5Contingente1 (marDelPlata 3) `shouldBe` True
    it "No es destino piola cuando el total de estres de un contingente viajero es mayor o igual a 100" $ do
      destinoPiola punto5Contingente2 (marDelPlata 1) `shouldBe` False

  describe "Tests de estres de paquete" $ do
    it "Estres final después de ir a mdq en marzo, la adela y las toninas sin plata" $ do
      paqueteStress paquete1 gustavo `shouldBe` 50
    it "Estres final de una persona después de no ir a ningún lado" $ do
      paqueteStress paquete2 gustavo `shouldBe` 90

  describe "Test de Contingente la pasa bien"  $ do
    it "Contingente la pasa bien si alguna persona de este tiene amigos en el contingente" $ do
      algunoLaPasaBien punto6Contingente1 `shouldBe` True
    it "Contingente no la pasa bien si ninguna persona de este tiene amigos en el contingente" $ do
      algunoLaPasaBien punto6Contingente2 `shouldBe` False

  describe "Test de Contingente TOC" $ do
    it "Contingente TOC de una persona con scoring par debe ser True" $ do
      contingenteTOC punto7Contingente1 `shouldBe` True
    it "Contingente TOC de una persona con scoring par debe ser True" $ do
      contingenteTOC punto7Contingente2 `shouldBe` True
    it "Contingente TOC de un contingente con scoring par en la posición par debe ser True" $ do
      contingenteTOC punto7Contingente3 `shouldBe` True
    it "Contingente TOC de contingente con scoring impar en la posición par debe ser False" $ do
      contingenteTOC punto7Contingente4 `shouldBe` False     
-- `shouldBe`