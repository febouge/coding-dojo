{-# OPTIONS_GHC -F -pgmF hspec-discover #-}
import Test.Hspec
import Lib

spec :: Spec
spec = do
  describe "decimalToRoman" $ do
  
    it "It does not accept numbers greater than 3000" $
      decimalToRoman 3001 `shouldBe` "It does not accept numbers greater than 3000"

