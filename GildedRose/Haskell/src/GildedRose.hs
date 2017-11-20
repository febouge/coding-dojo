module GildedRose where

type GildedRose = [Item]

data Item = Item String Int Int
  deriving (Eq)

instance Show Item where
  show (Item name sellIn quality) =
    name ++ ", " ++ show sellIn ++ ", " ++ show quality

updateQuality :: GildedRose -> GildedRose
updateQuality = map updateQualityItem
  where
    updateQualityItem (Item name sellIn quality) =
      let quality' = computeNewQuality name sellIn quality
          sellIn' = decreasePropertyBasedOnItemName name sellIn
      in
        if sellInIsOver sellIn'
        then
          if nameIsNotAgedBrie name
          then
            if nameIsNotBackstage name
            then
              if qualityIsGreaterThanZero quality' && nameIsNotSulfuras name
              then Item name sellIn' (quality' - 1)
              else Item name sellIn' quality'
            else Item name sellIn' (quality' - quality')
          else
            if qualityIsNotAtMaxValue quality'
            then Item name sellIn' (quality' + 1)
            else Item name sellIn' quality'
        else Item name sellIn' quality'

nameIsNotAgedBrie :: String -> Bool
nameIsNotAgedBrie name =
  name /= "Aged Brie"

nameIsBackstage :: String -> Bool
nameIsBackstage name = name == "Backstage passes to a TAFKAL80ETC concert"

nameIsNotBackstage :: String -> Bool
nameIsNotBackstage name = not(nameIsBackstage name)

nameIsNotSulfuras :: String -> Bool
nameIsNotSulfuras name = name /= "Sulfuras, Hand of Ragnaros"

isRegularItem :: String -> Bool
isRegularItem itemName = nameIsNotBackstage itemName &&
                         nameIsNotAgedBrie itemName

sellInIsOver :: Int -> Bool
sellInIsOver sellIn = sellIn < 0

qualityIsGreaterThanZero :: Int -> Bool
qualityIsGreaterThanZero quality = quality > 0

qualityIsNotAtMaxValue :: Int -> Bool
qualityIsNotAtMaxValue quality = quality < 50

itemQualityCanBeModified :: Int -> Bool
itemQualityCanBeModified quality = qualityIsNotAtMaxValue quality && qualityIsGreaterThanZero quality

decreasePropertyBasedOnItemName :: String -> Int -> Int
decreasePropertyBasedOnItemName name property =
  if nameIsNotSulfuras name
  then property - 1
  else property

computeAdditionalBackstageQuality :: Int -> Int -> Int
computeAdditionalBackstageQuality quality sellIn =
  if sellIn < 11 && quality < 49
  then
    1 + (if (sellIn < 6) && (quality < 48) then 1 else 0)
  else 0

computeNewQuality :: String -> Int -> Int -> Int
computeNewQuality name sellIn quality
  | isRegularItem name =
    if itemQualityCanBeModified quality then decreasePropertyBasedOnItemName name quality else quality
  | qualityIsNotAtMaxValue quality =
    quality + 1 + (if nameIsBackstage name
                   then computeAdditionalBackstageQuality quality sellIn
                   else 0)
  | otherwise = quality
