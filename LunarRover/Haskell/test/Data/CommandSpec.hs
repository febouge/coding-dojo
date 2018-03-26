module Data.CommandSpec (spec) where

import Control.Exception (evaluate)
import Data.Command
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
    it "'R' returns TRight" $ do
      commandFrom 'U' `shouldBe` Undo
    it "Any other char throws an error" $ do
      evaluate(commandFrom '>') `shouldThrow` errorCall "Bad command"
      
  describe "getUndoFor" $ do
    it "getUndoFor 'F' returns Backward" $ do
      getUndoFor 'F' `shouldBe` Backward
    it "getUndoFor 'B' returns Forward" $ do
      getUndoFor 'B' `shouldBe` Forward
    it "getUndoFor 'L' returns TRight" $ do
      getUndoFor 'L' `shouldBe` TRight
    it "getUndoFor 'R' returns TLeft" $ do
      getUndoFor 'R' `shouldBe` TLeft
    it "Any other char throws an error" $ do
      evaluate(getUndoFor '>') `shouldThrow` errorCall "Bad command"
