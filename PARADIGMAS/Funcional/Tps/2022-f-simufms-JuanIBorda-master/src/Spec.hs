module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test de rimas" $ do
    it "Ocurre rima asonante y no consonante" $ do
      riman "parcial" "estirar" `shouldBe` True
    it "Ocurre rima consonante y no asonante" $ do
      riman "función" "canción" `shouldBe` True
    it "Ocurre rima consonante y  asonante" $ do
      riman "construir" "Huir" `shouldBe` True
    it "No ocurre ni rima asonante ni rima consonante" $ do
      riman "hola" "chau" `shouldBe` False
    it "Ambas palabras son iguales" $ do
      riman "parcial" "parcial" `shouldBe` False
    
 {- describe "Test de conjugacion" $ do
    it "Ocurre conjugacion por medio de rimas y por anadiplosis" $ do
      conjugan "verso1 " "verso2" `shouldBe` True
    it "Ocurre conjugacion por medio de rimas y no por anadiplosis" $ do
      conjugan "no hace falta un programa que genere una canción" "para saber que esto se resuelve con una función" `shouldBe` True
    it "Ocurre conjugacion por anadiplosis y no por conjugacion por medio de rimas" $ do
      conjugan "este examen no se aprueba sin aplicación parcial" "parcial lindo y divertido si rendiste todas las katas" `shouldBe` True
    it "No ocurre ninguna conjugacion" $ do
      conjugan "verso1" "no" `shouldBe` False
  -}
    
 

