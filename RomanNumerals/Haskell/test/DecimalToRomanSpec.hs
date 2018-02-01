module DecimalToRomanSpec where

import Test.Hspec
import Lib

spec :: Spec
spec =
  describe "decimalToRoman" $ do
  
    it "It does not accept numbers greater than 3000" $
      decimalToRoman 3001 `shouldBe` "It does not accept numbers greater than 3000"
      
    it "1 to roman" $
      assertProperConversion 1 "I"

    it "2 to roman" $
      assertProperConversion 2 "II"

    it "3 to roman" $
      assertProperConversion 3 "III"

    it "4 to roman" $
      assertProperConversion 4 "IV"

    it "5 to roman" $
      assertProperConversion 5 "V"

    it "6 to roman" $
      assertProperConversion 6 "VI"
      
    it "7 to roman" $
      assertProperConversion 7 "VII"

    it "8 to roman" $
      assertProperConversion 8 "VIII"

    it "9 to roman" $
      assertProperConversion 9 "IX"
            
    it "49 to roman" $
      assertProperConversion 49 "XLIX"
            
    it "497 to roman" $
      assertProperConversion 497 "CDXCVII"
            
    it "2356 to roman" $
      assertProperConversion 2356 "MMCCCLVI"
      
assertProperConversion :: Int -> String -> IO()
assertProperConversion decimal roman = (decimalToRoman decimal) `shouldBe` roman
