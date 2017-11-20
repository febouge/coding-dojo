module GildedRoseSpec where

import Test.Hspec
import GildedRose

spec :: Spec
spec =
  describe "updateQuality" $ do

    it "quality degrades twice as fast if sellIn has passed" $
      testItemQualityAfterNDays [Item "Haskell Book" 0 20] [Item "Haskell Book" (-1) 18] 1

    it "decreases quality by 1 in generic items" $
      testItemQualityAfterNDays [Item "Haskell Book" 2 20] [Item "Haskell Book" 1 19] 1

    it "decreases quality by 2 in generic items after sellIn" $
      testItemQualityAfterNDays [Item "Haskell Book" (-1) 10] [Item "Haskell Book" (-2) 8] 1

    it "quality is never negative" $
      testItemQualityAfterNDays [Item "Haskell Book" 0 0] [Item "Haskell Book" (-2) 0] 2

    it "Aged brie gets better quality the older it gets" $
      testItemQualityAfterNDays [Item "Aged Brie" 10 30] [Item "Aged Brie" 8 32] 2

    it "The quality of an item is never greater than 50" $
      testItemQualityAfterNDays [Item "Aged Brie" 40 49] [Item "Aged Brie" 30 50] 10

    it "Sulfuras never has to be sold or decreases quality" $
      testItemQualityAfterNDays [Item "Sulfuras, Hand of Ragnaros" 10 30] [Item "Sulfuras, Hand of Ragnaros" 10 30] 5

    it "Backstage passes increases quality by one if sellIn is greater than 10" $
      testItemQualityAfterNDays [Item "Backstage passes to a TAFKAL80ETC concert" 15 30] [Item "Backstage passes to a TAFKAL80ETC concert" 13 32] 2

    it "Backstage passes increases quality by two if sellIn is equal or less than 10" $
      testItemQualityAfterNDays [Item "Backstage passes to a TAFKAL80ETC concert" 10 25] [Item "Backstage passes to a TAFKAL80ETC concert" 8 29] 2

    it "Backstage passes increases quality by three if sellIn is equal or less than 5" $
      testItemQualityAfterNDays [Item "Backstage passes to a TAFKAL80ETC concert" 5 10] [Item "Backstage passes to a TAFKAL80ETC concert" 2 19] 3

    it "Backstage passes drops quality to zero after the concert" $
      testItemQualityAfterNDays [Item "Backstage passes to a TAFKAL80ETC concert" 0 40] [Item "Backstage passes to a TAFKAL80ETC concert" (-1) 0] 1


testItemQualityAfterNDays :: [Item] -> [Item] -> Int -> IO()
testItemQualityAfterNDays initialInventory finalExpectedInventory daysToRun =
  let finalActualInventory = applyNTimes daysToRun updateQuality initialInventory
  in finalActualInventory `shouldBe` finalExpectedInventory
  where applyNTimes = (foldr (.) id.) . replicate
