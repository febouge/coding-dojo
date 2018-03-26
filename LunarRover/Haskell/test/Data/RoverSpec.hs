module Data.RoverSpec (spec) where

import Data.Orientation
import Data.Rover
import Data.Command
import Test.Hspec


spec :: Spec
spec = do
  describe "Rover init" $ do
    it "Rover must start at (LunarCoords 0 0) - North" $ do
      initRover `shouldBe` getRover North (0, 0) []

  describe "getRover execute command char" $ do
    it "'L' command when North should turn left to West" $ do
      executeCommand 'L' (getRover North (0,0) []) `shouldBe` getRover West (0,0) ['L']
      
    it "'L' command when West should turn left to South" $ do
      executeCommand 'L' (getRover West (0,0) []) `shouldBe` getRover South (0,0) ['L']

    it "'L' command when South should turn left to East" $ do
      executeCommand 'L' (getRover South (0,0) []) `shouldBe` getRover East (0,0) ['L']

    it "'L' command when East should turn left to North" $ do
      executeCommand 'L' (getRover East (0,0) []) `shouldBe` getRover North (0,0) ['L']


    it "'R' command when North should turn right to East" $ do
      executeCommand 'R' (getRover North (0,0) []) `shouldBe` getRover East (0,0) ['R']

    it "'R' command when West should turn right to North" $ do
      executeCommand 'R' (getRover West (0,0) []) `shouldBe` getRover North (0,0) ['R']

    it "'R' command when South should turn right to West" $ do
      executeCommand 'R' (getRover South (0,0) []) `shouldBe` getRover West (0,0) ['R']

    it "'R' command when East should turn right to South" $ do
      executeCommand 'R' (getRover East (0,0) []) `shouldBe` getRover South (0,0) ['R']


    it "'F' command when North should move +1 in OY axis" $ do
      executeCommand 'F' (getRover North (0,0) []) `shouldBe` getRover North (0,1) ['F']

    it "'F' command when East should move +1 in OX axis" $ do
      executeCommand 'F' (getRover East (0,0) []) `shouldBe` getRover East (1,0) ['F']

    it "'F' command when South should move -1 in OY axis" $ do
      executeCommand 'F' (getRover South (0,1) []) `shouldBe` getRover South (0,0) ['F']

    it "'F' command when West should move -1 in OX axis" $ do
      executeCommand 'F' (getRover West (1,0) []) `shouldBe` getRover West (0,0) ['F']
      

    it "'B' command when North should move -1 in OY axis" $ do
      executeCommand 'B' (getRover North (0,1) []) `shouldBe` getRover North (0,0) ['B']

    it "'B' command when East should move -1 in OX axis" $ do
      executeCommand 'B' (getRover East (1,0) []) `shouldBe` getRover East (0,0) ['B']

    it "'B' command when South should move +1 in OY axis" $ do
      executeCommand 'B' (getRover South (0,0) []) `shouldBe` getRover South (0,1) ['B']

    it "'B' command when West should move +1 in OX axis" $ do
      executeCommand 'B' (getRover West (0,0) []) `shouldBe` getRover West (1,0) ['B']

      
  describe "Lunar boundaries" $ do
    it "Forward at N-(0 99) should return N-(0 0)" $ do
      executeCommand 'F' (getRover North (0,99) []) `shouldBe` getRover North (0,0) ['F']
      
    it "Forward at E-(99 0) should return E-(0 0)" $ do
      executeCommand 'F' (getRover East (99,0) []) `shouldBe` getRover East (0,0) ['F']

    it "Forward at S-(0 0) should return S-(0 99)" $ do
      executeCommand 'F' (getRover South (0,0) []) `shouldBe` getRover South (0,99) ['F']

    it "Forward at W-(0 0) should return W-(99 0)" $ do
      executeCommand 'F' (getRover West (0,0) []) `shouldBe` getRover West (99,0) ['F']
      
    it "Backward at N-(0 0) should return N-(0 99)" $ do
      executeCommand 'B' (getRover North (0,0) []) `shouldBe` getRover North (0,99) ['B']
      
    it "Backward at E-(0 0) should return E-(99 0)" $ do
      executeCommand 'B' (getRover East (0,0) []) `shouldBe` getRover East (99,0) ['B']

    it "Backward at S-(0 99) should return S-(0 0)" $ do
      executeCommand 'B' (getRover South (0,99) []) `shouldBe` getRover South (0,0) ['B']

    it "Backward at W-(99 0) should return W-(0 0)" $ do
      executeCommand 'B' (getRover West (99,0) []) `shouldBe` getRover West (0,0) ['B']

  describe "Undo command" $ do
    it "Undo after forward should move the rover backward" $ do
      executeCommand 'U' (getRover West (99,0) ['F']) `shouldBe` getRover West (0,0) []
    it "Undo after left should move the rover right" $ do
      executeCommand 'U' (getRover West (99,0) ['L']) `shouldBe` getRover North (99,0) []
    it "Undo after right should move the rover left" $ do
      executeCommand 'U' (getRover West (99,0) ['R']) `shouldBe` getRover South (99,0) []    
    it "Undo after forward should move the rover backward" $ do
      executeCommand 'U' (getRover West (99,0) ['B']) `shouldBe` getRover West (98,0) []

  describe "Multiple command tests" $ do
    it "'BLRF' should leave the rover at same position" $ do
      executeCommands "BLRF" `shouldBe` getRover North (0,0) ['B', 'L','R', 'F']
      
    it "'BLLF' should leave the rover at South (0, 98)" $ do
      executeCommands "BLLF" `shouldBe` getRover South (0,98) ['B', 'L','L', 'F']
      
    it "'FFRFU' should leave the rover at North (0, 2)" $ do
      executeCommands "FFRFU" `shouldBe` getRover East (0,2) ['F', 'F','R']
      
getRover :: Orientation -> (Int, Int) -> [Char] -> Rover
getRover orientation (x,y) commands = Rover orientation (LunarCoords x y) (CommandHistory commands)
