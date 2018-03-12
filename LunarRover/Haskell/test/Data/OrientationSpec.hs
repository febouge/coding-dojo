module Data.OrientationSpec (spec) where

import Data.Orientation
import Test.Hspec


spec :: Spec
spec = do
  describe "turnRight" $ do
    it "turnRight on North returns East" $ do
      turnRight North `shouldBe` East
    it "turnRight on East returns South" $ do
      turnRight East `shouldBe` South
    it "turnRight on South returns West" $ do
      turnRight South `shouldBe` West
    it "turnRight on West returns North" $ do
      turnRight West `shouldBe` North

  describe "turnLeft" $ do
    it "turnLeft on North returns West" $ do
      turnLeft North `shouldBe` West
    it "turnLeft on East returns North" $ do
      turnLeft East `shouldBe` North
    it "turnLeft on South returns East" $ do
      turnLeft South `shouldBe` East
    it "turnLeft on West returns South" $ do
      turnLeft West `shouldBe` South

