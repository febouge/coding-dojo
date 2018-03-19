module Data.RoverSpec (spec) where

import Data.Orientation
import Data.Rover
import Data.Command
import Test.Hspec


spec :: Spec
spec = do
  describe "Rover init" $ do
    it "Rover must start at (0,0) - North" $ do
      initRover `shouldBe` Rover North (0,0)

  describe "Rover execute command char" $ do
    it "'L' command when North should turn left to West" $ do
      executeCommand 'L' (Rover North (0,0)) `shouldBe` Rover West (0,0)
      
    it "'L' command when West should turn left to South" $ do
      executeCommand 'L' (Rover West (0,0)) `shouldBe` Rover South (0,0)

    it "'L' command when South should turn left to East" $ do
      executeCommand 'L' (Rover South (0,0)) `shouldBe` Rover East (0,0)

    it "'L' command when East should turn left to North" $ do
      executeCommand 'L' (Rover East (0,0)) `shouldBe` Rover North (0,0)


    it "'R' command when North should turn right to East" $ do
      executeCommand 'R' (Rover North (0,0)) `shouldBe` Rover East (0,0)

    it "'R' command when West should turn right to North" $ do
      executeCommand 'R' (Rover West (0,0)) `shouldBe` Rover North (0,0)

    it "'R' command when South should turn right to West" $ do
      executeCommand 'R' (Rover South (0,0)) `shouldBe` Rover West (0,0)

    it "'R' command when East should turn right to South" $ do
      executeCommand 'R' (Rover East (0,0)) `shouldBe` Rover South (0,0)


    it "'F' command when North should move +1 in OY axis" $ do
      executeCommand 'F' (Rover North (0,0)) `shouldBe` Rover North (0,1)

    it "'F' command when East should move +1 in OX axis" $ do
      executeCommand 'F' (Rover East (0,0)) `shouldBe` Rover East (1,0)

    it "'F' command when South should move -1 in OY axis" $ do
      executeCommand 'F' (Rover South (0,1)) `shouldBe` Rover South (0,0)

    it "'F' command when West should move -1 in OX axis" $ do
      executeCommand 'F' (Rover West (1,0)) `shouldBe` Rover West (0,0)
      

    it "'B' command when North should move -1 in OY axis" $ do
      executeCommand 'B' (Rover North (0,1)) `shouldBe` Rover North (0,0)

    it "'B' command when East should move -1 in OX axis" $ do
      executeCommand 'B' (Rover East (1,0)) `shouldBe` Rover East (0,0)

    it "'B' command when South should move +1 in OY axis" $ do
      executeCommand 'B' (Rover South (0,0)) `shouldBe` Rover South (0,1)

    it "'B' command when West should move +1 in OX axis" $ do
      executeCommand 'B' (Rover West (0,0)) `shouldBe` Rover West (1,0)

  describe "Multiple command tests" $ do
    it "'BLRF' should leave the rover at same position" $ do
      executeCommands [Backward, TLeft, TRight, Forward] `shouldBe` Rover North (0,0)
      
    it "'BLLF' should leave the rover at South (0, 98)" $ do
      executeCommands [Backward, TLeft, TLeft, Forward] `shouldBe` Rover South (0,98)

  describe "Lunar boundaries" $ do
    it "Forward at N-(0,99) should return N-(0,0)" $ do
      executeCommand 'F' (Rover North (0,99)) `shouldBe` Rover North (0,0)
      
    it "Forward at E-(99,0) should return E-(0,0)" $ do
      executeCommand 'F' (Rover East (99,0)) `shouldBe` Rover East (0,0)

    it "Forward at S-(0,0) should return S-(0,99)" $ do
      executeCommand 'F' (Rover South (0,0)) `shouldBe` Rover South (0,99)

    it "Forward at W-(0,0) should return W-(99,0)" $ do
      executeCommand 'F' (Rover West (0,0)) `shouldBe` Rover West (99,0)
      
    it "Backward at N-(0,0) should return N-(0,99)" $ do
      executeCommand 'B' (Rover North (0,0)) `shouldBe` Rover North (0,99)
      
    it "Backward at E-(0,0) should return E-(99,0)" $ do
      executeCommand 'B' (Rover East (0,0)) `shouldBe` Rover East (99,0)

    it "Backward at S-(0,99) should return S-(0,0)" $ do
      executeCommand 'B' (Rover South (0,99)) `shouldBe` Rover South (0,0)

    it "Backward at W-(99,0) should return W-(0,0)" $ do
      executeCommand 'B' (Rover West (99,0)) `shouldBe` Rover West (0,0)

executeCommands :: [Command] -> Rover
executeCommands commands = foldl (reverseArguments execute) initRover commands

reverseArguments :: (a -> b -> b) -> b -> a -> b
reverseArguments f = \x y -> f y x
