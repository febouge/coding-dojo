module Data.CommandSpec (spec) where

import Control.Exception (evaluate)
import Data.Command
import Data.Rover
import Test.Hspec


spec :: Spec
spec = do
  describe "commandFrom" $ do
    it "'F' returns Forward" $ do
      commandFrom 'F' `shouldBe` Forward
    it "'B' returns Backward" $ do
      commandFrom 'B' `shouldBe` Backward
    it "'L' returns TLeft" $ do
      commandFrom 'L' `shouldBe` TLeft
    it "'R' returns TRight" $ do
      commandFrom 'R' `shouldBe` TRight
    it "Any other char throws an error" $ do
      evaluate(commandFrom '>') `shouldThrow` errorCall "Bad command"